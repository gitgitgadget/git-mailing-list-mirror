From: Matt Draisey <matt@draisey.ca>
Subject: Re: Detached checkout will clobber branch head when using symlink
	HEAD
Date: Thu, 16 Oct 2008 16:11:03 -0400
Message-ID: <1224187863.2796.15.camel@localhost>
References: <1224095087.5366.19.camel@localhost>
	 <20081016191751.GB14707@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZCx-0002yv-Pn
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbYJPULU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYJPULT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:11:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:13505 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYJPULT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:11:19 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1833140ugf.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:11:15 -0700 (PDT)
Received: by 10.67.116.18 with SMTP id t18mr6898387ugm.58.1224187875712;
        Thu, 16 Oct 2008 13:11:15 -0700 (PDT)
Received: from ?192.168.0.100? (bas2-windsor12-1088703253.dsl.bell.ca [64.228.75.21])
        by mx.google.com with ESMTPS id m38sm1774783ugd.34.2008.10.16.13.11.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:11:14 -0700 (PDT)
In-Reply-To: <20081016191751.GB14707@coredump.intra.peff.net>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98408>

On Thu, 2008-10-16 at 15:17 -0400, Jeff King wrote:

> Hmm. I don't think we have shipped with a symlink HEAD for quite a long
> time. Using one obviously doesn't work with detached HEAD, but also
> would fail with packed refs. I don't know if we ever deprecated it.

I am using the following system defaults:

core.prefersymlinkrefs=true
gc.packrefs=false

so almost all my git repositories are still using a symlink HEAD.
I have some old scripts That I use occasionally and still depend on it.
Using detached checkout is the only problem I've had.
