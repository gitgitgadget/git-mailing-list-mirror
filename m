From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Tue, 13 Jan 2009 18:51:11 -0800
Message-ID: <20090114025111.GY10179@spearce.org>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de> <20090114021751.GW10179@spearce.org> <alpine.DEB.1.00.0901140326530.3586@pacific.mpi-cbg.de> <20090114022933.GX10179@spearce.org> <94a0d4530901131846u2121e433ka8620fbb37c8470b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvsD-0007xa-Cx
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbZANCvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbZANCvN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:51:13 -0500
Received: from george.spearce.org ([209.20.77.23]:40669 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbZANCvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:51:12 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1458238210; Wed, 14 Jan 2009 02:51:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a0d4530901131846u2121e433ka8620fbb37c8470b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105579>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> 
> How about the attached patch?
> 
> "S_IFREG | mode" probably is only required for 0644 and 0755.
> 
> It doesn't make sense to do S_IFREG | S_IFLINK (0100000 | 0120000),
> since no bits are changed.

Looks fine to me.

-- 
Shawn.
