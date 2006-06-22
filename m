From: Jeff King <peff@peff.net>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 09:25:00 -0400
Message-ID: <20060622132500.GA7954@coredump.intra.peff.net>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org> <20060622131129.GB5134@spinlock.ch> <6F96D77C-FE27-4B74-ADBF-9964B5FD72DF@kernel.crashing.org> <20060622131730.GB7168@coredump.intra.peff.net> <6C519A4B-9253-49BB-BF68-DCD557DACCB7@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:25:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtPBF-0006jl-Ik
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWFVNZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWFVNZE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:25:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:37811 "HELO
	peff.net") by vger.kernel.org with SMTP id S1161110AbWFVNZC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:25:02 -0400
Received: (qmail 22589 invoked from network); 22 Jun 2006 09:24:41 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Jun 2006 09:24:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2006 09:25:00 -0400
To: Kumar Gala <galak@kernel.crashing.org>
Mail-Followup-To: Kumar Gala <galak@kernel.crashing.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <6C519A4B-9253-49BB-BF68-DCD557DACCB7@kernel.crashing.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22337>

On Thu, Jun 22, 2006 at 08:20:51AM -0500, Kumar Gala wrote:

> Ahh, I see.  I can than just copy the 'origin' ref over 'master'.

You can, though I'm not sure you even need to. If you're simply wanting
to mirror a git branch without checking out, then you're already done.
The mirror is just in 'origin', not 'master'.

-Peff
