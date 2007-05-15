From: "Paolo Teti" <paolo.teti@gmail.com>
Subject: Re: [PATCH] Fix signedness on return value from xread()
Date: Tue, 15 May 2007 14:48:43 +0200
Message-ID: <34a7ae040705150548l666cdff8o5fe34a1366cec013@mail.gmail.com>
References: <34a7ae040705150447k2e770b5ag3629632f61b813a0@mail.gmail.com>
	 <200705151439.25871.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 15 14:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnwSQ-0000iJ-O1
	for gcvg-git@gmane.org; Tue, 15 May 2007 14:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694AbXEOMsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 08:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758990AbXEOMsp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 08:48:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:61310 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694AbXEOMso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 08:48:44 -0400
Received: by nz-out-0506.google.com with SMTP id r28so123922nza
        for <git@vger.kernel.org>; Tue, 15 May 2007 05:48:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eN4CHjMlwd+HyzmFu9RG2V8tc4S+q7n8XLNUa/2lnMD+4QoJg1Tgt/JcdsDn/UpLrFsFl8DngrXP4uClLwyEgp9k4f7HbO4Htc5Jcau66g5aRiSbOxFIrsn87llu9HNaupWi7tk8h2fn9gTdODCd/MLKuv6c0dBxTrO9uXosf0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pq6ZAQNbQTVSoqwQCj4MH/vpTN9ScETI9ENZmenLuMVsMXzZ2SwegQBoK+/KmCaoMESwW4of5YTNCYPm/MtysTgOz42a1LE1kUEju1LartA0cXm+cpNSI+QUNinJshi9xC6ScgnDqkgOmwYZiAiKJ07oOqpw8lPZIU44lzgZ1U0=
Received: by 10.115.54.1 with SMTP id g1mr1552316wak.1179233323569;
        Tue, 15 May 2007 05:48:43 -0700 (PDT)
Received: by 10.115.58.17 with HTTP; Tue, 15 May 2007 05:48:43 -0700 (PDT)
In-Reply-To: <200705151439.25871.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47342>

2007/5/15, Johan Herland <johan@herland.net>:
> Using this as an opportunity to get used to sending patches... :)
>
> Is this what you were looking for, Paolo?
>

Yes Johan your patch fixes the bug.

Thanks
