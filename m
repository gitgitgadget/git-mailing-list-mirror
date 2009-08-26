From: Jeremy O'Brien <obrien654j@gmail.com>
Subject: Re: What IDEs are you using to develop git?
Date: Wed, 26 Aug 2009 00:24:50 -0400
Message-ID: <A3A5440E-75F0-4812-A40D-708A0B54E00F@gmail.com>
References: <000001ca257d$b60326c0$22097440$@com>
Mime-Version: 1.0 (iPod Mail 7A341)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "<git@vger.kernel.org>" <git@vger.kernel.org>
To: =?utf-8?Q?Frank_M=C3=BCnnich?= <git@frank-muennich.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 06:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgA5U-0006Yp-8o
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 06:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbZHZEZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 00:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZHZEZx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 00:25:53 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:58049 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZHZEZw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 00:25:52 -0400
Received: by an-out-0708.google.com with SMTP id d40so5921139and.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=A8tqoZSY0NSEhNv/hUab0S2ii3tiHUGObeIpWH9/+SA=;
        b=wfHi9mCPlzZy+8XYp/l3NmYScc3Y9WlqCpQTeti5i0wIop2/7qgw9Q1GGFaZIcsObD
         7WXtXlUyMIoOuMIesNlm9YevoJddd/JNUuCUOpBZ045ATXd162U5xKYxD473ptNSHT5g
         mem/Y6/rMFEXqmLYYIaGP2YCjlGhl4QucMRB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=RuweMf6Rhy+fqe8ERuzf07yos8omyp9ncy4rXWk89z2V2q2EsSy3SQBX2EZ1OPaA1l
         CgwIpRLkcy31eib+yjC7wovN+aGA8IZIluOplSm/ttB9uhhypwTMiGcZDbb4OQoJyixy
         Um4YhLK2fslFJk6Y2rOaNY2vAQenOKE/12ulI=
Received: by 10.100.17.27 with SMTP id 27mr6917261anq.199.1251260753883;
        Tue, 25 Aug 2009 21:25:53 -0700 (PDT)
Received: from ?10.1.1.249? ([74.83.234.240])
        by mx.google.com with ESMTPS id 20sm261683yxe.2.2009.08.25.21.25.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 21:25:51 -0700 (PDT)
In-Reply-To: <000001ca257d$b60326c0$22097440$@com>
X-Mailer: iPod Mail (7A341)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127063>

Vim (or gvim if I want better colors), and cscope. Cscope + vim is a =20
killer combination that enables you to fly around projects of any size =
=20
very efficiently. I swear by it. I use it at my job to navigate a =20
project consisting of over 14000 lines of code. It makes tracing =20
execution and navigating a project child's play.

Hope that helps,
Jeremy

On Aug 25, 2009, at 8:15, Frank M=C3=BCnnich <git@frank-muennich.com> w=
rote:

> Hi there,
>
> I am interested in helping out and improving git, though I haven't
> programmed in C for quite a while now and thus have to relearn quite =
=20
> some
> things.
> I understand the different branches (master, next, pu) and so on, =20
> and were
> successful in compiling git with my Ubuntu 9.04. [yeea] ;)
>
> One thing I would like to ask you: what, if any, IDEs are you =20
> working with?
> I tried Anjuta but were unsuccessful in importing the git folder =20
> from any
> branch into Anjuta. Eclipse worked a bit better, though I am still =20
> batteling
> with the debugger a bit.
>
> Any recommendations, manuals or how-to tips are greatly welcome.
> And one thing: thank you for your effort! Git really caught my =20
> attention and
> I was so much amused by the Google-Techtalk that Linus gave about =20
> Git, that
> it sparked my interest in relearning how to program again ;)
>
> Best regards from lovely Dresden in Germany
> Frank M=C3=BCnnich
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
