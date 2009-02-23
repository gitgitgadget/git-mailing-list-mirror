From: bill lam <cbill.lam@gmail.com>
Subject: [tig] typo in man tig
Date: Mon, 23 Feb 2009 13:41:18 +0800
Message-ID: <20090223054118.GB7435@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 06:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbTai-0007Hl-En
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 06:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZBWFl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 00:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZBWFl1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 00:41:27 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:35697 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZBWFlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 00:41:25 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1322754tib.23
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 21:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=KwYgX5BIJq08ERjqc66r4DfukOqBXj6pJrym1JN5Izw=;
        b=HnTEsx++GkfiWZifhMYpk0bRcAV0TVlmkFk65KwQbcK02eVEyUjdawCpkepX6gjx+D
         JdX54kNhvjOLyQ+fbIqy7wEV7KjiIurKZTOO7BGe8lAg21O+7Sgbh6bOH13YK9TvnKYB
         PruDuwjzQ5zpcNNVboLbgRFe4eZuZN1Xfu0Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=T++hxzKRnoDCWl6NsFcHddFEl0Kto+makmbctU6emhMPxivUXPjNtbwzRq4jd+GbLv
         3aez1fvcFUWzsUJRqFsoqM3sgM3D1qUCFN/C1VeJAKKMelTF5PcsxO3/vKqaNXAPt9r8
         m2QNz2J5PozoWEPxb+vuvpedTfWfWR2E6Bu04=
Received: by 10.110.84.3 with SMTP id h3mr5328254tib.5.1235367683512;
        Sun, 22 Feb 2009 21:41:23 -0800 (PST)
Received: from localhost (n219078081066.netvigator.com [219.78.81.66])
        by mx.google.com with ESMTPS id y3sm102752tia.23.2009.02.22.21.41.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 21:41:22 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111088>

In man tig example section,

       Examples:


           set show-author =3D yes           # Show author?
           set show-date =3D yes             # Show commit date?
           set show-rev-graph =3D yes        # Show revision graph?
           set show-refs =3D yes             # Show references?
           set show-line-numbers =3D no      # Show line numbers?
           set author-width =3D 10           # Set width of the author =
column
           set line-graphics =3D no          # Disable graphics charact=
ers
           set line-number-interval =3D 5    # Interval between line nu=
mbers
           set tab-size =3D 8                # Number of spaces per tab
           set encoding =3D "UTF-8"          # Commit encoding =20

the last variable should be commit-encoding

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9173 =E6=9D=8E=E9=A0=8E  =E9=80=81=E9=AD=8F=E8=90=AC=E4=
=B9=8B=E4=BA=AC
    =E6=9C=9D=E8=81=9E=E9=81=8A=E5=AD=90=E5=94=B1=E9=A9=AA=E6=AD=8C  =E6=
=98=A8=E5=A4=9C=E5=BE=AE=E9=9C=9C=E5=88=9D=E5=BA=A6=E6=B2=B3  =E9=B4=BB=
=E9=9B=81=E4=B8=8D=E5=A0=AA=E6=84=81=E8=A3=A1=E8=81=BD  =E9=9B=B2=E5=B1=
=B1=E6=B3=81=E6=98=AF=E5=AE=A2=E4=B8=AD=E9=81=8E
    =E9=97=9C=E5=9F=8E=E6=A8=B9=E8=89=B2=E5=82=AC=E5=AF=92=E8=BF=91  =E5=
=BE=A1=E8=8B=91=E7=A0=A7=E8=81=B2=E5=90=91=E6=99=9A=E5=A4=9A  =E8=8E=AB=
=E8=A6=8B=E9=95=B7=E5=AE=89=E8=A1=8C=E6=A8=82=E8=99=95  =E7=A9=BA=E4=BB=
=A4=E6=AD=B2=E6=9C=88=E6=98=93=E8=B9=89=E8=B7=8E
