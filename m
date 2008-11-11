From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Tue, 11 Nov 2008 14:49:54 +0900
Message-ID: <buoej1iak1p.fsf@dhapc248.dev.necel.com>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
	<20081029164253.GA3172@sigill.intra.peff.net>
	<ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
	<alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<20081029171122.GA12167@sigill.intra.peff.net>
	<20081102123519.GA21251@atjola.homenet>
	<7vljw2yo93.fsf@gitster.siamese.dyndns.org>
	<20081103071420.GD10772@coredump.intra.peff.net>
	<32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org,
	"Stephan Beyer" <s-beyer@gmx.net>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 06:51:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzmA4-0007Ej-6z
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbYKKFuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYKKFuU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:50:20 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:46732 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYKKFuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:50:19 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mAB5nuZQ001576;
	Tue, 11 Nov 2008 14:49:56 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Tue, 11 Nov 2008 14:49:56 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Tue, 11 Nov 2008 14:49:56 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id F216776D; Tue, 11 Nov 2008 14:49:55 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com>
	(Avery Pennarun's message of "Mon, 10 Nov 2008 23:04:42 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100625>

"Avery Pennarun" <apenwarr@gmail.com> writes:
> Speaking just for myself, I would find this all a lot less confusing
> if "staged" were a refspec of some sort, not an option at all.
>
>    git diff HEAD..STAGED
>    git diff STAGED..WORKTREE
>    git grep pattern STAGED HEAD sillybranch WORKTREE ^ignorebranch --
> path/to/files

Another thing that seems strange to me is that the operation of diffing
HEAD..STAGED is so verbose -- currently it's "git diff --cached", with
no short option.

Surely this is very common operation... I rather often want to see
details of what's staged for commit...

-Miles

-- 
If you can't beat them, arrange to have them beaten.  [George Carlin]
