From: Jeff King <peff@peff.net>
Subject: Re: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 17:49:10 -0800
Message-ID: <20130121014910.GA4792@sigill.intra.peff.net>
References: <kdgtir$apt$1@ger.gmane.org>
 <7vk3r7llod.fsf@alter.siamese.dyndns.org>
 <kdhfk6$von$1@ger.gmane.org>
 <7v8v7nli2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 02:49:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6Vy-0002zV-6I
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab3AUBtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:49:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38855 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab3AUBtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:49:13 -0500
Received: (qmail 13169 invoked by uid 107); 21 Jan 2013 01:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Jan 2013 20:50:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jan 2013 17:49:10 -0800
Content-Disposition: inline
In-Reply-To: <7v8v7nli2a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214071>

On Sun, Jan 20, 2013 at 12:23:41PM -0800, Junio C Hamano wrote:

> In any case, the intent of the author timestamp is to record the
> time the author _started_ working on the change and came up with an
> initial, possibly a partial, draft.  It does not record the time
> when the commit was finalized.  "git commit --amend" preserves the
> original timestamp, doesn't it?

And we have "--reset-author" if you want to do that. It seems like just
doing "git commit --amend --reset-author" at the end[1] would solve the
original problem.  Perhaps that is something that we could better
support directly from the instruction sheet.

-Peff

[1] or after an "edit" break in the instruction sheet, if it is in the
    middle of a set of commits
