From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 1/1] Add commit log message spell checking feature.
Date: Wed, 03 Mar 2010 09:36:36 +0200
Message-ID: <87aaupj1q3.fsf@mithlond.arda>
References: <alpine.LNX.2.00.1002281258340.15334@vqena.qenxr.bet.am>
	<7e21d6cd64aa088763c3ff11d6cbe78899ae7f10.1267314986.git.sdrake@xnet.co.nz>
	<20100228163339.GA9399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 08:36:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmj8a-0004rv-HF
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 08:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab0CCHgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 02:36:52 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:58021 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116Ab0CCHgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 02:36:51 -0500
Received: from mithlond.arda (84.251.132.215) by jenni2.inet.fi (8.5.014)
        id 4B17EA3D03ABD649; Wed, 3 Mar 2010 09:36:40 +0200
Received: from dtw by mithlond.arda with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Nmj8G-0001BO-Us; Wed, 03 Mar 2010 09:36:36 +0200
In-Reply-To: <20100228163339.GA9399@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 28 Feb 2010 11:33:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141439>

* 2010-02-28 11:33 (-0500), Jeff King wrote:

> On Sun, Feb 28, 2010 at 01:03:00PM +1300, Steven Drake wrote:
>> Add 'git commit --spell' to run a spell checker on commit log
>> message. The `commit.spell` configuration variable can be used to
>> enable the spell checker by default and can be turned off by
>> '--no-spell'.
>
> Isn't this exactly the sort of thing the commit-msg hook is for?
> Though personally I would probably just invoke interactive
> spell-checking from the editor.

I agree that it's a job for user's text editor.
