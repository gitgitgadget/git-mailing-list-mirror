From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 19:33:48 -0400
Message-ID: <4535685C.4010502@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:14:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZz4Y-00033K-R3
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWJQXdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 19:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWJQXdy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:33:54 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:23493 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1751117AbWJQXdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 19:33:54 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZyRT-0005RJ-00; Tue, 17 Oct 2006 19:33:51 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610180057.25411.jnareb@gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29141>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Aaron Bentley wrote:
> By the way, are bzr "bundles" compatibile with ordinary patch?
> git-format-patch patches are. They have additional metainfo,
> but they are patches in heart.

Yes, they are.

>> I'm not sure what you think Bazaar does.  In Bazaar, a repository format
>> plugin  implements the same API that a native repository format does.
>>
>> This is how bzr supports Subversion, Mercurial and Git repositories.
> 
> But if I remember correctly Subversion does not remember merge points
> (merge commits), so how can you provide full Bazaar-NG compatibility
> with Subversion repository as backend? Some repository formats lack
> some features.

That's true.  We support merge points in a way that's compatible with
svk.  Subversion allows revisions to have arbitrary properties, and svk
sets a property to indicate merges.

> In git we have import tools (most of them capable of incremental import),
> a few exchange tools like git-cvsexportcommit, git-cvsserver, and
> Tailor-like git-svn.

Bzr's subversion support is quite nice.  You can commit, merge, run
history viewers.

There are screenshots and stuff here:
http://bazaar-vcs.org/BzrForeignBranches/Subversion

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNWhc0F+nu1YWqI0RAkH7AJ4/S648shA8IKg42xcGWdjnjmA+PgCdEDhg
Af/mcG+XTy3Tsb9b1x3rYcg=
=xnjF
-----END PGP SIGNATURE-----
