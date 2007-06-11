From: David Kastrup <dak@gnu.org>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Mon, 11 Jun 2007 11:26:49 +0200
Message-ID: <86odjmg7ty.fsf@lola.quinscape.zz>
References: <20070611090451.26209.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 11:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxgBX-0006YX-Gn
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 11:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbXFKJ12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 05:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbXFKJ12
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 05:27:28 -0400
Received: from main.gmane.org ([80.91.229.2]:39042 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXFKJ11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 05:27:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HxgB3-00063A-0c
	for git@vger.kernel.org; Mon, 11 Jun 2007 11:27:09 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 11:27:09 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 11:27:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:fSxQChX3pRtB5knecUCydfrP604=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49838>

linux@horizon.com writes:

> It seems to be common knowledge that git is a heck of a lot faster than
> CVS at most operations, but I'd like to do a little evangelizing and
> I can't seem to find a benchmark to support that claim.
>
> Am I just blind?
>
> I could find a code base and measure myself, but perhaps someone who's
> been hacking on CVS converters already has a reasonable code base
> in both forms that could be used for testing?

CVS and git do completely different things (which is one of the main
points of git).  git tends to do its own things pretty fast, CVS tends
to its things more leasurely and with higher network impact.
Benchmarking is not really useful since both systems do different
things.


-- 
David Kastrup
