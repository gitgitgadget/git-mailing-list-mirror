From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/3] rebase docs: clarify --merge and --strategy
Date: Sun, 15 Nov 2009 22:11:10 +0100
Message-ID: <200911152211.11928.trast@student.ethz.ch>
References: <cover.1258309432.git.trast@student.ethz.ch> <b7f805f2497d748b685544b64cd91a36c3bdf5d6.1258309432.git.trast@student.ethz.ch> <7v7htrfqi1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 22:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9mOR-0006ps-V0
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 22:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZKOVMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 16:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZKOVMH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 16:12:07 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:22592 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbZKOVMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 16:12:07 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 22:12:09 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 22:11:54 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <7v7htrfqi1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132966>

Junio C Hamano wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e802421..a6f8182 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -229,9 +229,11 @@ OPTIONS
>  	strategy is used, this allows rebase to be aware of renames on the
>  	upstream side.
>  +
> -Note that in a rebase merge (hence merge conflict), the sides are
> -swapped: "theirs" is the to-be-applied patch, and "ours" is the so-far
> -rebased series, starting with <upstream>.
> +Note that a rebase merge works by replaying each commit from the working
> +branch on top of the <upstream> branch.  Because of this, when a merge
> +conflict happens, the side reported as 'ours' is the so-far rebased
> +series, starting with <upstream>, and 'theirs' is the working branch.  In
> +other words, the sides are swapped.

This is much nicer than mine!

> -Due to the peculiarities of 'git-rebase' (see \--merge above), using
> +Because 'git-rebase' replays each commit from the working branch
> +on top of the <upstream> branch using the given strategy,
> +(see \--merge above), using
>  the 'ours' strategy simply discards all patches from the <branch>,
>  which makes little sense.  Thus 'git-rebase' does not accept this
>  strategy.

Here I'm not sure if it makes such a big difference, since we already
explained the problem in --merge (and point to it).  But yours is fine
too.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
