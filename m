From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sun, 22 Sep 2013 09:31:20 +0200
Message-ID: <20130922073120.GC13262@paksenarrion.iveqy.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
 <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
 <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
 <523e81f338f1e_547c41e7c166be@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 09:24:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNe1n-0005YX-Vi
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 09:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab3IVHYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Sep 2013 03:24:03 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43363 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125Ab3IVHYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 03:24:01 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so1846599lbh.9
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ufYNRAH6bnGE2pLRhzK1SY3+ABXA0dBL5kNTe6TYqyw=;
        b=FOUq01KfK7+z9iIROY5f0RVdI0oscxfaVr7kUjkS7FWc+mm1TTmmQvC27k1Hxuh1Y/
         +MCIQXlHnXaAZDSialOZ7wemeEQU9bLO1PcJOKu6jGTyBAHZfKaSGSX7pyEIcD2sX7R5
         CCCx19peU8hRzUAsWxWih1GGUGEpzh/dHRGly4PJkiGnh1vbimqH7l0Hc2dII5GguukY
         oXb/3GnIEX15XHNuX5ivjNelFJF3kXYSUpsc8Lq9WqjgKpsWMzpxqtLTFq56C8sQsbuS
         3uIUjQ+FZSDlLrDHcTO9RfnNXAtn80Tw3T1n9ksQV5EEnzAH3gChe62yvg5aW/+Vf5Tp
         wWVA==
X-Received: by 10.112.14.3 with SMTP id l3mr553774lbc.27.1379834639624;
        Sun, 22 Sep 2013 00:23:59 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id kx1sm9685631lac.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 00:23:58 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VNe8W-0001r1-SU; Sun, 22 Sep 2013 09:31:20 +0200
Content-Disposition: inline
In-Reply-To: <523e81f338f1e_547c41e7c166be@nysa.mail>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235160>

On Sun, Sep 22, 2013 at 12:36:51AM -0500, Felipe Contreras wrote:
> > I think it's a bad idea to introduce an entirely new runtime, espec=
ially
> > one known to occasionally blow up on less-common architectures, wit=
hout
> > some advance notice.
>=20
> This is just FUD. What do you mean blow up on less-common architectur=
es? Do you
> have actual evidence or can we just dismiss that as a baseless argume=
nt?
>=20
> > For example, at work I would not be able to deploy a git using Ruby
> > immediately because Git is an RPM and Ruby is compiled from source,=
 if it is
> > even present at all.
>=20
> Again, what do you mean? In all the distributions I've seen, vim is c=
ompiled
> with Ruby support by default, so unless you think vim is an essoteric=
 package,
> libruby is almost definetly packaged and available.

It would actually be usefull to know stats on where git is runned. In m=
y
world of embedded computing, ruby support definitely isn't a standard,
nor is glibc.

As for architecture speaking I think it's important that git works on
ARM since that architecture increases on the server market. I've no ide=
a
if this is a problem with ruby or not.

>=20
> > Also, the only Python script that is shipped with Git is git-p4, wh=
ich
> > is essentially optional, since most git users probably do not use
> > Perforce. Otherwise, all the scripts in git are shell or Perl.
>=20
> Neither perl, nor shell, nor python scripts solve the forking problem=
=2E My
> proposal does.

It does, and so does Lua, which can be bundled with git and used in the
configuration files as well and is pure ansi C. However bundling
something has it bad sides too. At least this will solve the dependency
problem. So let the language war begin =3D).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
