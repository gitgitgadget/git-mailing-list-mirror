From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 5/5] Migrate rebase-i to sequencer
Date: Wed, 30 Jul 2008 14:18:10 +0200
Message-ID: <20080730121810.GC8767@leksak.fem-net>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net> <1217049644-8874-4-git-send-email-s-beyer@gmx.net> <1217049644-8874-5-git-send-email-s-beyer@gmx.net> <1217049644-8874-6-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261652050.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAeF-0000Ex-TZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108AbYG3MSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756036AbYG3MSO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:18:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:42201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755407AbYG3MSN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:18:13 -0400
Received: (qmail invoked by alias); 30 Jul 2008 12:18:11 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp047) with SMTP; 30 Jul 2008 14:18:11 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18eRilt/mkeZobSO44nsWYgzsr7HmRiFL+Hf/JQMN
	pXr9OrRhXcmpI0
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOAd8-0002Zi-Ox; Wed, 30 Jul 2008 14:18:10 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261652050.26810@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90773>

Hi,

Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 26 Jul 2008, Stephan Beyer wrote:
> 
> > For git-rebase-i -p (preserving merges) merges should be
> > rewritten. For this, the sequencer instructions "mark", "merge"
> > and "reset" are used.
> 
> Ah, the ugliness returns.

Yet I have not seen a way that is as flexible and clean as using
mark/merge/reset and imho this is not ugly.
(I know the discussion of the Joerg Sommer patches that introduced mark,
merge and reset.)

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
