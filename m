From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: gitk: 'j' and 'k' keyboard shortcuts backward
Date: Mon, 19 Sep 2011 10:11:56 -0700
Message-ID: <20110919171156.GA1705@leaf>
References: <CA+Jd1rFzOOxL+-JVeovTiOwM5cmyyis65Y1+xiDmG=tkJ3b2Xw@mail.gmail.com>
 <20110919164950.GB2861@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Robert Suetterlin <robert@mpe.mpg.de>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 19:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5hVb-0007ZO-VN
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 19:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637Ab1ISRTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 13:19:50 -0400
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:37195 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1ISRTt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 13:19:49 -0400
X-WhiteListed: mail was accepted with no delay
X-WhiteListed: mail was accepted with no delay
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id D694D4FFBC
	for <git@vger.kernel.org>; Mon, 19 Sep 2011 19:12:07 +0200 (CEST)
X-Originating-IP: 217.70.178.130
Received: from mfilter1-d.gandi.net (mfilter1-d.gandi.net [217.70.178.130])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 314A3172084;
	Mon, 19 Sep 2011 19:12:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter1-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter1-d.gandi.net (mfilter1-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id zU+sJVZZH-sV; Mon, 19 Sep 2011 19:12:03 +0200 (CEST)
X-Originating-IP: 209.63.10.138
Received: from leaf (unknown [209.63.10.138])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2539317208B;
	Mon, 19 Sep 2011 19:11:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110919164950.GB2861@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181685>

On Mon, Sep 19, 2011 at 11:49:50AM -0500, Jonathan Nieder wrote:
> How about this patch?
> 
> -- >8 --
> Subject: gitk: Make vi-style keybindings more vi-like
> 
> When commit 6e2dda35 (Add new keybindings, 2005-09-22) added vi-style
> keybindings to gitk (an excellent idea!), instead of adopting the
> usual "hjkl = left, down, up, right" bindings used by less, vi, rogue,
> and many other programs, it used "ijkl = up, left, down, right" to
> mimic the inverted-T formation of the arrow keys on a qwerty keyboard,
> in the style of Lode runner.  So using 'j' and 'k' to scroll through
> commits produces utterly confusing results to the vi user, as 'k'
> moves down and 'j' moves to the previous commit.
> 
> Luckily most non-vi-users are probably using an alternate set of keys
> (cursor keys or z/x + n/p) anyway.  Switch to the expected vi/nethack
> convention.
> 
> Requested-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This looks perfect to me.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Thanks!

- Josh Triplett
