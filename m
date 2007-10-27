From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 6/8] add ref_cmp_full_short() comparing full ref name
 with a short name
Date: Sat, 27 Oct 2007 18:16:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710271811260.7345@iabervon.org>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de>
 <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de>
 <11935038084055-git-send-email-prohaska@zib.de> <11935038084130-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 00:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IltxD-0004Ec-Rt
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 00:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXJ0WQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 18:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXJ0WQP
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 18:16:15 -0400
Received: from iabervon.org ([66.92.72.58]:36608 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbXJ0WQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 18:16:14 -0400
Received: (qmail 26117 invoked by uid 1000); 27 Oct 2007 22:16:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2007 22:16:13 -0000
In-Reply-To: <11935038084130-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62515>

On Sat, 27 Oct 2007, Steffen Prohaska wrote:

> ref_cmp_full_short(full_name, short_name) expands short_name according
> to the rules documented in git-rev-parse and compares the expanded
> name with full_name. It reports a match by returning 0.
> 
> This function makes the rules for resolving refs to sha1s available
> for string comparison. Before this change, the rules were buried in
> get_sha1*() and dwim_ref().
> 
> ref_cmp_full_short() will be used for matching refspecs in git-send-pack.

I think this and ref_matches_abbrev in remote.c should be both be 
named to be more explicit as to which sets of rules they implement, and 
should agree on order of arguments.

	-Daniel
*This .sig left intentionally blank*
