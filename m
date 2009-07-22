From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH v2 0/1] Fix rebase -p --onto
Date: Wed, 22 Jul 2009 13:36:36 -0400
Message-ID: <20090722173635.GN7878@vinegar-pot.mit.edu>
References: <20090722163738.GO7503@vinegar-pot.mit.edu> <alpine.DEB.1.00.0907221905360.7343@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 22 19:36:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTfkI-0001Op-4P
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 19:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbZGVRgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 13:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbZGVRgl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 13:36:41 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55235 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869AbZGVRgk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 13:36:40 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6MHab4s003382;
	Wed, 22 Jul 2009 13:36:37 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6MHaaGm015424;
	Wed, 22 Jul 2009 13:36:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0907221905360.7343@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123758>

On Wed, Jul 22, 2009 at 07:07:17PM +0200, Johannes Schindelin wrote:
> On Wed, 22 Jul 2009, Greg Price wrote:
> > [...] when the great day comes that rebase -i -p can reorder commits 
> 
> If you want to help, I would be so thankful.  In that case, it might make 
> more sense to hold off this patch and integrate it into the rebase-i-p 
> patch series, rather than requiring a rebase of rebase-i-p on top of your 
> patches, which will postpone said day only further.

Where is your patch series and what are the big things that need doing
before it can be merged?  I can't promise a great deal of time up
front, but I would be glad to look at it and may be able to pitch in.

Because this patch is about --onto together with -p and doesn't really
involve -i, I think it still makes sense to merge.  It's only one line
plus tests, so I don't think it will create that much of a rebase burden.

Cheers,
Greg
