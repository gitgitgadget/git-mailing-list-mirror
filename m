From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 18:20:27 -0500
Message-ID: <5362d6bbbf707_12fe14dd310ab@nysa.notmuch>
References: <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0Re-0005Ck-AG
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbaEAXbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2014 19:31:09 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62177 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbaEAXbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 19:31:07 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so1807357oag.40
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=6e7O5NXfdDJVKatZqG8FHltAbicZJ6Bdoxoi0x3vefY=;
        b=0nddRqvGhaJa0dF06ePR89EVCZsr+RWFPoqCpk1Rbtj7SVeus+Y9eVhcouhig9ZY2a
         zdSiWjsfbrgEKFRxgAqUfqAWFipsFIMRj2mhobAMOwqa7DekR+JdXhojJ/+qswVgxZAa
         iRnWv6S4IeJocoQZ7GJMcu47vX7i6DHx6z1Cl74T78z6L18b1gB9J0eDLZSrNmEo4mJW
         Kgs136Om5IcG27Cqma3tQ46/DScrWpswL3qOozPSbbd5DnZ1kLWHr9Sf7+rui2xp+6qt
         aYKbj4dKDtdPcUs0WLKlT2QhL8Y+DUkj6Ad1lxMitg1N5JkopDHu28hMIBciLTgFjeqh
         Z9hQ==
X-Received: by 10.183.3.102 with SMTP id bv6mr12413704obd.18.1398987067232;
        Thu, 01 May 2014 16:31:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm36844976oeb.3.2014.05.01.16.31.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 16:31:05 -0700 (PDT)
In-Reply-To: <20140501194846.GA6227@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247893>

W. Trevor King wrote:
> On Thu, May 01, 2014 at 02:16:50PM -0500, Felipe Contreras wrote:
> > The only problem would be when it's not desirable, however, that's =
a
> > problem of the user's ignorance, and the failure of the project's
> > policity to communicate clearly to him that he should be running
> > `git merge --no-ff`. There's absolutely nothing we can do to help h=
im.
>=20
> I think =E2=80=9Cuser ignorange=E2=80=9D is the *only* problem with g=
it pull.

That, and the fact that 'git pull' does something wrong by default.

> > The only thing we could do is not allow fast-forward merges either,=
 in
> > which case `git pull` becomes a no-op that can't possibly do anythi=
ng
> > ever.
>=20
> My interest in all of the proposed git-pull-training-wheel patches is
> that they give users a way to set a finger-breaking configuration tha=
t
> makes pull a no-op (or slows it down, like 'rm -i =E2=80=A6').  Then =
folks who
> compulsively run 'git pull' (e.g. because SVN habits die slowly) can
> set an option that gives them something to think about before going
> ahead and running the pull anyway.  The space in 'git pull' makes a
> shell-side:
>=20
>   $ alias 'git pull'=3D'echo "try fetch/merge!"'
>=20
> solution unfeasible, and clobbering /usr/libexec/git-core/git-pull
> seems a bit extreme.

What is wrong with 'git pull' doing a merge when it can be fast-forward=
?

--=20
=46elipe Contreras