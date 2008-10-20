From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 21:36:52 +0200
Message-ID: <20081020193652.GA22123@fiberbit.xs4all.nl>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home> <20081020191400.GA18743@fiberbit.xs4all.nl> <20081020192051.GA21770@fiberbit.xs4all.nl> <alpine.LFD.2.00.0810201525540.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:36:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks0ap-0008KU-EN
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 21:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYJTThz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 15:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbYJTThz
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 15:37:55 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1998 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbYJTThy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 15:37:54 -0400
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9KJaqCP088333;
	Mon, 20 Oct 2008 21:36:53 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Ks0Ye-0005nM-PA; Mon, 20 Oct 2008 21:36:52 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201525540.26244@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98729>

On Monday Oktober 20th 2008 at 15:27 Nicolas Pitre wrote:

> > This is on a quadcore. I recently experimented with "git config
> > pack.threads 0" but as it didn't seem to speedup anything I removed
> > it again. Just mention it on the infinitesimal chance it might be
> > important.
> 
> It is not.  And the speedup should be noticeable when you repack, not 
> when you fetch.

No offense meant! I tried a few "git gc" and "git repack" and only
watched the Gnome CPU applet; perhaps everything was already nicely
packed. I'm certainly going to retry now. Thanks for all your good work.
-- 
Marco Roeland
