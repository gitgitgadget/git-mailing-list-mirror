From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 20:38:37 -0400
Message-ID: <4535778D.40006__48886.5832718604$1161134805$gmane$org@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <20061018002523.GJ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Sean <seanlkml@sympatico.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzSR-0007rq-JI
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWJRAiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWJRAiw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:38:52 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:29382 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751153AbWJRAiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:38:52 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZzSG-0006C3-00; Tue, 17 Oct 2006 20:38:45 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061018002523.GJ20017@pasky.or.cz>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29153>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:
>> this only makes sense if
>> you have a fast access to the repository (otherwise, you consider your
>> local repository as a cache, and you're ready to pay the disk space
>> price to save your bandwidth). In this case, it's often in your
>> filesystem (local or NFS).
> 
> So how is the light checkout actually implemented? Do you grab the
> complete new snapshot each time the remote repository is updated?

No, the lightweight checkouts store very little.  They have
- - a copy of tree shape (filenames, paths, sha1 sums) from the last
  commit.
- - a copy of tree shape for the current working directory
- - a map from stat values to sha-1 hashes


> Do all
> the (at least read-only, like "log" and "diff", perhaps "status")
> commands work on such a light checkout?

Yes.  And if you check out from a read-write branch, all write commands,
work, too.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNXeN0F+nu1YWqI0RAsdrAJ0bUj4swxm5sod9WnsbPZ9yIQ7FVQCdE4UB
8x0ddFkbr5cPISTihw96d8c=
=/XAr
-----END PGP SIGNATURE-----
