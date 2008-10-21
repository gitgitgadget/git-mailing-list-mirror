From: Paul Mackerras <paulus@samba.org>
Subject: Re: git command to read
Date: Tue, 21 Oct 2008 22:45:28 +1100
Message-ID: <18685.49368.557513.727997@cargo.ozlabs.ibm.com>
References: <18685.47909.354146.487700@cargo.ozlabs.ibm.com>
	<20081021112521.GC17363@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:46:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFhM-0005GU-48
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYJULpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYJULpi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:45:38 -0400
Received: from ozlabs.org ([203.10.76.45]:35483 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbYJULph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:45:37 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 19919DDDE7; Tue, 21 Oct 2008 22:45:36 +1100 (EST)
In-Reply-To: <20081021112521.GC17363@coredump.intra.peff.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98781>

Jeff King writes:

> On Tue, Oct 21, 2008 at 10:21:09PM +1100, Paul Mackerras wrote:
> 
> > Is there a command in git at the moment that will read commit IDs on
> > standard input and print the contents of each commit on standard
> > output (without waiting for EOF on stdin)?
> 
> How about:
> 
>   git cat-file --batch
> 
> ?
> 
> Unfortunately it just dumps the raw commit information instead of
> allowing the usual formatting, but perhaps that is sufficient (you asked
> for "contents").

Ah, thank you, that looks like just what I want. :)

Paul.
