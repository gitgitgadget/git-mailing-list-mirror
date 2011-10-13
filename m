From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t5403.1: simplify commit creation
Date: Thu, 13 Oct 2011 14:54:11 +1100
Message-ID: <CACsJy8DuJzW-=86FOs8F4YqhG68dEzx4790vpM3D9yPfeV87qA@mail.gmail.com>
References: <1318412105-13595-1-git-send-email-pclouds@gmail.com> <4E95A0BF.2060003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 05:56:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RECPQ-0006cH-Be
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 05:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1JMDyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 23:54:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40740 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1JMDym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 23:54:42 -0400
Received: by bkbzt4 with SMTP id zt4so875673bkb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=a1SpFmuqm9lNmzbhT9EzsIcO48T4k4pTDUPtv8Yi7u4=;
        b=r6zRyN/Od94dycaKgRFf1opRIUdFPIjw1hcYDuEBPBfWprw7mS7GuAA6Qo84zMRcVm
         xOW6g6DQBJdMFxledLNgfX6oFquAAaEbORM2CA7fB3iCCTWcZz9H8Eh+uEqXHk/dpoX3
         OCiJLfWQU2Vjq7xMlVEGsol3cmklRBa8peeGk=
Received: by 10.204.133.77 with SMTP id e13mr1041491bkt.94.1318478081130; Wed,
 12 Oct 2011 20:54:41 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 12 Oct 2011 20:54:11 -0700 (PDT)
In-Reply-To: <4E95A0BF.2060003@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183436>

2011/10/13 Johannes Sixt <j.sixt@viscovery.net>:
> Am 10/12/2011 11:35, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> =C2=A0test_expect_success setup '
>> =C2=A0 =C2=A0 =C2=A0 echo Data for commit0. >a &&
>> =C2=A0 =C2=A0 =C2=A0 echo Data for commit0. >b &&
>> - =C2=A0 =C2=A0 git update-index --add a &&
>> - =C2=A0 =C2=A0 git update-index --add b &&
>> - =C2=A0 =C2=A0 tree0=3D$(git write-tree) &&
>> - =C2=A0 =C2=A0 commit0=3D$(echo setup | git commit-tree $tree0) &&
>> - =C2=A0 =C2=A0 git update-ref refs/heads/master $commit0 &&
>> + =C2=A0 =C2=A0 git add a b &&
>> + =C2=A0 =C2=A0 git commit -m setup &&
>> =C2=A0 =C2=A0 =C2=A0 git clone ./. clone1 &&
>> =C2=A0 =C2=A0 =C2=A0 git clone ./. clone2 &&
>> =C2=A0 =C2=A0 =C2=A0 GIT_DIR=3Dclone2/.git git branch new2 &&
>
> I don't think this change is necessary. It doesn't hurt to use plumbi=
ng
> commands here and there in the test suite to exercise them to a degre=
e
> that they deserve.

I'm fine either way, for the record.
--=20
Duy
