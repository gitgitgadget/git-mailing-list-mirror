From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-clean won't read global ignore
Date: Wed, 14 Nov 2007 17:46:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711141746130.4362@racer.site>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
 <20071113225057.GB22836@artemis.corp> <7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsMKg-0002jS-AF
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 18:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761379AbXKNRq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 12:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761276AbXKNRq6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 12:46:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:40541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761080AbXKNRq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 12:46:57 -0500
Received: (qmail invoked by alias); 14 Nov 2007 17:46:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 14 Nov 2007 18:46:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MADU9+lRMqBZuIU9I4+5CufA+IkBraB3jOPmTEZ
	OTj0Mw92bQJW/U
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64992>

Hi,

On Wed, 14 Nov 2007, Junio C Hamano wrote:

> To untangle this mess, I think the first step would be something like 
> this (this is against 'maint', as I was in the middle of something else 
> that is based on 'maint' when I started reading this thread).
> 
> The next step would be to teach read-tree, merge-recursive and clean (in 
> C) to use setup_standard_excludes().

I like it.

Ciao,
Dscho
