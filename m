From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 20:44:50 -0400
Message-ID: <48B5F502.1090900@pobox.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <7v63pmkozh.fsf@gitster.siamese.dyndns.org> <94a0d4530808271709s4e96c5a7ie6152b2937f2234b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew Wilcox <matthew@wil.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVeu-00010r-7E
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246AbYH1Api (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbYH1Api
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:45:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:34112 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbYH1Aph (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:45:37 -0400
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KYVd4-0007jc-Tm; Thu, 28 Aug 2008 00:44:53 +0000
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <94a0d4530808271709s4e96c5a7ie6152b2937f2234b@mail.gmail.com>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94004>

Felipe Contreras wrote:
> Still, if this is the decision, all the documentation should be
> updated, and people should be discouraged to mention the git-foo
> commands ever again, otherwise new users would get confused.


True.

I scanned my Kernel Hackers' Guide to Git and made sure to kill a few 
straggling references to dash commands:

	http://linux.yyz.us/git-howto.html

Even though my fingers still want to type git DASH foo, feedback from 
gitsters caused me to purge most dash references from the guide a while 
ago.  I'm surprised the git docs were not updated at the same time I was 
being hectored <grin>

Anyway, it's a fair point and lets definite get the straggling docs 
converted and consistent.

Comments on the above URL welcome, even if unrelated to the current 
topic at hand.

Thanks,

	Jeff
