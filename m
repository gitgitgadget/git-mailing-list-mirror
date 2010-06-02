From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Makefile: Use $(sharedir)/gitweb for target 
	'install-gitweb'
Date: Wed, 2 Jun 2010 20:19:04 +0530
Message-ID: <AANLkTinIaY65N_DyDq6RrS6AyLeksL_ZfiawwDZySzB3@mail.gmail.com>
References: <1275405080-17326-1-git-send-email-pavan.sss1991@gmail.com>
	<201006012150.02970.jnareb@gmail.com>
	<7vfx16qcmm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 16:49:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpFp-0006p5-GQ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 16:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021Ab0FBOtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 10:49:07 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:44588 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab0FBOtF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 10:49:05 -0400
Received: by ywh9 with SMTP id 9so5062287ywh.17
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cc7ZNmh1XJmWeEPHfC9XTHgGZnB9lHqeu8R9g0In2wU=;
        b=YWW2G7mEPvCFzLssBcSEfGmqDiQol2If7E/pnIsA2f8MJOpjhjmr3A0sXly2N6Df3p
         V9k6xOEU9zy22vuYEc8aUkB8rhJLczpL4RzZnAou+9oMS2BmY4Oq3hGdsylH4xClcJh2
         iwd9K0wBDKGxtHus4OIamJ129xcWExSf22v7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rcAZwYxhhtucsgZSb5ZRyZJC9VULlvWhBZKkM835Gh7hWs5y06fj+Al0kCc7aEoxm1
         znNPs/1wR8CaW2raH34e3Q8G+iIkEBVA0ylBDYJ//hhtm7okj4BRrgZVyFxDGOmsXSQF
         Ctz31caPu6ruCQxqLcpDQhf7QtzJ5rYxPe5gI=
Received: by 10.101.129.17 with SMTP id g17mr8810186ann.101.1275490145033; 
	Wed, 02 Jun 2010 07:49:05 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Wed, 2 Jun 2010 07:49:04 -0700 (PDT)
In-Reply-To: <7vfx16qcmm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148256>

>
> I am wondering if we would also want to do something with this line
>
> =A0 =A0gitwebdir ?=3D /var/www/cgi-bin
>
> in gitweb/Makefile. =A0This is orthogonal to the patch under discussi=
on
> does, though.
>
>

Well, Let us say that we use /var/www/cgi-bin as default if user
downloads only gitweb and install it.
If he is installing git, then gitweb needs to be installed in
$(sharedir)/gitweb. Putting it as default in main Makefile is
supported.

So, It won't be orthogonal to the patch.

Thanks,
Pavan.
