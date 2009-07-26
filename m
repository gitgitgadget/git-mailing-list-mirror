From: Mike Hommey <mh@glandium.org>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 09:54:55 +0200
Message-ID: <20090726075455.GA22525@glandium.org>
References: <20090723195548.GA28494@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
 <20090724234648.GA4616@Pilar.aei.mpg.de>
 <20090725004122.GA28477@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
 <20090725215739.d074e947.tihirvon@gmail.com>
 <20090725203130.GB1640@glandium.org>
 <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 09:55:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUya3-0004tx-Pj
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 09:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbZGZHzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 03:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZGZHzB
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 03:55:01 -0400
Received: from vuizook.err.no ([85.19.221.46]:57080 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbZGZHzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 03:55:00 -0400
Received: from [194.224.98.149] (helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1MUyZI-00072E-CN; Sun, 26 Jul 2009 09:54:55 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1MUyZL-0007gh-Ed; Sun, 26 Jul 2009 09:54:55 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124106>

On Sat, Jul 25, 2009 at 02:02:19PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 25 Jul 2009, Mike Hommey wrote:
> 
> > On Sat, Jul 25, 2009 at 09:57:39PM +0300, Timo Hirvonen wrote:
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > 
> > > > So curl really must die. It may not matter for the expensive operations, 
> > > > but a lot of scripting is about running all those "cheap" things that just 
> > > > add up over time.
> > > 
> > > SELinux is the problem, not curl.
> > 
> > I think it's NSS, the problem, not SELinux. Linus's libcurl is built
> > against NSS, which is the default on Fedora.
> 
> Well, it kind of doesn't matter. The fact is, libcurl is a bloated 
> monster, and adds zero to 99% of what git people do.

Especially consideting the http transport fails to be useful in various
scenarios.

Mike
