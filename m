From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 12:39:44 +0200
Message-ID: <87hafn2co6.fsf@linux-k42r.v.cablecom.net>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 12:40:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1DX6-00016a-K5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 12:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab3GVKjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 06:39:51 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27439 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757239Ab3GVKjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 06:39:47 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Jul
 2013 12:39:45 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (217.235.60.35) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Jul 2013 12:39:44 +0200
In-Reply-To: <7vy58zozdk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 21 Jul 2013 23:57:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [217.235.60.35]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230973>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/merge-recursive-index-only (2013-07-07) 3 commits
>  - merge-recursive: -Xindex-only to leave worktree unchanged
>  - merge-recursive: untangle double meaning of o->call_depth
>  - merge-recursive: remove dead conditional in update_stages()
>
>  What's the status of this one?
>
>  I am not particularly fond of the second patch that conceptually
>  allows updating working tree during a virtual merge (i.e. addition
>  of o->no_worktree is fine, but there needs a way to make sure it is
>  never set to false when o->depth is not zero).

Blocking on round tuits.  In any case don't merge anything until we see
that it solves git-imerge's problems, so that it has a user ;-)  The next
version will implement a "stateless" mode too, like Michael asked for
(not writing MERGE_HEAD, etc.).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
