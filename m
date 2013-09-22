From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sun, 22 Sep 2013 10:12:50 +0200
Message-ID: <20130922081250.GD13262@paksenarrion.iveqy.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
 <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
 <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
 <523e81f338f1e_547c41e7c166be@nysa.mail>
 <20130922073120.GC13262@paksenarrion.iveqy.com>
 <CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 10:06:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNeg5-0001Uk-DB
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 10:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab3IVIFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Sep 2013 04:05:37 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:43680 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab3IVIFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 04:05:30 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so1814489lbi.31
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+x2GVrvAACrBQziN0JI1AS0eflK4Q2hjGBkhSjj+TiM=;
        b=tGEfOKsRrZKQf3ht9dNhQiFLXECJzy3bfXHOZ5iFzFFG8HPEVoP2HTHqc1cVHqNEWr
         S6LpE4GctZGixkouvYHhNbMA3MSSh6ufRPh/sgdyQE5SzAckei/lPb/WVl2dg40tjD8G
         PH8NCIoTeHKYd7f10RaSEQkBCT14Lm6fAtKenCYnxxf9+zYtqYUE6BQsp0CwRwjbZHn0
         S8sbtnEMbwCI4O9aSm6loz1j9oClM7n7qmxZevJifhyJ5+FCen6UzEyCIptpc6P/nz18
         beydlzKQ4zxeGLfoQM3WRGfrwaoBc2qYJdh6DX/6sl6tX2ifSLQTRtdDb1z5up9nY0mE
         velQ==
X-Received: by 10.152.2.4 with SMTP id 4mr14490920laq.0.1379837129057;
        Sun, 22 Sep 2013 01:05:29 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id ap7sm9756550lac.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 01:05:28 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VNemg-0001xu-CJ; Sun, 22 Sep 2013 10:12:50 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0Lww+se6iA2NWSwkeuLdR9mc0ppnVBSjWu4d73YeP6oA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235162>

On Sun, Sep 22, 2013 at 02:43:39AM -0500, Felipe Contreras wrote:
> > It would actually be usefull to know stats on where git is runned. =
In my
> > world of embedded computing, ruby support definitely isn't a standa=
rd,
> > nor is glibc.
>=20
> I come from the embedded world as well, and I've never seen Git used =
there.
>=20
> I'd say Windows support is much more important than embedded, and we
> are not supporting that properly.

Me neither, it doesn't mean that it isn't used though... I agree with
the lack of windows support from git.git. However since Microsoft
working with libgit2 on a Visual Studio plugin this it might be that th=
e
need for windows support decreases.

>=20
> >> > Also, the only Python script that is shipped with Git is git-p4,=
 which
> >> > is essentially optional, since most git users probably do not us=
e
> >> > Perforce. Otherwise, all the scripts in git are shell or Perl.
> >>
> >> Neither perl, nor shell, nor python scripts solve the forking prob=
lem. My
> >> proposal does.
> >
> > It does,
>=20
> No, it does not. All the **current** perl/shell/python scripts use
> 'git foo' commands to achieve everything.

As I said, "It does" meaning "Your solution solves the forking problem"=
=2E

>=20
> > and so does Lua,
>=20
> There is no lua in Git.

There's no ruby in git either as far as I know... (and no, I don't thin=
k
contrib/ counts).

>=20
> > which can be bundled with git and used in the
> > configuration files as well and is pure ansi C. However bundling
> > something has it bad sides too. At least this will solve the depend=
ency
> > problem. So let the language war begin =3D).
>=20
> Talk is cheap, show me the code.

See this thread by Jeff King:
http://thread.gmane.org/gmane.comp.version-control.git/206335/focus=3D2=
06337

And see my humble test of what the speedup would be for git-submodule
even with a faulty lua integration (still forking... but huge
performance boost anyway):
http://thread.gmane.org/gmane.comp.version-control.git/228031/focus=3D2=
28051

As you can see a lua integration would increase the git binary with
300kb.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
