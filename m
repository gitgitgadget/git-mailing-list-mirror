From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 21:05:39 -0400
Message-ID: <45357DE3.70206@utoronto.ca>
References: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr> <20061018002523.GJ20017@pasky.or.cz> <4535778D.40006@utoronto.ca> <20061018004209.GL20017@pasky.or.cz> <45357A6E.3050603@utoronto.ca> <20061018005700.GM20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Sean <seanlkml@sympatico.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 03:05:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzsW-00083n-Vg
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWJRBFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWJRBFu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:05:50 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:58310 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1750932AbWJRBFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 21:05:49 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZzsL-0006Sh-00; Tue, 17 Oct 2006 21:05:42 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061018005700.GM20017@pasky.or.cz>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29170>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:
> Dear diary, on Wed, Oct 18, 2006 at 02:50:54AM CEST, I got a letter
> where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
>> Petr Baudis wrote:
>>
>>> Ok, one last question - do you do most of the work locally, fetching
>>> bits of data as you need, or remotely, only taking input/producing
>>> output over the network (the pserver model)?
>> Personally, I do not do remote commits over slow links.  At home, I use
>> a single machine, and mirror my repository to a public machine using
>> rsync.  At work, I store my repository on an NFS server, and push my
>> repository to a public machine using rsync.
> 
> I meant the work of the commands (bzr log and such), not your personal
> workflow. :-) Sorry for being unclear.

When using the native network protocol, work can happen remotely.  (But
the native protocol is quite new, and support for "smart" operations is
currently limited.)  When using the dumb protocols, data is fetched from
the remote system and processed locally.  Light checkouts are not
recommended when the server is on a slow link, but heavyweight checkouts
are quite suitable in that situation.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNX3j0F+nu1YWqI0RAtRcAJ0fEZam6H3hs3YHY/dEYEhk3A73BQCdENHY
s9+KZTfqnDJg8mHNmC2C/Ok=
=Nqcn
-----END PGP SIGNATURE-----
