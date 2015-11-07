From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sun, 08 Nov 2015 00:32:48 +0100
Message-ID: <1446939168.16957.11.camel@kaarsemaker.net>
References: <563DEA71.1080808@dinwoodie.org>
	 <20151107184527.GA4483@sigill.intra.peff.net>
	 <20151107192029.GW14466@dinwoodie.org>
	 <1446930165.16957.9.camel@kaarsemaker.net>
	 <563E6B47.5000807@ramsayjones.plus.com>
	 <563E83C2.5050300@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 08 00:32:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvCye-0005Um-V7
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 00:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbbKGXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 18:32:52 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34290 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbbKGXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 18:32:51 -0500
Received: by wikq8 with SMTP id q8so49589401wik.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2015 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=6VxB7ISsBDWHgNi/Yo6HvqEpWBkwz3PLAk6FsJqNAMs=;
        b=BehGziNJMNRdB7XrIIu+4OBncqYuGiPMr5IqSQ3FvDhKcA6UHd847BN3v81hgEgDb2
         oUhy2kYfP16t7ZCr/JgO8KroCLtGwQjxYun8rWKHi8h95LfIHIshGVP7221eIg8nSWY7
         /V3VclyjEOkCO1LEBUTqGTPtRPylvwscu+YXWrdHFGTCRD1gXXuwFWBSAYm9631/D0/w
         zyi/Eg6ItTUSosXAeq7AF066B7Xg/29mXuiy28g95MJNbZFrGuVW26sCIEcqff2WgkbM
         DySyYZEKfhvvkWo2+3goH6MwWxYwzCpAItxgn7dMcys+WrIIJ2JD3XVQCkLkx1xv3P1a
         rAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=6VxB7ISsBDWHgNi/Yo6HvqEpWBkwz3PLAk6FsJqNAMs=;
        b=g1tUOGNaqrVISVj/qJsq5rX7mS7bJpjuP53mZ3FUIwRrCT0MJSe3TuUF5ypD7ybjHf
         F8Zx+m/RWlX7Sa2qFQrgICnd8AYB4BKWLOU6KwBZXJQuzoQ6V/JamLkW3335kUpg5CCT
         NwsAqrMybroJfMb9GmofABbJjWmm8w7OA1NDkeSStMEIYQ3KuJbL6ZQkH03xbw9te6yK
         Q91vpczUMYIVncER6vfK6ko7p2AYU9yvcbvXg3nUKcSET4evlkr4pfi+ALrIsxLPSGjp
         f9VUG9UC1qgDejs4NovAyhEe6iqcz5pfHNog2MBh34CUkmRc0fQoH1TskeHLgWTLSYAN
         s1LA==
X-Gm-Message-State: ALoCoQmtyBxixnIf/E6LCY0HMyW1Zu/HVDD8Bu1s6ebdIYOaP/Lt6AM87gLxa7XZIanDcEtFyIYM
X-Received: by 10.194.172.162 with SMTP id bd2mr20146313wjc.140.1446939170116;
        Sat, 07 Nov 2015 15:32:50 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id j4sm6167247wmg.18.2015.11.07.15.32.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2015 15:32:49 -0800 (PST)
In-Reply-To: <563E83C2.5050300@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281027>

On za, 2015-11-07 at 23:05 +0000, Ramsay Jones wrote:
> 
> On 07/11/15 21:21, Ramsay Jones wrote:
> > 
> > 
> > On 07/11/15 21:02, Dennis Kaarsemaker wrote:
> > > On za, 2015-11-07 at 19:20 +0000, Adam Dinwoodie wrote:
> > > > On Sat, Nov 07, 2015 at 01:45:27PM -0500, Jeff King wrote:
> > > > > On Sat, Nov 07, 2015 at 12:11:29PM +0000, Adam Dinwoodie
> > > > > wrote:
> > > > > 
> > > > > > Specifically, I'm seeing t5813 subtests 9-13 and 15-19
> > > > > > failing.
> > > > > > This happens
> > > > > > with a clean build straight from the Git source tree (git
> > > > > > clean 
> > > > > > -dfx && make
> > > > > > configure && ./configure && make && cd t && ./t5813-proto
> > > > > > -disable
> > > > > > -ssh.sh) as
> > > > > > well as builds using the Cygwin packaging paraphernalia.
> > > > > 
> > > > > What does the output of "./t5813-proto-disable-ssh.sh -v -i"
> > > > > show?
> > > > > 
> > > > > It seems strange that it would fail only on Cygwin; this code
> > > > > doesn't
> > > > > really use any platform-dependent features. It's also weird
> > > > > that it
> > > > > fails _only_ for ssh, and _only_ on the tests that are using
> > > > > "ssh://"
> > > > > URLs are not "host:path" syntax.
> > > > 
> > > > Ah!  I thought I'd checked that already, but looking at the
> > > > output
> > > > now I
> > > > can see what's going wrong.  Cutting down to the relevant
> > > > error:
> > > > 
> > > >     ssh: remote git-upload-pack '//home/Adam/vcs/Cygwin-Git/git
> > > > -2.6.2
> > > > -1.x86_64/build/t/trash directory.t5813-proto-disable
> > > > -ssh/remote/repo.git' fatal: '//home/Adam/vcs/Cygwin-Git/git
> > > > -2.6.2
> > > > -1.x86_64/build/t/trash directory.t5813-proto-disable
> > > > -ssh/remote/repo.git' does not appear to be a git repository
> > > > 
> > > > Note the '//' at the start of the path -- on most *nix systems
> > > > '//'
> > > > is
> > > > effectively identical to '/'.  On Cygwin, however, '//' is used
> > > > to
> > > > access Windows UNC paths: what Windows calls "\\server\share",
> > > > Cygwin
> > > > calls "//server/share".  If you replace the '//' with '/' you
> > > > get the
> > > > locatoin of the repository; but here Cygwin is looking for the
> > > > repository in a share called "Adam" on a network server called
> > > > "home"...
> > > > 
> > > > I suspect the correct fix here is to fix whatever's causing Git
> > > > to
> > > > generate a path with that '//'.  If nobody else gets to it soon
> > > > (probably on the order of a week before I'll get the chance),
> > > > I'll go
> > > > code diving and submit a patch.
> > > > 
> > > > > I tried building on Linux with the Cygwin build knobs found
> > > > > in
> > > > > config.mak.uname, but I couldn't get it to fail. I also
> > > > > wondered if
> > > > > the
> > > > > test was doing something with the shell that might not be
> > > > > portable,
> > > > > but
> > > > > I don't see anything interesting.
> > > > 
> > > > If I recall correctly, the correct interpretation of '//' isn't
> > > > defined
> > > > in POSIX, so whatever's causing that path to be generated is
> > > > the bit
> > > > that's not fully portable.  It looks as though t5813 throwing
> > > > this up
> > > > is
> > > > just a coincidence rather than it being particularly related to
> > > > the
> > > > function those tests are actually testing.
> > > 
> > > Looks like lib-proto-disable.sh's fake SSH doesn't strip double
> > > leading
> > > /'es from the path. Try this patch:
> > > 
> > > diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable
> > > -ssh.sh
> > > index ad877d7..a954ead 100755
> > > --- a/t/t5813-proto-disable-ssh.sh
> > > +++ b/t/t5813-proto-disable-ssh.sh
> > > @@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone'
> > > '
> > >  '
> > >  
> > >  test_proto "host:path" ssh "remote:repo.git"
> > > -test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
> > > -test_proto "git+ssh://" ssh
> > > "git+ssh://remote/$PWD/remote/repo.git"
> > > +test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
> > > +test_proto "git+ssh://" ssh
> > > "git+ssh://remote$PWD/remote/repo.git"
> > 
> > Heh, this looks familiar ... see, for example, commit 3a81f33c5. ;
> > -)
> 
> An alternative patch may look like this:
> 
> diff --git a/connect.c b/connect.c
> index 108f5ab..fc73cf9 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -636,6 +636,8 @@ static enum protocol parse_connect_url(const char
> *url_orig, char **ret_host,
>  	end = path; /* Need to \0 terminate host here */
>  	if (separator == ':')
>  		path++; /* path starts after ':' */
> +	if (starts_with(path, "//"))
> +		path++;
>  	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
>  		if (path[1] == '~')
>  			path++;
> 
> It seems to work, but I haven't thought about it too deeply ...
> so I don't know if there are any problems lurking. :)
> 
> I have to go now, so if somebody wants to take this up ...

Won't that break file:////server/share urls on cygwin?

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
