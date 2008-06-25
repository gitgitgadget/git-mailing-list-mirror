From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] factorize pack structure allocation
Date: Wed, 25 Jun 2008 10:19:20 +0300
Message-ID: <20080625071920.GA3307@mithlond.arda.local>
References: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBPIn-0006Mj-SM
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 09:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYFYHTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 03:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbYFYHTa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 03:19:30 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:58392 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752379AbYFYHT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 03:19:29 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F013B0391; Wed, 25 Jun 2008 10:19:25 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KBPHk-0001DT-4d; Wed, 25 Jun 2008 10:19:20 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241851420.2979@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86248>

Nicolas Pitre wrote (2008-06-24 18:58 -0400):

> New pack structures are currently allocated in 2 different places
> and all members have to be initialized explicitly.  This is prone
> to errors leading to segmentation faults as found by Teemu Likonen.
> 
> Let's have a common place where this structure is allocated, and have 
> all members implicitly initialized to zero.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>

Because of time zone issues I didn't get a chance to check this until
now. This fixes the segfault issue for me. Thanks!
