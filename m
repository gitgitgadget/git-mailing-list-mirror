From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] update_unicode.sh: Make the output structure visible
Date: Fri, 19 Dec 2014 10:48:11 -0500
Message-ID: <20141219154810.GB16967@peff.net>
References: <1418999971-21548-1-git-send-email-dev+git@drbeat.li>
 <1418999971-21548-4-git-send-email-dev+git@drbeat.li>
 <20141219152211.GA16967@peff.net>
 <549447B7.8070602@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: dev+git@drbeat.li, git@vger.kernel.org, tboegi@web.de
To: Beat Bolli <bbolli@ewanet.ch>
X-From: git-owner@vger.kernel.org Fri Dec 19 16:48:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1zmq-0004yX-W9
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 16:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbaLSPsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 10:48:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:55309 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751396AbaLSPsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 10:48:12 -0500
Received: (qmail 10571 invoked by uid 102); 19 Dec 2014 15:48:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Dec 2014 09:48:12 -0600
Received: (qmail 24674 invoked by uid 107); 19 Dec 2014 15:48:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Dec 2014 10:48:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Dec 2014 10:48:11 -0500
Content-Disposition: inline
In-Reply-To: <549447B7.8070602@ewanet.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261566>

On Fri, Dec 19, 2014 at 04:43:51PM +0100, Beat Bolli wrote:

> I think the code looks much nicer with a here doc.
> 
> Checking in t/, it looks that there's no consensus about whether to
> indent the content relative to the cat statement or not. What do you
> suggest?

I think we typically do it at the same level as the `cat`. Checking "git
grep -A1 '<<-'" does show a mix, but skimming over it I think what I
suggested is more common.

-Peff
