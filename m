From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] fast-import: Fix compile warnings
Date: Wed, 7 Feb 2007 18:35:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071829450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm7p7uf9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqhm-0005dW-0Q
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161397AbXBGRfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161403AbXBGRfc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:35:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:56743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161397AbXBGRfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:35:31 -0500
Received: (qmail invoked by alias); 07 Feb 2007 17:35:30 -0000
X-Provags-ID: V01U2FsdGVkX19rZORgqfBrKMQRBHyw60IuglVESWaoCh9gwE7Mbu
	zovg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm7p7uf9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38949>

Hi,

On Wed, 7 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Not on all platforms are size_t and unsigned long equivalent.
> > Since I do not know how portable %z is, I play safe, and just
> > cast the respective variables to unsigned long.
> 
> The format "%s %lu" is consistent with what write_sha1_file_prepare()
> and unpack_sha1_header() uses, so that should be safe enough.

So, should we cast to (unsigned long) to make the gcc warning go away, or 
do we not care at all?

> However, your patch does not apply.

Hmm. Strange, I thought that I only changed the in_merge_bases() line... 
Will have a look tomorrow.

Ciao,
Dscho
