From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 15 Feb 2008 10:43:20 +0100
Message-ID: <200802151043.21508.kendy@suse.cz>
References: <200802081828.43849.kendy@suse.cz> <alpine.LSU.1.00.0802142054080.30505@racer.site> <200802142300.01615.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 10:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPx6s-0004oq-IS
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 10:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbYBOJnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 04:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756598AbYBOJnY
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 04:43:24 -0500
Received: from styx.suse.cz ([82.119.242.94]:49611 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754996AbYBOJnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 04:43:23 -0500
Received: from one.suse.cz (one.suse.cz [10.20.1.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.suse.cz (Postfix) with ESMTP id 67096628096;
	Fri, 15 Feb 2008 10:43:15 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <200802142300.01615.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73949>

Hi Jakub,

On Thursday 14 of February 2008, Jakub Narebski wrote:

> >> What is the size of checkout, by the way?
> >
> > 2.4G
>
> That's huuuuge tree. Compared to that 1.6G (or 1.4G) packfile doesn't
> look large.
>
> I wonder if proper subdivision into submodules (which should encourage
> better code by the way, see TAOUP), and perhaps partial checkouts
> wouldn't be better solution than lazy clone. But it is nice to have
> long discussed about feature, even if at RFC stage, but with some code.

Yes, I'd love to see the OOo tree split into several parts, I've already 
proposed a division (http://www.nabble.com/OOo-source-split-td13096065.html), 
but it'll take some more time I'm afraid :-(

Regards,
Jan
