From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to
	human readable form
Date: Thu, 14 Aug 2008 17:52:12 -0700
Message-ID: <20080815005212.GI3782@spearce.org>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us> <20080814223429.GC10544@machine.or.cz> <48A4D1DD.9060202@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:53:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTnZA-0006uq-2g
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYHOAwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbYHOAwO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:52:14 -0400
Received: from george.spearce.org ([209.20.77.23]:43935 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYHOAwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:52:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7446F38375; Fri, 15 Aug 2008 00:52:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48A4D1DD.9060202@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92453>

Marcus Griep <marcus@griep.us> wrote:
> Petr Baudis wrote:
> > Whitespace damage? Also at a lot of other places in your patch.
> 
> No damage.  It was indicated to me that 80-ish was the preferred width, so
> I was trying to follow that.  If that's not true in the C sources, I'll
> bundle things up a bit more.

The sources are roughly:

- 80 columns wide, try not to make it wider;

- ident leading part of line with _TABs_ not spaces;

- tab width in your editor should be 8, so you see when you
  are too wide;

- one tab per block in C;

- don't align variable names in declarations;

- use {} only around complex statements;

... there's more.  But if you follow the above along with "dammit,
make it match the code above and below where you are inserting"
you get it pretty quick.

-- 
Shawn.
