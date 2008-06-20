From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 15:04:49 +0200
Message-ID: <237967ef0806200604s469a844l4d33301a60789c1@mail.gmail.com>
References: <20080620082034.GA24913@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jun 20 15:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9gJL-0003ip-Vk
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 15:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYFTNE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 09:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753617AbYFTNE5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 09:04:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:48747 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYFTNE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 09:04:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so749634ywe.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PfQXLma3qYxYyWOMTU03C8i3WkR62KaCpqadA6PbE1Y=;
        b=AHiwGE8HZ8a+9kHdOcypZQQ/CS1TTIioyMxsg9oDTntnhJhQ8OtcVXb88hijG/2JAJ
         mAJ7D/w3qZqBPDgcFbf7bktRYa1SeYAIg5bXHEtPosGffUY89N6y/bMrWSndR3Epj+Wm
         1mgtXvAWok/eVOWENR5xMa/S+iEUC8VL/3tY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fWOT0uIo8G/FO9zM8WPybTpt1dBzaWuiD22tCfmrxM0JcVafSdoQ3+DzaFn/4i1DU/
         fSlbsUi+sJJSoFKw5s7eIerDQWuWL0iom56kReuHyxGqPrB67m5mKtUT7R6yEGnZrSyT
         fVq23HS8R9D7gD4YZ0mO+G9QEgCeEU1tCNVsM=
Received: by 10.141.177.2 with SMTP id e2mr7456068rvp.268.1213967089808;
        Fri, 20 Jun 2008 06:04:49 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Fri, 20 Jun 2008 06:04:49 -0700 (PDT)
In-Reply-To: <20080620082034.GA24913@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85638>

2008/6/20 Ingo Molnar <mingo@elte.hu>:
>
> A couple of stupid Git questions (using git-1.5.4.3-2.fc8).
>
> Sometimes i want to see the reverse diff of a particular commit.
>
> If i want to see the normal diff i do:
>
>   git-log -1 -p 7def2be1

git show 7def2b1 is a bit easier to type.

-- 
Mikael Magnusson
