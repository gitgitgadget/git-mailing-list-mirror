From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: OSX, ZFS, UTF8, git - somebody hates me in this list
Date: Mon, 05 May 2008 12:08:41 -0700
Message-ID: <86fxswa7ra.fsf@blue.stonehenge.com>
References: <86wsm9dbhk.fsf@blue.stonehenge.com>
	<20080504215208.GG29038@spearce.org>
	<86skwxd97d.fsf@blue.stonehenge.com>
	<8663tsbqg0.fsf@blue.stonehenge.com>
	<alpine.LFD.1.10.0805051049440.32269@woody.linux-foundation.org>
	<905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 21:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt644-0007Le-Gb
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 21:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbYEETIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYEETIn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 15:08:43 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:16646 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbYEETIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 15:08:42 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2D2C11DE333; Mon,  5 May 2008 12:08:41 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.5.9; tzolkin = 3 Muluc; haab = 12 Uo
In-Reply-To: <905315640805051200g4c155d15xada4f17e5e2fc424@mail.gmail.com> (tarmigan+git@gmail.com's message of "Mon, 5 May 2008 12:00:48 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81305>

>>>>> "Tarmigan" == Tarmigan  <tarmigan+git@gmail.com> writes:

Tarmigan> ZFS on OSX may just default to "insensitive" and some form of
Tarmigan> normalization especially if they were/are thinking about making it the
Tarmigan> default fs and wanted backwards compatibility for broken apps.
Tarmigan> Randal, can you make a new FS with casesensitivity=sensitive and
Tarmigan> normalization=none and see how it behaves?

As I posted in a followup, without twiddling anything, ZFS on OSX
is case *sensitive*, but apparently still "normalizes", which is causing
the trip-up.  I'll look to see if there are any parameters I can tweak
to keep it from doing that, but I doubt it.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
