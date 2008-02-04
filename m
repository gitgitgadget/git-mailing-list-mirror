From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-mv: minimum fix to avoid losing files
Date: Mon, 4 Feb 2008 18:08:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041807230.7372@racer.site>
References: <7v3as9mce7.fsf@gitster.siamese.dyndns.org> <7vhcgpkuqz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5lG-0005QB-2S
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYBDSJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbYBDSJE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:09:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:41465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbYBDSJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:09:03 -0500
Received: (qmail invoked by alias); 04 Feb 2008 18:09:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 04 Feb 2008 19:09:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19U01JwNZpUkwzwiI4Yzna+l1ON6JYhUA/IjOVUhn
	/TCBPCm7fPGQBz
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcgpkuqz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72537>

Hi,

On Mon, 4 Feb 2008, Junio C Hamano wrote:

>  * This minimally fixes the issue and applies on top of the
>    "setup: sanitize absolute and funny paths in get_pathspec()"
>    patch I showed during the rc freeze.
> 
>    Dscho CC'ed as he owns the largest number of lines in this
>    source file.

Well, "owns" is a bit too strong, wouldn't you say?  "Is at fault for" 
maybe ;-)

Your patch looks obviously correct; I do not have time to look into other 
breakages of git-mv right now.  Sorry.

Thanks,
Dscho
