From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 22:57:01 -0700
Message-ID: <7vpscqgo9e.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 07:57:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga4QP-00030w-4u
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 07:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWJRF5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 01:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWJRF5F
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 01:57:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45721 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751429AbWJRF5C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 01:57:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018055702.QJKL6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Oct 2006 01:57:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bhwo1V00J1kojtg0000000
	Wed, 18 Oct 2006 01:56:49 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20061018053647.GA3507@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 18 Oct 2006 01:36:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29191>

Jeff King <peff@peff.net> writes:

> We could always make a guess ("git send --remote-has master~10") but
> that seems awfully error-prone. I assume a changeset-oriented system
> would implicitly keep some concept of "I think Linus is at master~10"
> and do it automatically.

We could always anchor at a well known point ("git send v2.6.18..").
If you as the recipient do not have the preimage, the "bundle" would
identify what the assumed common ancestor is and you can fetch
it before proceeding.
