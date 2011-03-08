From: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
Subject: gitosis configuration question
Date: Tue, 8 Mar 2011 13:46:49 -0500
Message-ID: <AANLkTik1WFacXcxrWP3RQ26rXCaQphT1H-CAwKEz6Gx8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 19:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px1vs-0001x0-CG
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 19:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab1CHSqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 13:46:51 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40409 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1CHSqu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 13:46:50 -0500
Received: by vxi39 with SMTP id 39so4969018vxi.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 10:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=r+jCFaQkV3hS+Kua2qgWqVaQ9z5Qjp9VSp6vs6BLUrw=;
        b=Y6WOEqm/Tf6X/2JnJrgaByXQvb1Y7+ZBVEzu46BvkIQzVkJFrtv0L2z48UBkFVDpKj
         TDUPX5Kr4uGzCHSCedVG0bZZbGOQDHRH3lPlX/hbIVAOp0T4eU7Ovu7f8QswGjxzKJW7
         k17i3NFUVaa/ozKcT/syIOC5UQO5sHPGrQMJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QKZ/kH+Yl5XeaFK8Xb4Iid6SO+2LgCJkr9zSVoamSwyscrEmCYWkJa4zVVnFk0qRHi
         AotnsFwCdRpVjPwLwgXsv4d0ybr/fRirtj4lbih1S8+dx0E+SXXTwUthhz5jGOgdYwwz
         B5fB499FVOBrHRf9YRe7jaRr81uSrWSy25qOw=
Received: by 10.52.180.102 with SMTP id dn6mr611091vdc.38.1299610009502; Tue,
 08 Mar 2011 10:46:49 -0800 (PST)
Received: by 10.52.158.9 with HTTP; Tue, 8 Mar 2011 10:46:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168672>

When setting up gitosis, I want to have multiple repos available for a
particular group. However, the list of repos is too big for a single
line. The example.conf does not indicate if this is allowed.  That is,
the example that it gives is

[group mygroup]
members =3D Bob Carol Ted Alice
writable =3D base cover pot lid

Is the following allowable?

[group new group]
members =3D Bob Carol Ted
members =3D Alice
writable =3D base
cover
pot
lid

Of course the actual list is much larger.

Also, from the example, would the following be allowed

[repo cover]
members =3D Bob Carol Ted Alice

Does the last example make the repo cover writable to that group?


--
=C2=A0 =C2=A0 =C2=A0=C2=A0 Sabba=C2=A0 =C2=A0=C2=A0 -=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -=C2=A0 =C2=A0=C2=A0 Hillel
Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore"
=C2=A0SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
http://sabbahillel.blogspot.com
