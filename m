From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Sun, 6 Jul 2008 18:07:59 +0200
Message-ID: <20080706160758.GA23385@jhaampe.org>
References: <20080701150119.GE5852@joyeux> <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFXF4-0006iQ-Rv
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 18:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804AbYGFQgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 12:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbYGFQgg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 12:36:36 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47349 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbYGFQge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 12:36:34 -0400
Received: from jhaampe.org (p5B3CCD36.dip.t-dialin.net [91.60.205.54])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id C87B933175;
	Sun,  6 Jul 2008 18:08:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Sun Jul  6 18:08:03 2008 +0200 (CEST))
X-Spam-Flag: No, tests=bogofilter, spamicity=0.267199, queueID=AAE7833178
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87541>

> > Which one is the commit message ;-)?
> 
> I think it is clear that Sylvain has not read 
> Documentation/SubmittingPatches yet.

Sylvain *has* read SubmittingPatches but has not understood every detail of this
very long document.

If you could enlighten me on what is wrong ...

> > People who rely on working submodule support, do you have any feedback 
> > on this patch?
> 
> Not yet.  Will test/comment when the spurious "fetch" is fixed.
I thought that the only thing that 'fetch' does is update FETCH_HEAD. My problem
is that doing the fetch is the only way to know what is the status of the
submodule w.r.t. the registered commit. If you have a better way to get that
information, I'm all ears :P

--
Sylvain
