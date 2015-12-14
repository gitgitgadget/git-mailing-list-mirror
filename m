From: johan defries <johandefries@gmail.com>
Subject: compile error in Git v2.7.0-rc0
Date: Mon, 14 Dec 2015 21:28:52 +0100
Message-ID: <CALibRqFajuBuv9ooaBWL1kUzaVps2WfodqucyHni2ggv6JpwDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitter.spiros@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 14 21:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Zjv-0001PN-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbbLNU2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2015 15:28:54 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33682 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbbLNU2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 15:28:54 -0500
Received: by lfap203 with SMTP id p203so61598353lfa.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7eWismtKld4bZuZxN87TyYUaFz6GWFhYFvWFtFqC48M=;
        b=nt+hFtXk4Pcz99KSe2YU9ZrNfUYpbu14mRU/UAPn4m4ymuvCnGUov3gn/zyx9vPMo2
         OBP+5E43BhrCkEILa1FAdZlGPdv1piRMESJ1wckFJJcw5NRaS3TuAxbn6PZ8S+blEDWN
         fzlGCbwdzPXhpPeifx1oCG3pi/Je4Wb9yXXKYHpiyJk9FEVr9TlWA2SDSowko9FdIkJz
         lo+1N1tnXZ7kOfyebfw8+6SR2obSs20f0WMkCIKfjjLPV0RczFVjXjQZNQmbPWYh80xF
         Wd8W+uBAIOpPI6+Lbzua37uNxcuMwbafXgHEE5eULJK0vi0Y+RP+bZpPGht5OLYhnjkM
         lqyA==
X-Received: by 10.25.146.201 with SMTP id u192mr15133093lfd.14.1450124932632;
 Mon, 14 Dec 2015 12:28:52 -0800 (PST)
Received: by 10.112.57.16 with HTTP; Mon, 14 Dec 2015 12:28:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282400>

Probably because I have NO_IPV6 defined.

ident.c: In function =E2=80=98canonical_name=E2=80=99:
ident.c:89:37: error: =E2=80=98buf=E2=80=99 undeclared (first use in th=
is function)
  struct hostent *he =3D gethostbyname(buf);
                                     ^
ident.c:89:37: note: each undeclared identifier is reported only once
for each function it appears in
make: *** [ident.o] Fout 1
