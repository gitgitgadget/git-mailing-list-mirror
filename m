From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 02:08:24 +0200
Message-ID: <20080721000824.GI10151@machine.or.cz>
References: <1216592735-23789-1-git-send-email-code@istique.net> <20080720230846.GH32184@machine.or.cz> <7vy73w16nj.fsf@gitster.siamese.dyndns.org> <7vtzek15b5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?iso-8859-2?Q?Fr=E9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiy3-0006tr-Ig
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599AbYGUAI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbYGUAI2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:08:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51217 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758550AbYGUAI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:08:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B1598393B32D; Mon, 21 Jul 2008 02:08:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzek15b5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89272>

On Sun, Jul 20, 2008 at 04:53:02PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> >
> >> I think that ls-tree simply shouldn't auto-fill its pathspec based on
> >> current prefix in case no pathspec was supplied. Patch to follow.
> >
> > Have you dug the list archive from mid-to-late December 2005 that prompted
> > the current behaviour (and introduction of --full-name)?  I haven't.
> 
> Now, I did:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/13028/focus=13135
> 
> I think the answer is --full-name (cf. a69dd58 (ls-tree: chomp leading
> directories when run from a subdirectory, 2005-12-23)).

I don't understand your point now.  --full-name cares only about the
displaying part; do you suggest that it should be extended to also turn
off prepending the prefix during the filtering phase? That would make a
lot of sense, if you are not worried about compatibility trouble.

-- 
			Petr "Pasky, missing something" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
