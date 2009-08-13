From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 10:52:11 -0700
Message-ID: <20090813175211.GQ1033@spearce.org>
References: <20090813150446.GM1033@spearce.org> <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> <20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> <20090813172508.GO1033@spearce.org> <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com> <20090813174119.GP1033@spearce.org> <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbeTL-00031g-O9
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZHMRwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbZHMRwK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:52:10 -0400
Received: from george.spearce.org ([209.20.77.23]:59358 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbZHMRwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:52:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AF96E381FD; Thu, 13 Aug 2009 17:52:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125849>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, Aug 13, 2009 at 10:41, Shawn O. Pearce<spearce@spearce.org> wrote:
> > Uh, no, if we have "option import-marks=..." and we can't find the
> > file "..." and we have no --import-marks command line flag that
> > would have overridden it, we need to abort with an error.
> 
> Ah, then how about in option_import_marks() we only store the name of
> the file, like in option_export_marks, and at the end, when we reach
> the first non-option command (and we've parsed argv), we read the
> file. That way it's only read once, and it deals with the above
> scenario.

That's better.  :-)

-- 
Shawn.
