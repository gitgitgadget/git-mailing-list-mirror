From: Matt Draisey <matt@draisey.ca>
Subject: Re: Detached checkout will clobber branch head when using symlink
	HEAD
Date: Thu, 16 Oct 2008 16:28:59 -0400
Message-ID: <1224188939.2796.22.camel@localhost>
References: <1224095087.5366.19.camel@localhost>
	 <20081016191751.GB14707@coredump.intra.peff.net>
	 <1224187863.2796.15.camel@localhost>
	 <alpine.LFD.2.00.0810161619330.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZUG-00018d-Sq
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbYJPU3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYJPU3N
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:29:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:21223 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbYJPU3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:29:12 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1841144ugf.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:29:10 -0700 (PDT)
Received: by 10.67.21.11 with SMTP id y11mr6907280ugi.70.1224188950721;
        Thu, 16 Oct 2008 13:29:10 -0700 (PDT)
Received: from ?192.168.0.100? (bas2-windsor12-1177605554.dsl.bell.ca [70.48.213.178])
        by mx.google.com with ESMTPS id g30sm3435607ugd.57.2008.10.16.13.29.08
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Oct 2008 13:29:09 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810161619330.26244@xanadu.home>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98418>

On Thu, 2008-10-16 at 16:20 -0400, Nicolas Pitre wrote:
> A symlink HEAD and detached checkouts are simply incompatible.

Not necessarily.  The symlinking code will unlink the original inode
each time it creates a new symlink anyway.  It is simply a matter of
creating a new file in its place.
