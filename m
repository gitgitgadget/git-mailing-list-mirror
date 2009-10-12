From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH 0/5] Pretty formats for reflog data
Date: Mon, 12 Oct 2009 23:52:23 +0200
Message-ID: <200910122352.25658.trast@student.ethz.ch>
References: <20091012175201.GA10263@coredump.intra.peff.net> <cover.1255380039.git.trast@student.ethz.ch> <20091012213756.GA12166@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT3s-0004FJ-BW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299AbZJLVxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933336AbZJLVxt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:53:49 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:55331 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933338AbZJLVxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:53:48 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:53:02 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:53:03 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091012213756.GA12166@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130083>

Jeff King wrote:
> 
> I'm not sure if people will like having a longer [stash] list in a
> pager than a shorter list without one (I personally can't remember
> ever using "git stash list", so I have no strong opinion).

True.  Then again we patched git-stash(1) to recommend stash/pop over
stash/apply, so we should actively show the user that s/he has a long
stash list and may want to apply them somewhere.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
