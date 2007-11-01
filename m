From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Don't use cpio in git-clone when not installed
Date: Thu, 1 Nov 2007 07:31:31 +0100
Organization: glandium.org
Message-ID: <20071101063131.GA22401@glandium.org>
References: <1193861145-20357-1-git-send-email-mh@glandium.org> <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 07:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InTcY-0002XO-KJ
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 07:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbXKAGcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbXKAGcy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 02:32:54 -0400
Received: from vawad.err.no ([85.19.200.177]:48533 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbXKAGcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 02:32:53 -0400
Received: from aputeaux-153-1-44-162.w82-124.abo.wanadoo.fr ([82.124.8.162] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InTba-00084U-8V; Thu, 01 Nov 2007 07:32:40 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1InTaV-0005uZ-M7; Thu, 01 Nov 2007 07:31:31 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710311742170.3342@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62921>

On Wed, Oct 31, 2007 at 05:46:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 31 Oct 2007, Mike Hommey wrote:
> > +	if type cpio > /dev/null 2>&1; then
> > +		local=yes
> > +	fi
> 
> Isn't "type" a bashism?

I think it's POSIX, and since I found the same construct in
git-mergetool.sh, I thought it would be okay for git.

Mike
