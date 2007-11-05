From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Mon, 5 Nov 2007 16:26:36 +0100
Message-ID: <5C7AE6D3-5846-4E04-85CA-75B6C2108504@wincent.com>
References: <472CC676.3000603@gmail.com> <7vabpvx8uu.fsf@gitster.siamese.dyndns.org> <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com> <472F3212.4090800@gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 16:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip3r4-0000Mf-KB
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 16:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXKEP04 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 10:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbXKEP04
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 10:26:56 -0500
Received: from wincent.com ([72.3.236.74]:45441 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXKEP04 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 10:26:56 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA5FQb9r010048;
	Mon, 5 Nov 2007 09:26:38 -0600
In-Reply-To: <472F3212.4090800@gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63522>

El 5/11/2007, a las 16:09, Francesco Pretto escribi=F3:

> Wincent Colaiuta ha scritto:
>>
>> using the administration tools designed for managing access, just =20
>> like
>> every other SCM (and every server, and every piece of software =20
>> which can
>> be accessed by many on a multi-user system).
>>
>
> I don't agree in general: in SCMs and other multi-user softwares, =20
> the access
> control configuration can be safely postponed just because it's in =20
> their
> standard usage pattern that the access should be conditioned by a =20
> daemon
> to be configured later. It's not the case of git, just because git =20
> is very
> tied to *nix permissions.
> But as it is now, it could seems that it's good to put committers in =
=20
> the (for
> example) git group, just because you have a git administrative accoun=
t
> git:git . This is caused, imo, by the fact that the flow of creating =
=20
> a shared
> repository for a specific work/project group with git-init run by an
> administrative user (as it should be) is something like this:
>
> 	- Do it wrong;
> 	- Fix it immediately.
>
> I don't like the "Do it wrong" part. I'm trying to produce a sane and
> transparent patch to implement the selectable group just in case of =20
> repository
> first initialization. Why do I care so much of first time users? =20
> Dunno, but
> I think it's important.

What's stopping you from using "sudo -u"?

Wincent
