From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 01:08:59 -0400
Message-ID: <4534656B.7080105@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 07:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZhCP-0005vk-Au
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 07:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423094AbWJQFJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 01:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423093AbWJQFJF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 01:09:05 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:55730 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1423094AbWJQFJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 01:09:04 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZhCH-0000fI-00; Tue, 17 Oct 2006 01:09:01 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29021>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Schindelin wrote:
> On Mon, 16 Oct 2006, Aaron Bentley wrote:

>> Bazaar's namespace is "simple" because all branches can be named by a 
>> URL, and all revisions can be named by a URL + a number.
> 
> How should this cope with a distributed project? IOW how does it deal with 
> "this revision and that revision are exactly the same"?

There are two answers here.  One is that the URL + number is UI, not
internals.  A unique ID is used internally, so that can be compared.

But to fully ensure that there are no differences, i.e. that no one has
reused an ID, you can generate a revision testament.

> If I understand you correctly, you are claiming that you are not really 
> identifying a revision, but a revision _at a certain place with a 
> place-dependent number_. This conflicts with my understanding of a 
> revision.

No, I am claiming that a revision at a certain place with a
place-dependent number is one name for a revision, but it may have other
names.

>> If that's true of Git, then it certainly has a simple namespace.  Using 
>> eight-digit hex values doesn't sound simple to me, though.
> 
> It depends on your usage. If you want to do anything interesting, like 
> assure that you have the correct version, or assure that two different 
> person's tags actually tag the same revision, there is no simpler 
> representation.

I can use the 'bzr missing' command to check whether my branch is in
sync with a remote branch.  Or I can use the 'pull' command to update my
branch to a given revno in a remote branch.


>> That sounds right.  So those branches are persistent, and can be worked
>> on independently?
> 
> Of course! Persistence (and reliability) are the number one goal of git. 
> Performance is the next one.

You'd be surprised.  When we last spoke to the Mercurial team, Mercurial
didn't support multiple persistent branches in one repository.  Pulling
from a remote repository could join two branches into one.  I'm told
they're fixing that now.


>> You'll note we referred to that bevhavior on the page.  We don't think
>> what Git does is the same as supporting renames.  AIUI, some Git users
>> feel the same way.
> 
> Oh, we start another flamewar again?

I'd hope not.  It sounds as though you feel that supporting renames in
the data representation is *wrong*, and therefore it should be an insult
to you if we said that Git fully supported renames.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNGVq0F+nu1YWqI0RAsXiAJ9hjH2sQGG3E9oIYP2SxscXvVQsJACdHtkj
+r37JPSjbQCuchPo08P3px8=
=5MHE
-----END PGP SIGNATURE-----
