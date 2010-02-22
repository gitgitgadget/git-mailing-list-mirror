From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 00/11] several notes refs, post-rewrite, notes rewriting
Date: Mon, 22 Feb 2010 01:32:53 +0100
Message-ID: <201002220132.53455.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch> <cover.1266797028.git.trast@student.ethz.ch> <7vr5oeazhd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjMEj-0001Tz-Rw
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab0BVAdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:33:17 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:44315 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796Ab0BVAdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:33:16 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:33:15 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:32:55 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7vr5oeazhd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140636>

On Monday 22 February 2010 01:25:02 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > core.notesRef should be in that list
> > implicitly, and I think the natural position if it is unsorted would
> > be: first.
> 
> I think that is a sane thing to do, and then any additional ones can come
> after that first one, in the order specified by displayRef.  Isn't that
> what you are doing, no?

Yes, I just wanted to spell out why I originally decided for the
sorted instead of user-ordered way:

> > However, that means that changing core.notesRef or GIT_NOTES_REF
> > can shuffle around your notes, which I thought would be confusing.

But that wasn't a strong preference at all, so doing it like you
suggested (and like the code is in v4) is fine by me.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
