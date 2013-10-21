From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: RFE: support change-id generation natively
Date: Mon, 21 Oct 2013 18:38:12 +0200
Message-ID: <20131021163812.GA27125@domone.podge>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <1382370119.28365.36627953.50C0496E@webmail.messagingengine.com>
 <CAJo=hJtbciJ3Qg8jo4U5fZ9onf2R2XOospYKGS-jCYz4p-nwRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: james.moger@gitblit.com, Jeremy Rosen <jeremy.rosen@openwide.fr>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 21 18:38:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYIUo-00008P-VY
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 18:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab3JUQiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 12:38:19 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:47610 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab3JUQiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 12:38:18 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 223CB68118;
	Mon, 21 Oct 2013 18:38:13 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id D6D585F96A; Mon, 21 Oct 2013 18:38:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJo=hJtbciJ3Qg8jo4U5fZ9onf2R2XOospYKGS-jCYz4p-nwRw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236433>

On Mon, Oct 21, 2013 at 09:35:07AM -0700, Shawn Pearce wrote:
> On Mon, Oct 21, 2013 at 8:41 AM,  <james.moger@gitblit.com> wrote:
> > The change-id is exactly like a commit-id, it is an SHA-1 value, but it
> > is a constant embedded in the commit message.
> 
> https://gerrit-review.googlesource.com/Documentation/user-changeid.html
> goes into more detail about these.
> 
> > Commit-ids change all the time because of amend; change-ids are constant
> > and they are the key that links commit revisions to a discussion.
> 
> In a mailing list based workflow, when an author revises a patch
> series and resends the new patches aren't linked to the old patches in
> a MUA, because the Message-Ids of the original versions were not
> preserved. Imagine if Git saved that original Message-Id somewhere and
> could properly write In-Reply-To headers so that attempt #2 for each
> patch replies to the end of the thread discussing attempt #1 of the
> same patch. In a 30 patch series. Gerrit does this with Change-Id.
> 
> 
> We briefly considered putting the Change-Id into the commit headers
> (e.g. below the optional encoding) but could not because `git commit`
> doesn't support this. So it went into the footer along with
> Signed-off-by provenance data, which is also not expressible in
> headers.

What about adding that as Note?
