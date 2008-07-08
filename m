From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-submodule - register module url if adding in place
Date: Tue, 08 Jul 2008 19:59:42 -0400
Message-ID: <4873FF6E.2020602@gmail.com>
References: <1215484630-3784-1-git-send-email-mlevedahl@gmail.com> <alpine.DEB.1.00.0807081332580.4319@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGN6x-0001V5-L2
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbYGHX7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 19:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbYGHX7q
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:59:46 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:53746 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbYGHX7p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:59:45 -0400
Received: by yx-out-2324.google.com with SMTP id 8so718179yxm.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dwYBC+sE/xsLrlYp/mA/9SwEAoANFUgGJUxxxvtUPh8=;
        b=fomBM3u9HcwQBpLrVaknxxxiYcZy6J7yUtN9TIjuQyJOGXXSQGh+E6uE0ij2yFT6d7
         P1IR9LKo1eGpoF235BY2pVUwrozLdOMMi5rZaIB+wMUAfpK9LSrunAPlfH3kwyKq6dXz
         l0V8V73h8AltkKIkx0NSOwkJ6M9FJ/eHXKtZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MNKNPniNpKbXz7N5z8Fx/i+9yO3AvJuwws2wIy7/+VJMlKdhzvL4GFH7qzxUBjLscz
         9j4ADPxdPlqkZTERyoWqza0PrcN0Pw+vVjIwcEIJRTDwZHP7RnFQ1GoSgIEEGzujw5eU
         kFIAVBZx1lpZMCAeCVk/jMHprW3DVD4kcZZMo=
Received: by 10.150.202.8 with SMTP id z8mr11333383ybf.2.1215561585082;
        Tue, 08 Jul 2008 16:59:45 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 6sm7977693ywn.0.2008.07.08.16.59.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 16:59:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0807081332580.4319@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87814>

Johannes Schindelin wrote:
> I agree with Sylvain here, namely that this is too dangerous.  Imagine 
> this very valid scenario:
>
> 	$ git clone <somewhere> abc
> 	$ git submodule add abc
>
> Bummer.
>
> Yes, happened to me.
>
> So I'd like this to be an error, not something that tries to be helpful, 
> when it clearly cannot be.
>
> Ciao,
> Dscho
>
>   
I think the real issue here is that submodule-add is too flexible and 
poorly documented, see my response to Junio in the other thread.

Mark
