From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 15:51:56 -0400
Message-ID: <4535345C.6090905@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<egr3ud$nqm$1@sea.gmane.org>	<45340713.6000707@utoronto.ca>	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>	<45345AEF.6070107@utoronto.ca> <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 21:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZuyw-0005H4-BF
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 21:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWJQTwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 15:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJQTwF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 15:52:05 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:22209 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751254AbWJQTwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 15:52:03 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZuyj-00031a-00; Tue, 17 Oct 2006 15:51:58 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29109>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sean wrote:
> On Tue, 17 Oct 2006 00:24:15 -0400
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
>>- - you can use a checkout to maintain a local mirror of a read-only
>>  branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
> 
> 
> I'm not sure what you mean here.  A bzr checkout doesn't have any history
> does it?

By default, they do.  You must use a flag to get a checkout with no history.

> So it's not a mirror of a branch, but just a checkout of the
> branch head?

It's a mirror of a branch, and a copy of the branch's working tree.

> If so, Git can export a tarball of a branch (actually a snapshot as at
> any given commit) which can be mirrored out.

Sure, and so can bzr.  But using a checkout of the branch head means:
- - No one has to do anything special to provide a working tree of a given
  revision
- - I can still run any readonly operations I desire
- - I can update to the latest version of bzr.dev with one command.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNTRc0F+nu1YWqI0RAsL2AKCCG0bP8m01WVllfPMzCdFZjmgEgACfeToz
57HERFJ6ZkkS3VrxLRnVPAs=
=3CX7
-----END PGP SIGNATURE-----
