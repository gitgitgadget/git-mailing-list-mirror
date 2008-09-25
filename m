From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git-submodule: remove unnecessary exits when calling resolve_relative_url
Date: Thu, 25 Sep 2008 16:58:46 +0200
Message-ID: <200809251658.46642.johan@herland.net>
References: <200809221808.31730.johan@herland.net> <48DB81DE.6070600@viscovery.net> <20080925145407.GM3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	mlevedahl@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:01:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KisLU-0000xc-DA
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 17:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYIYO7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbYIYO7O
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:59:14 -0400
Received: from sam.opera.com ([213.236.208.81]:53381 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbYIYO7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:59:14 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8PEwkKF005318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Sep 2008 14:58:47 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20080925145407.GM3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96775>

On Thursday 25 September 2008, Shawn O. Pearce wrote:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
> > Did you test it? The command inside $(...) is run in its own
> > sub-process, therefore, the die() does not exit the caller, just
> > the sub-process, and the || exit *is* required.
> >
> > BTW, I think that || exit is sufficient; you don't need to add
> > another error message - the one that resolve_relative_url() prints
> > is sufficient.
>
> Exactly.
>
> I think we just need a "|| exit" after each of these
> $(resolve_relative_url) calls.  The original patch that
> started this discussion just needs a "|| exit".

The original patch did exactly that: 
http://article.gmane.org/gmane.comp.version-control.git/96493


Have fun!

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
