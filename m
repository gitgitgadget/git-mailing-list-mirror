From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add -v|--verbose to git remote to show remote url
Date: Thu, 05 Jul 2007 15:10:03 -0700
Message-ID: <7vps36ijt0.fsf@assigned-by-dhcp.cox.net>
References: <20070705215730.GC8751@steel.home>
	<20070705220247.GD8751@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 00:10:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ZWv-0004gt-L9
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760950AbXGEWKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760001AbXGEWKG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 18:10:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60707 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759237AbXGEWKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 18:10:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705221003.GEKS17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 5 Jul 2007 18:10:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KyA31X0061kojtg0000000; Thu, 05 Jul 2007 18:10:03 -0400
In-Reply-To: <20070705220247.GD8751@steel.home> (Alex Riesen's message of
	"Fri, 6 Jul 2007 00:02:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51699>

Alex Riesen <raa.lkml@gmail.com> writes:

> Alex Riesen, Thu, Jul 05, 2007 23:57:30 +0200:
>> +local $VERBOSE = 0;
>> +@ARGV = grep { $VERBOSE=1,0 if $_ eq '-v' or $_ eq '--verbose' } @ARGV;
>> +
>
> Do NOT apply: this filters out _all_ of command line.

Heh, I was wondering what you were smoking ;-).
