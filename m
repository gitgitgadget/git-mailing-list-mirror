From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sat, 07 Nov 2015 22:02:45 +0100
Message-ID: <1446930165.16957.9.camel@kaarsemaker.net>
References: <563DEA71.1080808@dinwoodie.org>
	 <20151107184527.GA4483@sigill.intra.peff.net>
	 <20151107192029.GW14466@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 07 22:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvAdq-0003H3-CP
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 22:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbbKGVCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 16:02:49 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35985 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbKGVCs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 16:02:48 -0500
Received: by wmww144 with SMTP id w144so51319545wmw.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2015 13:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=UTzUJjYjbAv7B45FeNKnaIaTXMp5nZzdZsfFx3a45D8=;
        b=WrHx6qjrdIlqh9q1JTEoidy5c1IdYjDKi7rVDL1D2rsUGiX2f7QkxssbT50p5onj5J
         3uXPf/69Mpw/pgw+yP5FwP0n2ghgGKzapb9Vg9Ktfc+rGvw0USHCNX+8NPwosVxsfg5n
         6AWLOtJQlhNoC3LjtSqF8vAZXXcbNfTB0b5ihPgksGw9EjrHb816oK2i/znD/sAa0q67
         ph6qXxo+kjIjkuaPmX75SZdVLp3JEUPFeQMwmb7cl/Lz667y8aQv+a2TDCf4IMIR9DEE
         oqqwui1CfwwDBzhWAbVESRzPVz1IkhwAaOR5IpWidKds9/KbCvVvgMhvTKPbTJsVV+ay
         fmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=UTzUJjYjbAv7B45FeNKnaIaTXMp5nZzdZsfFx3a45D8=;
        b=Tms5lq+wmaeHYSIkiA1HcZgdN0pUE4r32Gk+Iq1AzZnrO8LTr1/YKulj0EJXypDva+
         qhOJh1oCarhJjbzzjxFHIVHKZK+BVcQnTT9U/vYNDHWsNFj82hILe7FWmivQ7DD42s96
         bLO9+d4CqAcII3mx1bBHxRk0wWnH4DTYVKnnMve/yR08wwqLbIOKdF9sjpdiTnMyVLM6
         tRD++lu0WWSEyTd5fUU+rKe3BzREfo97b5ByS/8zDsgVKGM5ClSXr6nPPuSldePYhrQz
         l8QL1CwyKOEIv1MbrTOvD2vKwVFdSMcTDEqSAA1II3vDoCumS0jvrJBQvgte410+zQbK
         MaRg==
X-Gm-Message-State: ALoCoQnEiPIA8VFS14yZoKO2iq+Dfkn5ahBmrNENtiXmYNPAz/Tg/jtVUfJdQC6KkYBE8q4K0IKb
X-Received: by 10.28.14.199 with SMTP id 190mr18409993wmo.42.1446930166955;
        Sat, 07 Nov 2015 13:02:46 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id gl4sm6772551wjd.49.2015.11.07.13.02.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2015 13:02:46 -0800 (PST)
In-Reply-To: <20151107192029.GW14466@dinwoodie.org>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281023>

On za, 2015-11-07 at 19:20 +0000, Adam Dinwoodie wrote:
> On Sat, Nov 07, 2015 at 01:45:27PM -0500, Jeff King wrote:
> > On Sat, Nov 07, 2015 at 12:11:29PM +0000, Adam Dinwoodie wrote:
> > 
> > > Specifically, I'm seeing t5813 subtests 9-13 and 15-19 failing.
> > > This happens
> > > with a clean build straight from the Git source tree (git clean 
> > > -dfx && make
> > > configure && ./configure && make && cd t && ./t5813-proto-disable
> > > -ssh.sh) as
> > > well as builds using the Cygwin packaging paraphernalia.
> > 
> > What does the output of "./t5813-proto-disable-ssh.sh -v -i" show?
> > 
> > It seems strange that it would fail only on Cygwin; this code
> > doesn't
> > really use any platform-dependent features. It's also weird that it
> > fails _only_ for ssh, and _only_ on the tests that are using
> > "ssh://"
> > URLs are not "host:path" syntax.
> 
> Ah!  I thought I'd checked that already, but looking at the output
> now I
> can see what's going wrong.  Cutting down to the relevant error:
> 
>     ssh: remote git-upload-pack '//home/Adam/vcs/Cygwin-Git/git-2.6.2
> -1.x86_64/build/t/trash directory.t5813-proto-disable
> -ssh/remote/repo.git' fatal: '//home/Adam/vcs/Cygwin-Git/git-2.6.2
> -1.x86_64/build/t/trash directory.t5813-proto-disable
> -ssh/remote/repo.git' does not appear to be a git repository
> 
> Note the '//' at the start of the path -- on most *nix systems '//'
> is
> effectively identical to '/'.  On Cygwin, however, '//' is used to
> access Windows UNC paths: what Windows calls "\\server\share", Cygwin
> calls "//server/share".  If you replace the '//' with '/' you get the
> locatoin of the repository; but here Cygwin is looking for the
> repository in a share called "Adam" on a network server called
> "home"...
> 
> I suspect the correct fix here is to fix whatever's causing Git to
> generate a path with that '//'.  If nobody else gets to it soon
> (probably on the order of a week before I'll get the chance), I'll go
> code diving and submit a patch.
> 
> > I tried building on Linux with the Cygwin build knobs found in
> > config.mak.uname, but I couldn't get it to fail. I also wondered if
> > the
> > test was doing something with the shell that might not be portable,
> > but
> > I don't see anything interesting.
> 
> If I recall correctly, the correct interpretation of '//' isn't
> defined
> in POSIX, so whatever's causing that path to be generated is the bit
> that's not fully portable.  It looks as though t5813 throwing this up
> is
> just a coincidence rather than it being particularly related to the
> function those tests are actually testing.

Looks like lib-proto-disable.sh's fake SSH doesn't strip double leading
/'es from the path. Try this patch:

diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable
-ssh.sh
index ad877d7..a954ead 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone' '
 '
 
 test_proto "host:path" ssh "remote:repo.git"
-test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
-test_proto "git+ssh://" ssh "git+ssh://remote/$PWD/remote/repo.git"
+test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
+test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"
 
 test_done


-- 
Dennis Kaarsemaker
www.kaarsemaker.net
