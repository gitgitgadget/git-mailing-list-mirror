From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix t3700 on filesystems which do not support question marks in names
Date: Fri, 15 Aug 2008 09:23:09 +0200
Message-ID: <81b0412b0808150023sd30559fi68ff1e439013f26e@mail.gmail.com>
References: <81b0412b0808150011r534d8453yab2a5c42b255657f@mail.gmail.com>
	 <7vproabvcr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Kevin Ballard" <kevin@sb.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 09:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTtfT-00070X-3O
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 09:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYHOHXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 03:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYHOHXL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 03:23:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:52456 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYHOHXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 03:23:10 -0400
Received: by wa-out-1112.google.com with SMTP id j37so441234waf.23
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Vyd4EXSE3ZWS/TqjUwiKmXaNKroPWlIlAfcuYHvIYxc=;
        b=cM/4lTz5VC8YSf5DSove+yD/I/4puHzUSDUcKh4lRKBG8JD0LYM+XwDPLPFlWaXMVM
         G44F8p3geygIrLla0kZkLd2ENO+uxF6MCEM2N11QVETreQ80rixyQu7Xo3avneXx7YqB
         BhH9WM6L+EhMxbKpMdXrI1NetcbQQ319kYDg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tG48wKCEHTk5UqFFJFyrrZAP3WCaM5moRb4foXdklgGxzWE9cwF6R9+Y8V5lXlnRhu
         skTVI0zVoqJQlO6iW22HLIo+pvNEc8Gp+iYRrh4QDSBJwZfHKq5jvo1GHMeEoI9oSIn0
         tHVMWH4tVwH6KzBWHOl4y3EOv3PB7PV7HBTOE=
Received: by 10.114.198.1 with SMTP id v1mr2198367waf.64.1218784989861;
        Fri, 15 Aug 2008 00:23:09 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 15 Aug 2008 00:23:09 -0700 (PDT)
In-Reply-To: <7vproabvcr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92462>

2008/8/15 Junio C Hamano <gitster@pobox.com>:
>> And the prominent example of the deficiency are, as usual, the filesystems
>> of Microsoft house.
>
> Can other glob specials such as '*' or '[' be used instead of skipping the
> test?

Ah... The brackets are allowed.
