From: Vladimir Pouzanov <farcaller@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Sat, 17 Jan 2009 12:06:09 +0200
Message-ID: <E3BA9CAD-B3CD-4050-8493-7C4024AD4529@gmail.com>
References: <loom.20090113T185918-397@post.gmane.org> <20090113203922.GD30404@atjola.homenet> <loom.20090113T204616-845@post.gmane.org> <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com> <loom.20090113T211437-12@post.gmane.org> <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com> <loom.20090113T213400-985@post.gmane.org> <76718490901131658l108852f2y9a25eb9133d6e96d@mail.gmail.com> <loom.20090114T083207-942@post.gmane.org> <76718490901141006n6c70eb2cw67ad814b3739786e@mail.gmail.com> <20090117095147.GA29598@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 17 11:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO85c-00027k-Rr
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 11:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530AbZAQKGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 05:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756387AbZAQKGR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 05:06:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:11993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbZAQKGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2009 05:06:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so978447fgg.17
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=Qbymx6vXQuKey8XOsU0HYR2iOZzgTmrcAy3ZqX97aSM=;
        b=lGQ3x6B2JfEDRJRCfvMDsLSXlZDMz/jnP2aeeSKe/27A0JXsprcS+elpKnvxhp6wuU
         Y/IP6rFG9/1C6EYC83SCJo+t2Vsp4oHjTLXsZerRxMQbaebQ7y/S5BoNcw12/dkcn1cZ
         YQwgqNi5kmesDLI7obNTUzXnvsPPcvEuuQLKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=TXhnnI95AKIHM5ERgdBqU0TZzUuyFLGw1wzllEUbAlvMiUTKvuwZt773R6zeFVcYca
         Psr6u7DnCAz847b0vrar2SoRDVvcVuHb8yyYCV4TWxWTZn/uEtXrFFSBCNsJ8eqUrH1I
         tdoeUoXiFHKVu5SxGObQzHFrPxAdRHKJ8fJiU=
Received: by 10.86.60.14 with SMTP id i14mr2477198fga.21.1232186772772;
        Sat, 17 Jan 2009 02:06:12 -0800 (PST)
Received: from Firestorm.farcaller.net ([92.112.169.127])
        by mx.google.com with ESMTPS id l12sm2953302fgb.58.2009.01.17.02.06.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Jan 2009 02:06:12 -0800 (PST)
In-Reply-To: <20090117095147.GA29598@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106037>


On 17 =D1=8F=D0=BD=D0=B2. 2009, at 11:51, Eric Wong wrote:
> Does the following patch (a shot in the dark) work for you?
> (it generates a lot of warnings for me)

$ git svn clone http://qsb-mac.googlecode.com/svn/trunk qsbmac
Initialized empty Git repository in /Users/farcaller/temp/qsbmac/.git/
r1 =3D 810fe584c48b884460b5403a28bc61d872452b93 (git-svn)
Attempt to release temp file 'GLOB(0x82b290)' that has not been locked =
=20
at /opt/local/libexec/git-core/git-svn line 3413
	A	externals/BSJSONAdditions/NSArray+BSJSONAdditions.m
Attempt to release temp file 'GLOB(0xa0de34)' that has not been locked =
=20
at /opt/local/libexec/git-core/git-svn line 3413
	A	externals/BSJSONAdditions/BSJSON.h
Attempt to release temp file 'GLOB(0x80ed84)' that has not been locked =
=20
at /opt/local/libexec/git-core/git-svn line 3413
	A	externals/BSJSONAdditions/NSDictionary+BSJSONAdditions.m
Attempt to release temp file 'GLOB(0x9d3018)' that has not been locked =
=20
at /opt/local/libexec/git-core/git-svn line 3413
	A	externals/BSJSONAdditions/Example/Unit Tests/=20
BSJSONScanner_UnitTests.h
Attempt to release temp file 'GLOB(0xa0df48)' that has not been locked =
=20
at /opt/local/libexec/git-core/git-svn line 3413
	A	externals/BSJSONAdditions/Example/version.plist
Attempt to release temp file 'GLOB(0x9d8114)' that has not been locked =
=20
at /opt/local/libexec/git-core/git-svn line 3413
	A	externals/BSJSONAdditions/NSDictionary+BSJSONAdditions.h
Temp file with moniker 'svn_delta' already in use at /opt/local/lib/=20
perl5/site_perl/5.8.8/Git.pm line 1011.

I've built git 1.6.1 based on OSX original perl an subversion, and it =20
handles the give repo without any problems, so the problem is kind of =20
solved. Strange thing is that macports git (the one that fails) =20
handles other svn repositories without any problems, I had cloned =20
whole transmissionbt repo (>7000 revs) with all the tags and branches =20
and several other simpler repositories.

--=20
Sincerely,
Vladimir "Farcaller" Pouzanov
