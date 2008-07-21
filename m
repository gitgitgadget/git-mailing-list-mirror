From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 02:22:48 +0200
Message-ID: <20080721002248.GJ10151@machine.or.cz>
References: <1216592735-23789-1-git-send-email-code@istique.net> <20080720230846.GH32184@machine.or.cz> <7vy73w16nj.fsf@gitster.siamese.dyndns.org> <7vtzek15b5.fsf@gitster.siamese.dyndns.org> <20080721000824.GI10151@machine.or.cz> <7vljzw14br.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?iso-8859-2?Q?Fr=E9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:23:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKjBt-0001N7-Jl
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbYGUAWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbYGUAWu
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:22:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43637 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754539AbYGUAWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:22:50 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B121D393B32D; Mon, 21 Jul 2008 02:22:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljzw14br.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89276>

On Sun, Jul 20, 2008 at 05:14:16PM -0700, Junio C Hamano wrote:
> I never thought you would think "showing relative to tree-root" is even an
> option.

I assume you mean "not filtering relative to tree-root"?

> That would make it inconsistent with not just the established
> semantics of what the plumbing did, but also with what ls-files does.

But ls-files always works on the index; ls-tree can work on trees,
and when you're inspecting a non-root tree object from within
a subdirectory, this behaviour can be rather unexpected. But as I said,
I'm fine with just documenting it.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
