From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] install-sh from automake does not like -m without delimiting space
Date: Mon, 3 Dec 2007 20:48:55 -0500
Message-ID: <20071204014855.GU14735@spearce.org>
References: <20071201170540.GS11347@schiele.dyndns.org> <7v1wa3e0h9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:49:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMum-0005Lk-Gv
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXLDBtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbXLDBtB
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:49:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48391 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbXLDBtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:49:00 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IzMtz-0003GL-1Q; Mon, 03 Dec 2007 20:48:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EA50320FBAE; Mon,  3 Dec 2007 20:48:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1wa3e0h9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66988>

Junio C Hamano <gitster@pobox.com> wrote:
> Robert Schiele <rschiele@gmail.com> writes:
> > The install-sh script as shipped with automake requires a space between
> > the -m switch and its argument.  Since this is also the regular way of
> > doing it with other install implementations this change inserts the
> > missing space in all makefiles.
...
> I'll ask Shawn to do that part separately.

The git-gui portion is already in my master branch.  See the
"What's in git-gui.git" I sent out last evening.

-- 
Shawn.
