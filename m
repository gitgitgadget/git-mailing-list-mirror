From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Mon, 7 Jul 2008 15:41:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071540310.18205@racer>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness> <20080707140841.GB6726@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jul 07 16:44:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrxF-0006FT-8A
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 16:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbYGGOnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 10:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbYGGOnj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 10:43:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:58900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755363AbYGGOng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 10:43:36 -0400
Received: (qmail invoked by alias); 07 Jul 2008 14:43:35 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp067) with SMTP; 07 Jul 2008 16:43:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1962OF6ot16gDdLlTkZ07IS4VYw1uHMEyHDkIbcC1
	4fRJ+dmGIAwLVE
X-X-Sender: gene099@racer
In-Reply-To: <20080707140841.GB6726@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87617>

Hi,

On Mon, 7 Jul 2008, Stephan Beyer wrote:

> > > This option realizes a stupid hack that tries to run the test cases 
> > > line by line (separated by &&).
> > 
> > In what way is that better than "sh -x t????-*.sh"?
> 
> Your suggestion is more like "./t????-*.sh -v" instead of -s, at least
> on bash and dash here.

No, I meant without "-v".

> But I didn't know the -x flag and it seems that this could be used in 
> test-lib.sh to make the hack faster, more robust and less hacky ;-)

It would obsolete your hack, I suggest.  Obviously, you haven't tried it 
yet.

Hth,
Dscho
