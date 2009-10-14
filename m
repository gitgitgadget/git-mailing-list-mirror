From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH 2/5] Introduce new pretty formats %g and %G for reflog information
Date: Wed, 14 Oct 2009 11:58:34 +0200
Message-ID: <200910141158.35050.trast@student.ethz.ch>
References: <cover.1255380039.git.trast@student.ethz.ch> <e0321a8af8d702d24ace33510daff22d02f4e116.1255380039.git.trast@student.ethz.ch> <20091014045918.GA31810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 12:02:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My0gc-0004Uc-EH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbZJNJ75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 05:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbZJNJ75
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 05:59:57 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:26648 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340AbZJNJ74 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 05:59:56 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 14 Oct
 2009 11:59:09 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 14 Oct
 2009 11:59:27 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091014045918.GA31810@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130276>

Jeff King wrote:
> On Mon, Oct 12, 2009 at 11:06:04PM +0200, Thomas Rast wrote:
> 
> > Unfortunately, we also need to pass down the reflog_walk_info from
> > show_log(), so this commit touches a lot of (unrelated) callers to
> > pretty_print_commit() and format_commit_message() to accomodate the
> > extra argument.
> 
> A while back I wanted to add a feature to pretty-printing, and I ran
> into the same situation (though my feature never made it to the list).
> We really end up passing around the same arguments over and over.  Maybe
> it makes sense instead of adding another argument to refactor into a
> "pretty_print_context" struct that contains all of the arguments and
> current state.
> 
> It would be an even more invasive patch, but I think it would make
> things more readable, and make future changes much easier to see.

Ok, I'll try for the next round.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
