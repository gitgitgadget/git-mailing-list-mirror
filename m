From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] bash completion: refactor --strategy completion
Date: Fri, 6 Mar 2009 08:16:57 -0800
Message-ID: <20090306161657.GJ16213@spearce.org>
References: <cover.1236314073.git.jaysoffian@gmail.com> <2d83927582e9eed004b9fd12b77105a184277229.1236314073.git.jaysoffian@gmail.com> <20090306160452.GH16213@spearce.org> <76718490903060812q2e7b2eefg5f25c9845f678959@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 17:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfclE-00019q-Mj
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 17:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607AbZCFQRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 11:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbZCFQRA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 11:17:00 -0500
Received: from george.spearce.org ([209.20.77.23]:39692 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbZCFQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 11:16:59 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9CB9D38211; Fri,  6 Mar 2009 16:16:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <76718490903060812q2e7b2eefg5f25c9845f678959@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112461>

Jay Soffian <jaysoffian@gmail.com> wrote:
> On Fri, Mar 6, 2009 at 11:04 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Jay Soffian <jaysoffian@gmail.com> wrote:
> >> The code to complete --strategy was duplicated between _git_rebase and
> >> _git_merge, and is about to gain a third caller (_git_pull). This patch
> >> factors it into its own function.
> >>
> >> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> >
> > Looks OK to me, but I had to squash this in to get it to work.
> > Without this the patch breaks git merge completion entirely:
> 
> Weird, I had it completely backwards but it seemed to work. Probably
> because I was sourcing the new completion into my running shell; I'll
> make sure to startup a new shell next time.
> 
> With the squash (assuming Junio doesn't mind), is it acked-by you or
> should I resend?

Sorry, yes, with the squash it is Ack'd.

-- 
Shawn.
