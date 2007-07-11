From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pushing changes to a remote branch
Date: Wed, 11 Jul 2007 14:26:14 -0700
Message-ID: <7v1wfe4op5.fsf@assigned-by-dhcp.cox.net>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net>
	<20070710173401.GB5032@sigill.intra.peff.net>
	<844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
	<20070711193152.GC3069@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jhp-0007ny-GY
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbXGKV0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbXGKV0Q
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:26:16 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34446 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbXGKV0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:26:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212616.BERT1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMSE1X00D1kojtg0000000; Wed, 11 Jul 2007 17:26:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52204>

Jan Hudec <bulb@ucw.cz> writes:

>>   $ git checkout origin/master
>>   Note: moving to "origin/master" which isn't a local branch
>>   If you want to create a new branch from this checkout, you may do so
>>   (now or later) by using -b with the checkout command again. Example:
>>     git checkout -b <new_branch_name>
>>   HEAD is now at f4855d4... 1
>
> The problem of this warning is, that it does not actually say anything about
> detached and that potential commit won't update the ref being checked out.

"Being detached" is a rather geekish synonym to "which isn't a
local branch", isn't it?
