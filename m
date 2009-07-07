From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git+http:// proof-of-concept (not using CONNECT)
Date: Tue, 7 Jul 2009 13:50:03 -0700
Message-ID: <20090707205003.GA31195@dcvr.yhbt.net>
References: <20090702085440.GC11119@dcvr.yhbt.net> <85647ef50907020252u41e36187jaacacad3d8a10f75@mail.gmail.com> <20090703202839.GB12072@dcvr.yhbt.net> <alpine.LSU.2.00.0907071712580.30197@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Tue Jul 07 22:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHcB-0007il-U7
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554AbZGGUuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbZGGUuE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:50:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34353 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756008AbZGGUuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:50:04 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 6D6231F4EA;
	Tue,  7 Jul 2009 20:50:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0907071712580.30197@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122876>

Tony Finch <dot@dotat.at> wrote:
> On Fri, 3 Jul 2009, Eric Wong wrote:
> >
> > That and my approach requires both the client and server to be
> > simutaneously sending and receiving responses in full-duplex channel
> > which makes it impossible to work without chunking.  IOW, there's no
> > chance any HTTP proxy that dechunks or queues/coalesces chunked
> > requests/responses can work with my approach.
> 
> Many HTTP servers will not be able to support it either because HTTP is a
> half-duplex protocol (modulo request pipelining).

Heh, as far as I know Unicorn is the only one :)

-- 
Eric Wong
