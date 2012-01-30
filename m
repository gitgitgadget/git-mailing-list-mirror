From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Mon, 30 Jan 2012 18:06:52 +0100
Message-ID: <87hazdazmb.fsf@thomas.inf.ethz.ch>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 18:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rruh3-0005Nn-W5
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab2A3RG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:06:57 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:40959 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab2A3RGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:06:55 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 18:06:51 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 18:06:52 +0100
In-Reply-To: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.3.1-59-g676d251 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-suse-linux-gnu)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189376>

On Mon, 23 Jan 2012 14:18:40 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Traditionally, a cleanly resolved merge was committed by "git merge" using
> the auto-generated merge commit log message with invoking the editor.
> 
> After 5 years of use in the field, it turns out that people perform too
> many unjustified merges of the upstream history into their topic branches.
> These merges are not just useless, but they are often not explained well,
> and making the end result unreadable when it gets time for merging their
> history back to their upstream.

Ok, so I'm late to the party and perhaps I missed the discussion about
this, but...

I think the proposed commit message should have a comment, just like for
an ordinary commit, that explains why we are showing the user an editor.
(I'm too lazy to check, but I suspect we *always* give a comment about
what is going on when we fire up an editor.)

I would suggest something like

# Please enter the commit message for your merge commit.  Lines starting
# with '#' will be ignored, and an empty message aborts the commit.

or if you feel comfortable with educating the user in a
workflow-specific way, even

# Please enter the commit message for your merge commit.  You should
# justify it especially if it merges an updated upstream into a topic
# branch.
# 
# Lines starting with '#' will be ignored, and an empty message aborts
# the commit.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
