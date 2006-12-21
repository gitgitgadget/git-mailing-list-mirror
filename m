From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 17:50:34 -0800
Message-ID: <86hcvqvwyd.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<8664c6xdgi.fsf@blue.stonehenge.com>
	<24BF45E9-DD98-4609-9D65-B01EAA30CCA8@silverinsanity.com>
	<86psaevxo3.fsf@blue.stonehenge.com>
	<7v64c63tol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Terje Sten Bjerkseth" <terje@bjerkseth.org>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:50:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxD4x-0003Ow-B7
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWLUBuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWLUBuh
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:50:37 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:19582 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161129AbWLUBug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:50:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 969208F5A3;
	Wed, 20 Dec 2006 17:50:35 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 06702-01-13; Wed, 20 Dec 2006 17:50:34 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E28528F5D4; Wed, 20 Dec 2006 17:50:34 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <7v64c63tol.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35005>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Just to make sure... the attached looks exactly what Terje's
Junio> patch would have been before the whitespace damage.  Can I take
Junio> this as confirmation that the patch works for you and Terje?

The patch I uploaded should be character-equivalent to Terje's.
I don't know what "whitespace damage" you're referencing.

Junio> I wonder what the earlier failure you got from "the moral
Junio> equivalent" was -- I hope it is not an indication that we have a
Junio> dependency bug in our Makefile somewhere.

Yeah, I'm not sure why

#if 0
those two defines
#end

doesn't do the same thing.  Oh well, shrug.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
