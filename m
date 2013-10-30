From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] Add option --no-tags
Date: Wed, 30 Oct 2013 16:06:56 +0100
Message-ID: <87ob66g5m7.fsf@linux-k42r.v.cablecom.net>
References: <CAMXp-VP9DDJ-L=e=7=-bO+ZFVRMVz-PAs0gGv8Q7RrZ-OWof9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Cornu <ncornu@aldebaran-robotics.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:07:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbXMe-0001Aw-EY
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab3J3PHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 11:07:13 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:59477 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab3J3PHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:07:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id AD95C4D6516;
	Wed, 30 Oct 2013 16:07:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5y-ThSkibzSv; Wed, 30 Oct 2013 16:07:00 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.176.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 732794D6414;
	Wed, 30 Oct 2013 16:06:59 +0100 (CET)
In-Reply-To: <CAMXp-VP9DDJ-L=e=7=-bO+ZFVRMVz-PAs0gGv8Q7RrZ-OWof9Q@mail.gmail.com>
	(Nicolas Cornu's message of "Tue, 29 Oct 2013 11:44:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237023>

Nicolas Cornu <ncornu@aldebaran-robotics.com> writes:

> From 1cbc2c49454581a67cce09ada1386dac4ffa2828 Mon Sep 17 00:00:00 2001
> From: Nicolas Cornu <ncornu@aldebaran-robotics.com>
> Date: Tue, 29 Oct 2013 11:31:10 +0100
> Subject: [PATCH] Add option --no-tags
>
> ---
>  gitk-git/gitk | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

This patch suffers from the same problems as the one for the horizontal
scroll bar.  In particular the commit message should (from
Documentation/SubmittingPatches):

  . [explain] the problem the change tries to solve, iow, what is wrong
    with the current code without the change.

  . [justify] the way the change solves the problem, iow, why the
    result with the change is better.

  . [describe] alternate solutions considered but discarded, if any.


On the change itself: from a brief glance it seems you are trying to
hide the tags shown alongside commits (presumably because there are too
many).

However we already have one feature in a similar vein: the tickbox "Hide
remote refs" in Edit->Preferences.  Shouldn't your feature go alongside
it, and be configured in the same way?

-- 
Thomas Rast
tr@thomasrast.ch
