From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] index-pack: Track the object_entry that creates
	each base_data
Date: Tue, 15 Jul 2008 03:20:08 +0000
Message-ID: <20080715032008.GE1700@spearce.org>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org> <1216001267-33235-2-git-send-email-spearce@spearce.org> <1216001267-33235-3-git-send-email-spearce@spearce.org> <1216001267-33235-4-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807142249100.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIb6E-0001Vk-15
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYGODUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYGODUK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:20:10 -0400
Received: from george.spearce.org ([209.20.77.23]:52185 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbYGODUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:20:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0A2253836B; Tue, 15 Jul 2008 03:20:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807142249100.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88512>

Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 13 Jul 2008, Shawn O. Pearce wrote:
> 
> > If we free the data stored within a base_data we need the struct
> > object_entry to get the data back again for use with another
> > dependent delta.  Storing the object_entry* makes it simple to call
> > get_data_from_pack() to recover the compressed information.
> > 
> > This however means we must add the missing baes object to the end
> 
> Typo?

Yea, Dscho also pointed it out.

Junio, if you can, please fix this typo in the commit message.

Its not really a big deal.  I have no plans on posting a replacement
patch just for this one small typo.  Plenty of my current commits
in git.git have typos too.  I'm not that good of a typist.  And gcc
doesn't check my commit messages.  ;-)
 
-- 
Shawn.
