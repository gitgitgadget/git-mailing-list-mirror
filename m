From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Tue, 03 Jul 2007 09:24:59 +0200
Organization: eudaptics software gmbh
Message-ID: <4689F9CB.ED2A2848@eudaptics.com>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site> <20070702145549.GB4720@thunk.org> <Pine.LNX.4.64.0707021654450.4071@racer.site> <20070702160810.GD4720@thunk.org> <7vr6nqwgdi.fsf@assigned-by-dhcp.cox.net> <20070703011429.GB5322@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 09:24:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ckc-0007Ps-6z
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 09:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbXGCHYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 03:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759438AbXGCHYh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 03:24:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40945 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759420AbXGCHYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 03:24:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I5ckR-0004Aa-OD; Tue, 03 Jul 2007 09:24:31 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0996C55DD; Tue,  3 Jul 2007 09:24:31 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.9 (+)
X-Spam-Report: AWL=-1.752, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51465>

Theodore Tso wrote:
> 
> On Mon, Jul 02, 2007 at 04:11:21PM -0700, Junio C Hamano wrote:
> > > Such a point exists, I agree, but I would draw after $* and $1/$2/$3
> > > interpolation.  There is a lot more value that gets added with
> > > positional arguments support, and it makes git aliases more usable on
> > > platforms such as Windows where scripting capability is much more
> > > limited.
> >
> > That actually sounds sensible, but you could alias
> >
> >       !sh -c 'command $2 $1 $3'
> >
> > to reorder the parameters, couldn't you?
> 
> Um, how would that work on the Windows platform?

Shouldn't be a problem for Cygwin users, nor for MinGW port users. The
latter need a Bourne shell anyway for the various scripted git tools.

-- Hannes
