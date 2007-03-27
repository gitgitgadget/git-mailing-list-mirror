From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 11:38:51 +0200
Message-ID: <38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
	 <7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 11:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW88o-0000CW-Iw
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 11:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbXC0Jiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 05:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbXC0Jiz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 05:38:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43740 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbXC0Jix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 05:38:53 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1830038uga
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 02:38:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oZGCdwzU4LImFcJvysOBDsZB/rz9un/wtYbfzorcU6kXnrNnnVSNS3c25yp2rnU3gaRDB/EiPuL3cUDal+wxJTEQC3kNQHFsr5snY5GPyfz4BGRrTmzQ5LerBRD9SIvBTjdTC3dO9QCg/Naqpts0R/zyfrcFu55te5le8aes68A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kWuD9yGlIJqa1euM+vr0HwhV1kP05t2ZNBbpmv+wqEU4RI0eV9nX2Y/i+IL+CKtJ4bl2uslatcLsAirO+CivviZmubmURGlKzBt0/nz4nsjHsW0mfGzzT7sivNcBsaPfw9PJkuUIbuEKSyC70isp2eo6iJEcn1U69o9r9cJhZg8=
Received: by 10.115.107.1 with SMTP id j1mr3085674wam.1174988331673;
        Tue, 27 Mar 2007 02:38:51 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Tue, 27 Mar 2007 02:38:51 -0700 (PDT)
In-Reply-To: <7vwt14wd38.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43242>

On 3/26/07, Junio C Hamano <junkio@cox.net> wrote:
> > [alias]
> >       send-email = send-email --no-signed-off-cc --suppress-from
> >
> > Is it failing because git-send-email is an external command ?
>
> $ sed -ne '/^alias\.\*/,/^$/p' Documentation/config.txt
>

That said I think it's not really convenient. I'll end up doing:

[aliases]
    my-send-email = send-email --no-signed-off-cc --suppress-from
    my-am = am -3 -s

etc...

Isn't possible to mimic bash alias handling:. From man: "Aliases are
not expanded when the shell is not interactive,... "

IOW is it possible for git to know if it has been invoked interactively ?

thanks
-- 
Francis
