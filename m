From: Mike Hommey <mh@glandium.org>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 22:31:30 +0200
Message-ID: <20090725203130.GB1640@glandium.org>
References: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
 <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
 <20090724234648.GA4616@Pilar.aei.mpg.de>
 <20090725004122.GA28477@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
 <20090725215739.d074e947.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 22:33:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUnw1-00029o-4I
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 22:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZGYUba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 16:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZGYUba
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 16:31:30 -0400
Received: from vuizook.err.no ([85.19.221.46]:48755 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbZGYUba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 16:31:30 -0400
Received: from [194.224.98.149] (helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1MUnto-0002B1-1L; Sat, 25 Jul 2009 22:31:23 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1MUnu3-0000R5-QD; Sat, 25 Jul 2009 22:31:35 +0200
Content-Disposition: inline
In-Reply-To: <20090725215739.d074e947.tihirvon@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124066>

On Sat, Jul 25, 2009 at 09:57:39PM +0300, Timo Hirvonen wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So curl really must die. It may not matter for the expensive operations, 
> > but a lot of scripting is about running all those "cheap" things that just 
> > add up over time.
> 
> SELinux is the problem, not curl.

I think it's NSS, the problem, not SELinux. Linus's libcurl is built
against NSS, which is the default on Fedora.

Mike
