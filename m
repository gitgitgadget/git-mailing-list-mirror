From: Jeff King <peff@peff.net>
Subject: Re: get-upstream
Date: Thu, 23 Sep 2010 01:36:00 -0400
Message-ID: <20100923053600.GA27540@sigill.intra.peff.net>
References: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
 <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com>
 <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 07:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyeTd-0004Fb-Nq
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 07:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0IWFgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 01:36:07 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48268 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab0IWFgG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 01:36:06 -0400
Received: (qmail 31183 invoked by uid 111); 23 Sep 2010 05:36:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 23 Sep 2010 05:36:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Sep 2010 01:36:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156850>

On Wed, Sep 22, 2010 at 10:15:00PM -0600, Pat Notz wrote:

> On Wed, Sep 22, 2010 at 10:05 PM, Pat Notz <patnotz@gmail.com> wrote:
> > $ git rev-parse --symbolic-full-name @{upstream}
> 
> In all fairness, the @{upstream} syntax requires git >= 1.7.0

You can also use:

  git for-each-ref --format='%(upstream)' `git symbolic-ref HEAD`

which has worked since v1.6.3. It also has the advantage that you can
ask for the upstream of something besides the HEAD.

-Peff
