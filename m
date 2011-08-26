From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known extensions
Date: Fri, 26 Aug 2011 11:44:35 +0200
Message-ID: <201108261144.35888.trast@student.ethz.ch>
References: <20110825204047.GA9948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 11:44:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwsy2-0008N1-0O
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 11:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1HZJoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 05:44:44 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:46619 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab1HZJol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 05:44:41 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 26 Aug
 2011 11:44:32 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 26 Aug
 2011 11:44:36 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20110825204047.GA9948@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180160>

Jeff King wrote:
> We already provide sane hunk-header patterns for specific
> languages. However, the user has to manually map common
> extensions to use them. It's not that hard to do, but it's
> an extra step that the user might not even know is an
> option. Let's be nice and do it automatically.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I tried to think of negative side effects.
> 
> The userdiff drivers we have are pretty conservative; they just specify
> hunk headers.

And word-diff regexes.

In my book this is a plus for your patch, but I'm just saying.  It
will trigger the slightly slower mode of word-diffing that splits at
far more places than the default.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
