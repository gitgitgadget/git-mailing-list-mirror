From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Sat, 15 Nov 2008 00:38:41 -0500
Message-ID: <20081115053841.GA20763@coredump.intra.peff.net>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org> <7vy6zl7drn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>, Theodore Ts'o <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 06:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Dt1-0000Hs-Rt
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 06:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYKOFio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 00:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYKOFio
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 00:38:44 -0500
Received: from peff.net ([208.65.91.99]:1717 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbYKOFio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 00:38:44 -0500
Received: (qmail 3786 invoked by uid 111); 15 Nov 2008 05:38:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 15 Nov 2008 00:38:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Nov 2008 00:38:41 -0500
Content-Disposition: inline
In-Reply-To: <7vy6zl7drn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101047>

On Fri, Nov 14, 2008 at 09:35:08PM -0800, Junio C Hamano wrote:

> > -'git mergetool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<file>]...
> 
> I wonder why this even needs to be an option.  If you do not want to
> resolve all of them, you can limit the amount of work you would do by
> giving list of paths to work on, can't you?

I don't know about Charles, but I often don't know that I don't want to
merge a file using the graphical tool until I see it in the graphical
tool. IOW, I start trying to merge it there and realize the conflict is
such that I am better off doing it in my editor with conflict markers.

-Peff
