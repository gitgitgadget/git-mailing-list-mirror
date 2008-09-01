From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: use apply --unidiff-zero when staging hunks
	without context
Date: Mon, 1 Sep 2008 12:40:04 -0700
Message-ID: <20080901194004.GH7482@spearce.org>
References: <20080830164527.GA25370@localhost> <20080830165600.GB25370@localhost> <48B9A2D7.8090801@telecom.at> <20080830202706.GA13573@localhost> <7vprnqfcoo.fsf@gitster.siamese.dyndns.org> <20080830210007.GA15004@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaFGy-0001nG-It
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYIATkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYIATkG
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:40:06 -0400
Received: from george.spearce.org ([209.20.77.23]:55056 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYIATkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:40:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1AF3B38375; Mon,  1 Sep 2008 19:40:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080830210007.GA15004@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94605>

Clemens Buchacher <drizzd@aon.at> wrote:
> On Sat, Aug 30, 2008 at 01:52:23PM -0700, Junio C Hamano wrote:
> > Well, showing is Ok as long as you do not try pick and apply.  Or did I
> > miss something?
> 
> If I understand correctly git gui bases its patches on what it shows in the
> diff window - which makes sense, because otherwise it would be a PITA to
> find out which hunk the user actually wanted.
> 
> We could allow diffs without context and disable staging in that case, but I
> suspect this would only confuse the user.

I agree.  Lets just disallow zero-context diffs.  Its far easier
for the user to understand the diff limit is 1.

-- 
Shawn.
