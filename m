From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 15:34:43 -0800
Message-ID: <86irg6xht8.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<7v1wmu6ugr.fsf@assigned-by-dhcp.cox.net>
	<86r6uuxi8o.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:52:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxD6l-0003fu-B3
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWLUBw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWLUBw2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:52:28 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:18041 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161124AbWLUBw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:52:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 5E43C8D903;
	Wed, 20 Dec 2006 17:52:03 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 06702-01-17; Wed, 20 Dec 2006 17:52:02 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 078D98FEC2; Wed, 20 Dec 2006 15:34:44 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <86r6uuxi8o.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35006>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> So that's likely how _POSIX_C_SOURCE is getting defined for the rest.

Unfortunately, just deleting the two _XOPEN_SOURCE entries in
git-compat-util.h doesn't do it, even for OSX.  So something more convoluted
here is going on.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
