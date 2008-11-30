From: jidanni@jidanni.org
Subject: Re: timestamps not git-cloned
Date: Sun, 30 Nov 2008 08:48:41 +0800
Message-ID: <87k5am3uom.fsf@jidanni.org>
References: <200811291117.01655.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 01:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6aVn-0003RJ-CF
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 01:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbYK3Asq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbYK3Asq
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 19:48:46 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:50735 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753272AbYK3Asp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Nov 2008 19:48:45 -0500
Received: from jidanni2.jidanni.org (122-127-35-172.dynamic.hinet.net [122.127.35.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 881AD119DCC
	for <git@vger.kernel.org>; Sat, 29 Nov 2008 16:48:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101941>

Well all I know is from the simple user who does e.g.,
# aptitude install linux-doc-2.6.26
# ls -lt /usr/share/doc/linux-doc-2.6.26/Documentation/
he thinks "gosh, can't tell what's new vs. what hasn't changed in years".

OK, now I know why this is tolerable upstream: they all use git.

But for the lowly user downstream who gets what git-archive produces,
it seems like a step backwards: "who threw away the timestamp of when
each file was last changed?".

OK, http://git.or.cz/gitwiki/ContentLimitations says this is by design.

And OK, thinking "file by file" is old fashioned, I read. The non-git
end user should just get used to reading ChangeLogs, if any, and stop
doing ls -lt.

But you must admit, /usr/share/doc/linux-doc-2.6.26/Documentation/
etc. are aimed for reading without git.

Anyways, if just in case any individual file modification time
information can still be pried from the 40 byte IDs or whatever, I
would suggest using it by default in git-archive at least, and maybe
even git-clone etc.

Just letting you know my 'valuable first impressions'. I expect once I
start smoking more of this "git" stuff, I too will become comfortably
numb to aforementioned lowly user problem, so you would never know
unless I hereby first told you before it was too late.
