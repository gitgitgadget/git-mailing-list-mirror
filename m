From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
 script
Date: Tue, 11 May 2010 10:35:08 +0200
Message-ID: <20100511083508.GM1951@machine.or.cz>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
 <201005092018.54580.jnareb@gmail.com>
 <20100510071340.GA3382@screwed.box>
 <201005101729.07334.jnareb@gmail.com>
 <20100511062415.GA5220@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue May 11 10:35:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBkvx-0005Lc-L6
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 10:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab0EKIfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 04:35:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39895 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab0EKIfL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 04:35:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D780C86208C; Tue, 11 May 2010 10:35:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100511062415.GA5220@screwed.box>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146880>

On Tue, May 11, 2010 at 10:24:15AM +0400, Peter Vereshagin wrote:
> JN> Gitweb doesn't use no POST requests: it is read-only web repository
> JN> browser... well, except for the 'show_ctags' action.
> 
> Tag cloud? Is there an example of usable tag cloud on any public gitweb out
> there?

See http://repo.or.cz/ for an example.

I don't think it's essential to support ctags under all configurations,
if doing so is too troublesome. But I expect our current GSoC to want
to add some more POST forms too.

-- 
				Petr "Pasky" Baudis
When I feel like exercising, I just lie down until the feeling
goes away.  -- xed_over
