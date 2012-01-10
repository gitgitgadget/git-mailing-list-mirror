From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] gitignore: warn about pointless syntax
Date: Tue, 10 Jan 2012 10:44:58 +0100
Message-ID: <87d3arnb6t.fsf@thomas.inf.ethz.ch>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
	<1326123647-18352-2-git-send-email-jengelh@medozas.de>
	<20120109162802.GA2374@sigill.intra.peff.net>
	<7vhb04ek6e.fsf@alter.siamese.dyndns.org>
	<20120109223358.GA9902@sigill.intra.peff.net>
	<alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	<git@vger.kernel.org>
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Tue Jan 10 10:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkYGf-00074o-EM
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 10:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab2AJJpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 04:45:04 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41713 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab2AJJpB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 04:45:01 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 10:44:57 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 10 Jan
 2012 10:44:58 +0100
In-Reply-To: <alpine.LNX.2.01.1201100639340.11534@frira.zrqbmnf.qr> (Jan
	Engelhardt's message of "Tue, 10 Jan 2012 06:42:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188230>

Jan Engelhardt <jengelh@medozas.de> writes:
>
> As I see it, foo/**/*.o for example is equal to placing "*.o" in
> foo/.gitignore, so the feature is already implemented, just not
> through the syntax people falsely assume it is. And that is the
> reason for wanting to output a warning. If it was me, I'd even make
> it use error(),

No, please don't even think about it.  Having an error() there would
mean that git would be essentially useless in repositories that have
this mistake, and the user may not be in a position to fix the
repository!

(He could drag along a local change to that effect, which is highly
annoying if the repository is otherwise read-only for him.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
