From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Tue, 07 Jun 2016 21:32:35 +0100
Message-ID: <87fusopwnw.fsf@freja.aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com> <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name> <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com> <87fuwnd4u7.fsf@freja.aidecoe.name> <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com> <877fhwd1g0.fsf@freja.aidecoe.name> <xmqqegc33oal.fsf@gitster.mtv.corp.google.com> <CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com> <871t83cfi7.fsf@freja.aidecoe.name> <CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com> <87si0cpnpn.fsf@freja.aidecoe.name> <CAE5ih7-q_PwF-T6nsu=FyyN9wO6o0Jcfkg=gKy5mhOXRGFZ+VA@mail.gmail.com> <xmqqtwj6mmtu.fsf@gitster.mtv.corp.google.com> <87d1pt5k53.fsf@freja.aidecoe.name> <xmqqfuupji4m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:02:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAO8w-0008Li-75
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbcFGVCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:02:25 -0400
Received: from jim.zolnowski.name ([188.116.54.122]:50095 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932941AbcFGVCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:02:24 -0400
X-Greylist: delayed 1774 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 17:02:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From; bh=lNlRCqX8sxoDWppbO6XRj+V7/SkNmlfErorEf4y1zqg=;
	b=j5h4fxSbhI4wPkDYs9BbDHjhKYnIC/G1cOemwRqAOdAZZUa/ThRvqZUigz8jAhxE8mo/CNXKalU2tYTyUmFJQN+4XaBs2CGypSlmLcIGsLegp9xHZ9aoF/nJwluDQ82j/4+DcvRNEfhSuHE8RmR+Q8NbvFgwjPc1iT4TNS0sEOqtCZUTkooYe50dJM4SiHsUeXeMn8S2YzAMfp4C1fGR/UfETitZfSRhc/P/3fqCq8Wiwe6E3tKAskaqiKzXxsPmKbESI5RNrCVsO1FwrQqRrIq+Iqe9kbHYwNQpJiMUwaTrhgIwQ40e8bZm+5AUKcgl3XQSOUO76LiH2CR+zjovig==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1bANg1-0000Xe-RW; Tue, 07 Jun 2016 22:32:42 +0200
In-Reply-To: <xmqqfuupji4m.fsf@gitster.mtv.corp.google.com>
User-Agent: Notmuch/0.22 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296722>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name> writes:
>
>>> Has anything happened to this topic after this?  I am wondering if I
>>> should discard the topic az/p4-bare-no-rebase without prejudice.

I think you can discard the topic, because we're moving away from
Perforce and while I have tested my original patch I haven't found time
to change it to --skip-rebase option as suggested and test it.

Thanks,
=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iQJ8BAEBCgBmBQJXVy9jXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCMzcyRTFENjI5NUM1MzYwQTQwODQyRUZD
QkNDODAyM0Y1OUUxNzA0AAoJEMvMgCP1nhcE95oP/Rz8IJbfzlVdm/6qdcGefQYY
3MhfZztFNyN7KiicLu5qbpNm+49R7efTQ9ca+88CcUMaeCg3WWzeaKhN0uBrDXg9
gumkFFgReRIjpx6LloyGAWbW3RAfAV1sSwxG1GmoGWLuzd1QSyoBrWLfEFlz3ho/
CKAwGND06YRpT66P7RiwqV4PrKwcbE/Vue5rSd30uxZBUlJ+MWpsP91zAlm48sJc
IH9vYDi8C10T4rSunA/vlcq0s86iMJsWIjy/uf8saug8+vR34j2viMXlCPYM+9Bf
fzKrwWiDQ8vpx6NoH8gKViofuAoA2qSM9wWKt9R5TnhOko6xVC5oKH73PSFuVCIv
QebpNwfr/20BwVKLBq8d47+d41o87Z8fMS0SD0eoPk2z3zX8Wp+6QTn/FwZ3XZ4o
ROTMUVCU54mLm2Z/5m/klUO6zVzXwX6dMnfyaVMgTUqWy2mg8iT/97DddYwylha6
qJ6ytC0sCfDBCtt6PPxYPms+Jj2uBiMpfhVcGmrSaFsYiEFtPR9LEiXXEQD50yMr
drn8oPFSZ3bY7s5JYpzVipvycJPB5rg6EPjuu+li97MlEGu2cjjgCb6NUx/OtWse
mpmksrMK4tE1Ufg0XuScVU1Mh7DobF9Cu7dTyvqsfkygEJRQkIx7JunpJHvJKiW+
5FRkYzpEHZiAlVMvXjyF
=BF+o
-----END PGP SIGNATURE-----
--=-=-=--
