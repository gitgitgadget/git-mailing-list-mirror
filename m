From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Doing a dummy or empty merge
Date: Thu, 11 Mar 2010 13:16:58 -0800
Message-ID: <864okmeeyd.fsf@blue.stonehenge.com>
References: <8440EA2C12E50645A68C4AA9887166513FC480@SERVER.webdezign.local>
	<86wrxiepv3.fsf@blue.stonehenge.com>
	<7vljdyzjsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Richard Lee" <richard@webdezign.co.uk>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 22:17:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nppkh-0000DO-65
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 22:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab0CKVQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 16:16:59 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:38462 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab0CKVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 16:16:58 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 513231DE175; Thu, 11 Mar 2010 13:16:58 -0800 (PST)
x-mayan-date: Long count = 12.19.17.3.4; tzolkin = 2 Kan; haab = 2 Cumku
In-Reply-To: <7vljdyzjsy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu, 11 Mar 2010 12:26:37 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142000>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> After the above "merge -s ours", you obviously can never merge from
Junio> live to test.  You have declared that you favor the live configuration
Junio> over the test configuration with that merge commit, and merging a
Junio> branch that has that merge commit (i.e. live) into any branch
Junio> (i.e. test) is your consent to be bound by that declaration.  The
Junio> resulting backmerge will wipe the test configuration and replace it
Junio> with that from live.

Very good point.  But a cherry-pick would work, right?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
