From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 21:20:52 +0200
Message-ID: <20081020192051.GA21770@fiberbit.xs4all.nl>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home> <20081020191400.GA18743@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:45:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks0Tv-0006Is-A7
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 21:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbYJTTaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 15:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYJTTaq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 15:30:46 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:2796 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbYJTTaq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 15:30:46 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Oct 2008 15:30:45 EDT
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9KJKqHV081265;
	Mon, 20 Oct 2008 21:20:57 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Ks0JA-0005gR-0s; Mon, 20 Oct 2008 21:20:52 +0200
Content-Disposition: inline
In-Reply-To: <20081020191400.GA18743@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98736>

Op maandag 20 oktober 2008 om 21:14 uur schreef Marco Roeland het volgende:

> This is on Debian 'sid' with an AMD64 architecture.
> 
> I've put the whole ".git" directory (warning: almost 35MB) for
> investigation at:
> 
> http://www.xs4all.nl/~fiberbit/http://www.xs4all.nl/~fiberbit/git-next-8f0e41f3-bad-index.tgz

Gah, I can't even copy-and-paste:

http://www.xs4all.nl/~fiberbit/git-next-8f0e41f3-bad-index.tgz

This is on a quadcore. I recently experimented with "git config
pack.threads 0" but as it didn't seem to speedup anything I removed
it again. Just mention it on the infinitesimal chance it might be
important.
-- 
Marco Roeland
