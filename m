From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 4 Sep 2007 15:58:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041557590.28586@racer.site>
References: <46DD6020.4050401@gmail.com> <Pine.LNX.4.64.0709041444070.28586@racer.site>
 <46DD6B93.10005@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZrs-00042T-NQ
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbXIDO67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbXIDO67
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:58:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:57192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753305AbXIDO67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:58:59 -0400
Received: (qmail invoked by alias); 04 Sep 2007 14:58:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 04 Sep 2007 16:58:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189whYyBDs94oBFafxScI7kFKWYPbB5VMtoMlWMIW
	1EQrzMFFBTT7Cb
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD6B93.10005@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57590>

Hi,

On Tue, 4 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Tue, 4 Sep 2007, Carlos Rica wrote:
> > > +int update_ref_or_die(const char *action, const char *refname,
> > > +				const unsigned char *sha1,
> > > +				const unsigned char *oldval, int flags)
> > 
> > Should this not be "void"?  And should it not use update_ref_or_error()?
> 
> It should not use *_error() directly because then it would print two error
> messages in a row.

Well, my idea was to let _error() print the message, and just die().

Ciao,
Dscho
