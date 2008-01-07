From: Jeff King <peff@peff.net>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 6 Jan 2008 20:48:30 -0500
Message-ID: <20080107014830.GB17748@coredump.intra.peff.net>
References: <7vy7btaf4p.fsf@gitster.siamese.dyndns.org> <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org> <7v63y8ble8.fsf@gitster.siamese.dyndns.org> <20080106042409.GA4843@coredump.intra.peff.net> <20080106042935.GB4843@coredump.intra.peff.net> <7vejcv5is3.fsf@gitster.siamese.dyndns.org> <20080106111725.GA11603@coredump.intra.peff.net> <7vy7b33zjk.fsf@gitster.siamese.dyndns.org> <20080106205946.GA17482@coredump.intra.peff.net> <7vlk724pji.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 02:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBh78-0002Td-Ev
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 02:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbYAGBse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 20:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYAGBse
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 20:48:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3348 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbYAGBsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 20:48:33 -0500
Received: (qmail 2411 invoked by uid 111); 7 Jan 2008 01:48:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 20:48:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 20:48:30 -0500
Content-Disposition: inline
In-Reply-To: <7vlk724pji.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69751>

On Sun, Jan 06, 2008 at 01:22:57PM -0800, Junio C Hamano wrote:

> Yes, to a certain extent with Perl (I think if you make the same
> typo twice you won't get much help, and that is quite easy to
> trigger with variable name autocompletion and cut-and-paste).

Yes, and a static checking language would be a little less error-prone.
But who can live without "eval <STDIN>"? :)

> I suspect "if (!$menu_use_color)" might need to be refined in
> sub "highlight_prefix".  It should be tied with $prompt_color
> somehow (i.e. either it is undef or the "plain" color),
> shouldn't it?

I'm not sure. It avoids printing the brackets in "[p]atch". If you say
"use color, but make the color plain" does that mean you want brackets
or not (right now it will not show brackets)?

> But other than that the result looks quite nice.  I shuffled the
> patches around and the resulting series consists of three patches:

Great. That is the order I would have chosen as well (and hopefully I
gave you enough material in the commit messages to cut and paste
something sensible).

-Peff
