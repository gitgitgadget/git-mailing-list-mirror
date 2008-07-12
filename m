From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 2/2] t/: Use "test_must_fail git" instead of "! git"
Date: Sat, 12 Jul 2008 23:43:59 +0200
Message-ID: <20080712214359.GA22323@leksak.fem-net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net> <1215877672-17049-2-git-send-email-s-beyer@gmx.net> <m3vdzbccoq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 23:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHmtt-0007wB-Hv
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 23:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbYGLVoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbYGLVoG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 17:44:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751582AbYGLVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 17:44:04 -0400
Received: (qmail invoked by alias); 12 Jul 2008 21:44:02 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp066) with SMTP; 12 Jul 2008 23:44:02 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19ozIolabtoPIA805S3NY0UbJPTxBoh96W59Vd62U
	Mnz+KlxKVCzBfa
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHmsp-0005oV-A6; Sat, 12 Jul 2008 23:43:59 +0200
Content-Disposition: inline
In-Reply-To: <m3vdzbccoq.fsf@localhost.localdomain>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88267>

Hi,

Jakub Narebski wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> 
> > This patch changes every occurrence of "! git" -- with the meaning
> > that a git call has to fail -- into "test_must_fail git".
> > 
> > This is useful to
> 
> >  - advertise the use of "test_must_fail" for new tests.
> 
> Hmmm... I think advertising the use of 'test_must_fail' would be
> the best served by adding information about this function to
> t/README

This is true.
This is not only true for test_must_fail, it is also true for
stuff like test_tick, test_set_editor, test_cmp and the like.

But, well, t/README says also, that "existing programs are the best
source of the information."
And I think it is right ;-)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
