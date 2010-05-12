From: Noah Silverman <noah@smartmediacorp.com>
Subject: Advice on choosing git
Date: Tue, 11 May 2010 23:31:34 -0700
Message-ID: <4BEA4B46.6010009@smartmediacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 12 08:31:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC5Ts-0004cm-F1
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 08:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab0ELGbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 02:31:38 -0400
Received: from smartmediacorp.com ([174.129.253.221]:60955 "EHLO
	smartmediacorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0ELGbh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 02:31:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smartmediacorp.com (Postfix) with ESMTP id CA4F36A09A
	for <git@vger.kernel.org>; Tue, 11 May 2010 23:31:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at smartmediacorp.com
Received: from smartmediacorp.com ([127.0.0.1])
	by localhost (smartmediacorp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kfw6z-3YBBwj for <git@vger.kernel.org>;
	Tue, 11 May 2010 23:31:35 -0700 (PDT)
Received: from [99.41.172.188] (99-41-172-188.lightspeed.irvnca.sbcglobal.net [99.41.172.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smartmediacorp.com (Postfix) with ESMTPSA id 4E4A96A097
	for <git@vger.kernel.org>; Tue, 11 May 2010 23:31:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146923>

Hi,

I'm looking for both a version control system and backup system.


Up for consideration are Git, Bazaar, and generic Rsync.

In the past, I've just use Rsync to sync up the directories I care
about.  I just sync all the machines with the remote server.  Often,
I'll start working on a file or two at the office, rsync my work to the
server, then rsync them back down to my home machine to keep working at
night.  This works, but doesn't give me any nice VCS features, history,
collaboration, etc.  So clearly it is time to upgrade the system.

I work on both a laptop, and office machine and a home machine.

1) I'd like to keep my documents directory synced between the office and
home machines.
2) I'd like to keep two or three sub directories of this synced with my
laptop
3) We have a server in "the cloud" where I like to keep backups of my
documents.  Just in case.
3) I have a few project where I am the only developer, but want a VCS to
manage my changes.
4) I have 3-4 projects where there are a team of 3 of us and I want to
use a VCS.

In general, I might work on a given project/file on any of my machines
in a given day.  Not everything is a full "branch", but just some
ongoing work.  I've always followed the practice of backup up any
changed files remotely, just in case.  So with a VCS, I don't want a new
version number for everytime I change a file.  As I do incremental work
across three machines, it could quickly turn versioning nightmare.

I guess, that I need just keep some files backed up (and/or synced) as
they're not "working projects".  I will add new documents and
occasionally edit others, but no real need for versioning. Other files
are working projects (possible with collaboration) and need active VCS. 

I've heard amazing things about Git, but have a few concerns.  Hopefully
someone here can offer some suggestions.

1) Size.  THIS IS MY MAIN CONCERN - If I want to sync my home, office,
and server Document directories.  From what I have read, I will
effectively have multiple copies of each item on my hard drive, thus
eating up a lot of space (One of the "working file"and several in the
.git directory.) If I have multiple changes to a file, then I have
several full versions of it on my machine.  This could be a problem for
a directory with 100GB or more, especially on a laptop with limited hard
drive space.  I know Subversion is a dirty word around here, but it
seemed to only annotate and send the changes

2) Sub-directory selection.  On my laptop, I only want a few
sub-directories to be synced up.  I don't need my whole document tree,
but just a few directories of things I work on.

Bazaar also looks like a possible option, but I'm not sure it handles
drive usage better.  Their website has a lengthy manifesto about how
they're better than Git, but I don't have enough experience with either
to make an informed decision.

Any and all suggestions are welcome and appreciated.

Thank You,

--
Noah
