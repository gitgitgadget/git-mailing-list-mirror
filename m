From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: 1.7.10 doesn't show file pushstatus
Date: Tue, 1 May 2012 11:32:30 +0200
Message-ID: <20120501093230.GA22633@ecki.lan>
References: <20120501010609.GA14715@jupiter.local>
 <20120501065832.GA17777@sigill.intra.peff.net>
 <20120501073326.GA21087@sigill.intra.peff.net>
 <20120501084048.GA21904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 11:32:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP9Ro-0004fR-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 11:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab2EAJcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 05:32:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:39964 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab2EAJcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 05:32:35 -0400
Received: from [127.0.0.1] (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id A887C130045;
	Tue,  1 May 2012 11:28:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120501084048.GA21904@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196674>

On Tue, May 01, 2012 at 04:40:49AM -0400, Jeff King wrote:
> 
> The following patch series fixes this:
> 
>   [1/3]: send-pack: show progress when isatty(2)
>   [2/3]: teach send-pack about --[no-]progress
>   [3/3]: t5541: test more combinations of --progress

Thanks. Looks good to me, although I completely missed this before. But
the tests should hopefully take care of any future regressions.
