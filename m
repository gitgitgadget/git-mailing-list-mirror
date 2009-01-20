From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 09:12:13 +0100
Message-ID: <200901200912.14432.brian.foster@innova-card.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com> <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com> <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Reece Dunn" <msclrhd@googlemail.com>,
	"git list" <git@vger.kernel.org>
To: "Dilip M" <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 09:14:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPBkT-0002gj-FB
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 09:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZATIMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 03:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753726AbZATIMu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 03:12:50 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:39642 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZATIMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 03:12:49 -0500
Received: by ewy13 with SMTP id 13so785983ewy.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 00:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=o8Ck503jol3BSwkWWlSZ0nqrNdu+415cOExlVOIyOR0=;
        b=gvwzXp1bz4NTeBD03tfSXzO+2PfQeQQHqbMmGYxpXy65vwbMMea2nwP7WSD9Jvn1cW
         JNhhljJwEsCgyy4mmBK8tOs/HcYVAKiCmo26W48Vc3M581LOpJ6M1kjHwsxl5TDRSDEw
         CQUOxRbSGIPj/IOffoMfiqQbcsr5UknD3OkUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EJZFt1eo0C3Xh+LXOMW2eQbk65sO2MYyytC7w5a/zEWzfKQxNU9a6MlNwqY5YVkOG3
         HniS3WK10sxuGk1P46UGvCzs2otTYjauQJwQw5xGPYH8SQpEQcnVG1IF8fvuDL1tlpXC
         pIrGNphKljm+uegmn61q/zpbBe2qKUL6u5mCo=
Received: by 10.210.109.10 with SMTP id h10mr3556622ebc.154.1232439167175;
        Tue, 20 Jan 2009 00:12:47 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id j8sm3352931gvb.9.2009.01.20.00.12.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jan 2009 00:12:45 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27-9-generic; KDE/4.1.3; x86_64; ; )
In-Reply-To: <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106455>

On Monday 19 January 2009 15:37:06 Dilip M wrote:
> On Mon, Jan 19, 2009 at 5:29 PM, Reece Dunn <msclrhd@googlemail.com> =
wrote:
> > 2009/1/19 Dilip M <dilipm79@gmail.com>:
> >> ..I recently install GIT on Ubuntu (hardy) box....I am able to use
> >> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'repositor=
y
> >> not found'
> >
> > Who is the owner of the repository directory (and the .git director=
y)
> > and what are the permissions on the directory?  [ ... ]
>=20
> dm-laptop:~/repos/atria> id -a
> uid=3D1000(dm) gid=3D1000(dm)  [ ... ]
> dm-laptop:~/repos/atria> ls -lh .git/
>[... all looks Ok ...]

 repeating Reece's question, what is the permissions/owner
 _of_the_directory_which_contains_ the =E2=80=98.git/=E2=80=99 director=
y?
 I can reproduce this behaviour (git 1.6.0.4) simply by
 denying myself search (n=C3=A9e execute) permission on that
 directory, for entirely obvious reasons.

cheers!
	-blf-
--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
