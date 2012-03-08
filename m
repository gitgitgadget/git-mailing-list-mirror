From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 20:03:10 +0100
Message-ID: <20120308190310.GA13486@inner.h.iocl.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com> <87k42vs8pi.fsf@thomas.inf.ethz.ch> <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com> <1331202483.21444.11.camel@beez.lab.cmartin.tk> <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com> <1331203321.21444.13.camel@beez.lab.cmartin.tk> <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com> <7vlinbdkb0.fsf@alter.siamese.dyndns.org> <vpq1up3aqk8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeremy Morton <jeremy@configit.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 08 20:35:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5j7a-0005YY-M3
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 20:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470Ab2CHTfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 14:35:20 -0500
Received: from continuum.iocl.org ([217.140.74.2]:40210 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758455Ab2CHTfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 14:35:18 -0500
X-Greylist: delayed 1885 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2012 14:35:17 EST
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id q28J3Ab13715;
	Thu, 8 Mar 2012 20:03:10 +0100
Content-Disposition: inline
In-Reply-To: <vpq1up3aqk8.fsf@bauges.imag.fr>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192637>

On Thu, 08 Mar 2012 19:35:51 +0000, Matthieu Moy wrote:
...
> If someone else did a push between my first push and the "push --force",
> then the other user's push is discarded.

A push --semiforce would help here: Should check whether the remote
branch is at the same commit as origin/master locally, and only then set
to new local master. (Would probably require protocol change to actuall
be atomic.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
