From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Mon, 8 Nov 2010 20:40:40 +0100
Message-ID: <1jrnlcv.1hnnh8x1sh3ydiM%lists@haller-berlin.de>
References: <20101108172421.GB3619@burratino>
Cc: paulus@samba.org (Paul Mackerras), git@vger.kernel.org
To: jrnieder@gmail.com (Jonathan Nieder)
X-From: git-owner@vger.kernel.org Mon Nov 08 20:40:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXaB-00021K-KO
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0KHTkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:40:42 -0500
Received: from mail.ableton.net ([62.96.12.115]:38658 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab0KHTkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=28kDVMmFNE/1u0vZ5jMVlQbQk6hOGMNi1H2QouosytY=;
	b=ncaokXbWZG51FJt9XbUMiyCrIJr/kipeG90CZbwgeN39Xr0TIyjKP776vmXpnCameUrnWmM6d7cvI+KYcQ1gC7nPG1ZtB53/0sBtrjx1OMGqzwcBjzqzJoaCA6rbtey3wO527Ebt4j4Pb5RVklUZGvz9IF63fSD77fvqjsySScQ=;
Received: from dslb-088-074-010-205.pools.arcor-ip.net ([88.74.10.205] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PFXa4-0005qU-DP; Mon, 08 Nov 2010 20:40:40 +0100
In-Reply-To: <20101108172421.GB3619@burratino>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160975>

Jonathan Nieder <jrnieder@gmail.com> wrote:

> Stefan Haller wrote:
> 
> > Sometimes it's desirable to see what changes were introduced by a
> > merge commit, rather than how conflicts were resolved. This adds
> > a checkbox which, when turned on, makes gitk show the equivalent
> > of "git show --first-parent <commit>" for merge commits.
> 
> To be clear: this is a diff option (like -m but limited to one
> parent), not a history traversal option, right?

Yes, that's right.  There is an existing history traversal option called
"Limit to first parent" in the "Edit View" dialog, which can be
controlled with the --first-parent command line option.  Do you think
this will cause confusion?

> > I realize this conflicts with Thomas Rast's recent patch to
> > add a word-diff dropdown box; things are fighting for space
> > in the diff pane header...
> 
> Any ideas for addressing the space shortage?

Matthieu made the suggestion of "line-wrapping" the widgets in the diff
pane header if it becomes too narrow.  I guess this could work; I don't
know enough Tcl/Tk to be able to try it out though.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
