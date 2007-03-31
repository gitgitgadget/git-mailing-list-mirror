From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Rename warn() to warning() to fix symbol conflicts on BSD and Mac OS
Date: Sat, 31 Mar 2007 07:48:35 -0700
Message-ID: <863b3lfozg.fsf@blue.stonehenge.com>
References: <11752960251394-git-send-email-tytso@mit.edu>
	<7vejn5ygkc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 16:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXesi-0001vN-2R
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 16:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbXCaOsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 10:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbXCaOsh
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 10:48:37 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:29843 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbXCaOsg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 10:48:36 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E34B21DE55A; Sat, 31 Mar 2007 07:48:35 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.8; tzolkin = 5 Lamat; haab = 1 Uayeb
In-Reply-To: <7vejn5ygkc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 31 Mar 2007 01:15:31 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43558>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> I'd take this for now, but I wonder where we should stop.  If
Junio> somebody exports error() or die(), would we end up renaming them
Junio> to git_error() and git_die()?

I realize you may see it as a slippery slope, but I haven't heard anything
else reported yet, and git has already been ported quite a bit.  But since C
has a flat namespace, this will always be a problem.

Picking a name like warn(3) was probably dumb on bsd's part, but it *is* a
generic call like perror(3).

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
