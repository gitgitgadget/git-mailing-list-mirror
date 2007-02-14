From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 15:40:04 -0600
Message-ID: <17875.33204.413186.355557@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
	<17875.30687.661794.512124@lisa.zopyra.com>
	<Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRrS-0001ds-6N
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbXBNVkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbXBNVkS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:40:18 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60461 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932655AbXBNVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:40:17 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1ELe9H20682;
	Wed, 14 Feb 2007 15:40:09 -0600
In-Reply-To: <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39758>

WAAAAAIAMINIT ... I think I see it:

% perl -pi -e 's/.*\$Id.*//sx' $(xgrep -l '[$]Id')

Could I have corrupted the pack file?  I'll bet $50 I did:

% [yet another clone]
% xgrep -l '[$]Id'
./.git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
[...]

%!@#$&$%(@@@!!!

I sent this list to a Perl script to nuke CVS Ids!  I invoked this
one level up in my directories, not in my source tree, and .git
got picked up.

[Really, Really Red Shame Face Here]

Ok, I win $50, and I owe each of you a bottle of very good wine for
wasting your time.  Just send me an email privately to tell me what
you prefer ... seriously, very seriously ....

I am, however, still curious about the git segfaults in my
/var/log/messages.


Bill
