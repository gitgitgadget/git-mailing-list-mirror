From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/6 (v4)] support for commit grafts, slight change to
	general mechanism
Date: Tue, 29 Sep 2009 09:34:14 -0700
Message-ID: <20090929163414.GA25756@spearce.org>
References: <op.uzv4dyuotdk399@sirnot.private> <op.u0xtfzjrtdk399@sirnot.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 18:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msfeh-000317-6X
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 18:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbZI2QeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 12:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZI2QeK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 12:34:10 -0400
Received: from george.spearce.org ([209.20.77.23]:46709 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbZI2QeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 12:34:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F244381FF; Tue, 29 Sep 2009 16:34:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <op.u0xtfzjrtdk399@sirnot.ed.ac.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129312>

Nick Edelen <sirnot@gmail.com> wrote:
> Adds support for graft commits in rev-cache (w/ test), and slightly alters
> graft mechanism.  Before, parse_commit() checked the graft list on every
> commit.  Now register_commit_graft() preemptively loads graft commits into
> memory, and sets a new 'graft' flag in the object.  This allows awareness of
> the commits' medical history without searching a (normally private) array upon
> each commit.
...
> diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
> index 4c1766d..b36bc39 100644

This doesn't apply against ne/rev-cache^, and I don't have the
blobs in my repostiory.  So I'm dropping this patch and will wait
for a resend of the series or something...

-- 
Shawn.
