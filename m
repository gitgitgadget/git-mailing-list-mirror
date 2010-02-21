From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v3 00/12] several notes refs, post-rewrite, notes rewriting
Date: Sun, 21 Feb 2010 07:14:02 +0100
Message-ID: <201002210714.02408.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch> <cover.1266703765.git.trast@student.ethz.ch> <7vhbpb2qsm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 07:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj55U-0004NF-A5
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 07:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0BUGO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 01:14:27 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:4132 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab0BUGO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 01:14:26 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 21 Feb
 2010 07:14:24 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 21 Feb
 2010 07:14:02 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7vhbpb2qsm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140595>

On Sunday 21 February 2010 04:47:37 Junio C Hamano wrote:
> 
> I like the general direction in which this series is going, but a config
> that does not have any command line counterpart is a design mistake.

I hate[1] to point out that according to the same criterion, the
*current* notes are a design mistake.  Unless you count GIT_NOTES_REF,
in which case in my opinion...

> Hmm; if this will _always_ be limited to "git notes" command and no other
> commands will _ever_ learn a command line option to override what notes
> namespace to use in the future, then "--ref" is perfectly a good name.
> But otherwise, "git log --ref=notes/amlog" would look _very wrong_, and
> would end up being called "git log --notes-ref=notes/amlog" instead.  When
> that happens, "git notes --ref=notes/amlog" would look inconsistent and
> people will complain, no?

... the obvious extension of the same would be GIT_NOTES_DISPLAY_REF
(colon separated list of globs), GIT_NOTES_REWRITE_REF,
GIT_NOTES_REWRITE_MODE, and whatnot.

Which could still be made into a "global" option along the same lines
as GIT_WORK_TREE.

I don't really want to go the other way and patch every command that
could conceivably have notes in its output.


[1] No I don't, that just sounded nice.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
