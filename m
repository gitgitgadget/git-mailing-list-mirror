From: Bill Lear <rael@zopyra.com>
Subject: Re: git-push through git protocol
Date: Mon, 22 Jan 2007 07:58:27 -0600
Message-ID: <17844.49923.798205.493630@lisa.zopyra.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
	<17843.55730.456139.247155@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
	<17844.5120.316805.794579@lisa.zopyra.com>
	<Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
	<46a038f90701211826v54340352lf4376db41ad5be37@mail.gmail.com>
	<Pine.LNX.4.64.0701211858340.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 14:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8zhP-0008O1-Tr
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 14:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXAVN6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 08:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbXAVN6o
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 08:58:44 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60973 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbXAVN6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 08:58:43 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0MDwUl23069;
	Mon, 22 Jan 2007 07:58:30 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211858340.14248@woody.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37409>

On Sunday, January 21, 2007 at 19:01:45 (-0800) Linus Torvalds writes:
>On Mon, 22 Jan 2007, Martin Langhoff wrote:
>> ...
>> Whereby I personaly run back quickly to cover under my git-over-ssh
>> safety blanket.
>
>Sure. 
>
>I suspect that git-daemon is possibly easier and faster to set up in the 
>kind of situation where you set up git instead of CVS inside a company, 
>though. ...

Another nice thing with the git protocol is that we can keep the
repository "interface" constant --- it's always "git://server/repo"
for us, even if we have the repo one day at /repos/git/repo, or later
decide to move it to /backedup/repos/git/repo.  All we have to do is
change the git-daemon file and point it at the new repo, and all the
developers' origin files need not change.  You can do this with
symlinks, I suppose, but after the third move, we really appreciated
the git mobility and disliked the litter of symlinks:-)


Bill
