From: Petter Urkedal <urkedal@nbi.dk>
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Mon, 5 Oct 2009 08:44:04 +0200
Message-ID: <20091005064404.GB25040@eideticdew.org>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
 <20091004141355.GA15783@eideticdew.org>
 <20091004182746.GA22995@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:52:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuhQl-00072o-3T
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZJEGos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 02:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbZJEGos
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:44:48 -0400
Received: from up.nbi.dk ([130.225.212.6]:53674 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869AbZJEGor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 02:44:47 -0400
Received: from bottom.nbi.dk (bottom.nbi.dk [130.225.212.9])
	by mail2.nbi.dk (Postfix) with ESMTP id BCC863C951;
	Mon,  5 Oct 2009 08:44:10 +0200 (CEST)
Received: by bottom.nbi.dk (Postfix, from userid 32342)
	id C13B23C005; Mon,  5 Oct 2009 08:44:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091004182746.GA22995@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129536>

On 2009-10-04, Jeff King wrote:
> t3202 is maybe a bit of weird place to put it, but we don't seem to test
> show-branch anywhere else. It could probably use a "check that
> show-branch works at all" set of tests, but I am not volunteering to
> write such a thing.

Looks good to me.  I'm not so familiar with the source code as I looked
at it first time when I submitted the patch.

> I have always found its output to be one step above
> line noise.

I agree show-branch is nosy, and the actual options I was adding was
"--topo-order master t/*" to show only topic branches.  After rebasing
them against master, show-branch with these arguments gives a nice
overview.  Thanks Junio's tip I now have

    alias.show-topics = show-branch --topo-order master t/*
