From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v2] Documentation fixes in git-config
Date: Sun, 23 Jan 2011 20:46:52 +0100
Message-ID: <20110123194538.GA4372@localhost.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net> <20110119100105.GB8034@fm.suse.cz> <20110119141401.GE8034@fm.suse.cz> <20110121002716.GC9442@sigill.intra.peff.net> <20110121102048.GF19715@fm.suse.cz> <20110121102537.GH19715@fm.suse.cz> <20110121162537.GD21840@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 23 20:47:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph5ts-0005hO-Ih
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 20:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1AWTqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 14:46:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:45393 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab1AWTqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 14:46:54 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 71F0187567;
	Sun, 23 Jan 2011 20:46:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110121162537.GD21840@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165428>

On Fri 21-01-11 11:25:37, Jeff King wrote:
> I am half-tempted to mark the lowercasing of the regex as deprecated (or
> at least discouraged).

That's actually side effect of
http://git.kernel.org/?p=git/git.git;a=commitdiff;h=2fa9a0fb31cbf01e8318a02c3e222d7fd3fd0a83
Don't see any intent to support "mixed-sensitivity" matching in it.

> It's such a hack, and I don't think we will ever improve to make it work in
> the general case, as regexes are simply too complex for us to handle all
> possible inputs.

As far as I understand git uses host library implementation of regcomp and
regexec so we cannot fix that side.  Writing code to modify regexes is not
worth the effort.

FWIW I'm in favor of deprecating this functionality.

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
