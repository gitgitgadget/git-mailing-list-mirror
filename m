From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 20:30:14 -0400
Message-ID: <45357596.8050702@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<200610171555.56778.jnareb@gmail.com>	<vpqr6x711cm.fsf@ecrins.imag.fr>	<200610171641.04455.jnareb@gmail.com> <20061018000026.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Oct 18 02:31:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzKd-0005nH-4H
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWJRAab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWJRAab
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:30:31 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:18886 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751334AbWJRAaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:30:30 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZzKD-000680-00; Tue, 17 Oct 2006 20:30:25 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061018000026.GH20017@pasky.or.cz>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29150>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Petr Baudis wrote:
> How frequently are the bundles used in practice?

Many times each day.  Most submission to the bzr mainline are done with
bundles.

> Another aspect of this is that Git (Linus ;) is very focused on getting
> the history right, nice and clean (though it does not _mandate_ it and
> you can just wildly do one commit after another; it just provides tools
> to easily do it).

Yes, rebasing is very uncommon in the bzr community.  We would rather
evaluate the complete change than walk through its history.  (Bundles
only show the changes you made, not the changes you merged from the
mainline.)

In an earlier form, bundles contained a patch for every revision, and
people *hated* reading them.  So there's definitely a cultural
difference there.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNXWW0F+nu1YWqI0RAuRnAJ9aZVLo4T1sfmyGC2t364UyHX+6wACff7sM
peal5rAdk/T515RGeKXkWlo=
=O61J
-----END PGP SIGNATURE-----
