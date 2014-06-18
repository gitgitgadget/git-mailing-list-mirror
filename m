From: Jeff King <peff@peff.net>
Subject: Re: Why does gpg.program work for commit but not log?
Date: Wed, 18 Jun 2014 08:51:16 -0400
Message-ID: <20140618125116.GA7753@sigill.intra.peff.net>
References: <ABACA8639E2A49BA8A1E602DBE815867@black>
 <20140618073645.GA24769@sigill.intra.peff.net>
 <9B9CF0F915BD4325BC92BBA1339B1B4E@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Wed Jun 18 14:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxFKn-0006Md-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 14:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966280AbaFRMvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 08:51:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:46715 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966138AbaFRMvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 08:51:20 -0400
Received: (qmail 7140 invoked by uid 102); 18 Jun 2014 12:51:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 07:51:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 08:51:16 -0400
Content-Disposition: inline
In-Reply-To: <9B9CF0F915BD4325BC92BBA1339B1B4E@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251984>

On Wed, Jun 18, 2014 at 08:38:32AM -0400, Jason Pyeron wrote:

> > That's rather old. In the meantime we have:
> > 
> > 	commit 6005dbb9bf21d10b209f7924e305bd04b9ab56d2
> [...]
> 
> I will (try to) compile master and test. This is the latest version in cygwin.

To save you some trouble, I actually found that commit by reproducing
your problem on Linux and bisecting. So I'm fairly sure it will fix it
for you. :)

You may want to bug the cygwin packagers about updating their version of
git. v1.7.9 is two and a half years old, and since then we have many
bugfixes, including some which are specifically targeted at cygwin
(which can only lead me to assume a lot of people are building from
source on cygwin).

-Peff
