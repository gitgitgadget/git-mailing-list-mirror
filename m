From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Use inttypes.h rather than stdint.h.
Date: Thu, 25 Jan 2007 13:54:32 -0800
Message-ID: <868xfqrcvb.fsf@blue.stonehenge.com>
References: <24182.1169759500@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Thu Jan 25 22:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HACYn-00057Q-2x
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbXAYVzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbXAYVzF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:55:05 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:30761 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030609AbXAYVzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:55:04 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3AE991DE804; Thu, 25 Jan 2007 13:54:32 -0800 (PST)
x-mayan-date: Long count = 12.19.14.0.3; tzolkin = 5 Akbal; haab = 16 Muan
In-Reply-To: <24182.1169759500@lotus.CS.Berkeley.EDU> (Jason Riedy's message of "Thu, 25 Jan 2007 13:11:40 -0800")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37766>

>>>>> "Jason" == Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

Jason> Older Solaris machines lack stdint.h but have inttypes.h.
Jason> The standard has inttypes.h including stdint.h, so at worst
Jason> this pollutes the namespace a bit.

Heh... I just ran into this for $client.  Nice.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
