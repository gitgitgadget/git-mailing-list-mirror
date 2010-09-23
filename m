From: Jeff King <peff@peff.net>
Subject: Re: get-upstream
Date: Thu, 23 Sep 2010 01:37:17 -0400
Message-ID: <20100923053717.GB27540@sigill.intra.peff.net>
References: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
 <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com>
 <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
 <AANLkTi=QnP0CUCU=6fR50UzphnVMVvmfe9mkqpf1NHLt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pat Notz <patnotz@gmail.com>, git@vger.kernel.org
To: Ramana Kumar <ramana.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 07:37:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyeUn-0004Y2-5v
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 07:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0IWFhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 01:37:19 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50477 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab0IWFhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 01:37:18 -0400
Received: (qmail 31238 invoked by uid 111); 23 Sep 2010 05:37:17 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 23 Sep 2010 05:37:17 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Sep 2010 01:37:17 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=QnP0CUCU=6fR50UzphnVMVvmfe9mkqpf1NHLt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156851>

On Thu, Sep 23, 2010 at 02:16:43PM +1000, Ramana Kumar wrote:

> Thanks Pat - that's awesome.
> Is there a git shortcut for removing the refs/remotes or refs/heads
> prefix? (I know I can just use other progs for that too)

If you use the for-each-ref solution, you can use the :short modifier,
like:

  git for-each-ref --format='%(upstream:short)' `git symbolic-ref HEAD`

-Peff
