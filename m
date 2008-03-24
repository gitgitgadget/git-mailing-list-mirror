From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Introduce core.initHook
Date: Mon, 24 Mar 2008 15:40:01 -0700
Message-ID: <7vhcevu4ou.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site>
 <alpine.OSX.1.00.0803230943500.7541@cougar>
 <alpine.LSU.1.00.0803231200010.4353@racer.site>
 <alpine.OSX.1.00.0803231326290.11994@cougar>
 <alpine.LSU.1.00.0803231404390.4353@racer.site>
 <alpine.OSX.1.00.0803231428220.13789@cougar>
 <20080323235610.GB25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803240101220.4353@racer.site>
 <20080324002302.GD25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241155300.4353@racer.site>
 <20080324122153.GF25381@dpotapov.dyndns.org>
 <alpine.LSU.1.00.0803241611200.4353@racer.site>
 <7vr6dzuaxf.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803242232410.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvLj-00086G-0T
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYCXWkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbYCXWkU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:40:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbYCXWkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 18:40:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF21922D8;
	Mon, 24 Mar 2008 18:40:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EFA2122C9; Mon, 24 Mar 2008 18:40:09 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803242232410.4353@racer.site> (Johannes
 Schindelin's message of "Mon, 24 Mar 2008 22:40:07 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78113>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	> > +	if (run_init_hook())
> 	> > +		return 1;
> 	> > +
> 	> 
> 	> Hmm.  Exit without a message even under !quiet?
>
> 	Even under quiet, run_init_hook() will complain if the hook is 
> 	invalid.

Sorry, I may have been unclear but I was wondering more about the case the
hook script errored out silently.
