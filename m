From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Makefile: do not export mandir/htmldir/infodir
Date: Tue, 12 Feb 2013 23:20:41 +0000
Message-ID: <20130212232041.GA23861@river>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
 <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
 <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
 <20130212231651.GI12240@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5PAH-0007it-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964Ab3BLXVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:21:05 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:51642 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758954Ab3BLXVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:21:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 01B1BCDA5A5;
	Tue, 12 Feb 2013 23:21:00 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d34K+DeaCchF; Tue, 12 Feb 2013 23:20:58 +0000 (GMT)
Received: from river (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C9968CDA330;
	Tue, 12 Feb 2013 23:20:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130212231651.GI12240@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216222>

On Tue, Feb 12, 2013 at 03:16:51PM -0800, Jonathan Nieder wrote:
> Junio C Hamano wrote:
> 
> > These are defined in the main Makefile to be funny values that are
> > optionally relative to an unspecified location that is determined at
> > runtime.
> [...]
> > A longer term fix is to introduce runtime_{man,html,info}dir variables
> > to hold these funny values, and make {man,html,info}dir variables
> > to have real paths whose default values begin with $(prefix), but
> > as a first step, stop exporting them from the top-level Makefile.
> 
> Makes sense.
> 
> Reported-by: John Keeping <john@keeping.me.uk>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Fixes my original problem, so FWIW:

Tested-by: John Keeping <john@keeping.me.uk>
