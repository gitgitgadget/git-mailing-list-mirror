From: Paul Mackerras <paulus@samba.org>
Subject: Re: Mark Levedahl's gitk patches
Date: Thu, 28 Jun 2007 10:15:21 +1000
Message-ID: <18050.64921.235580.37028@cargo.ozlabs.ibm.com>
References: <467FE7C4.5E421535@eudaptics.com>
	<46807CEF.2010109@verizon.net>
	<18048.36797.283166.952377@cargo.ozlabs.ibm.com>
	<7v645axm7r.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mdl123@verizon.net>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 02:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3hfh-0007a6-Sx
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 02:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbXF1APb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 20:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbXF1APb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 20:15:31 -0400
Received: from ozlabs.org ([203.10.76.45]:51731 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbXF1APb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 20:15:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0838FDDF74; Thu, 28 Jun 2007 10:15:30 +1000 (EST)
In-Reply-To: <7v645axm7r.fsf@assigned-by-dhcp.pobox.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51068>

Junio C Hamano writes:

> I took a look at differences between your gitk.git and what I
> have.  It appears that our "proc readrefs" differ a bit.
> 
> Most notably, the global hash tagcontents is read when readrefs
> run in the version I have, while gitk.git version fills it
> lazily in showtag, where it is actually used.  Because you read
> the refs using "show-ref -d", you do not need to do extra forks
> to figure out the objects referred to by the tags in your code.

Yes, that was one of the many improvements I made.  Basically I pulled
a lot of stuff over from the 'new' branch.

> I think what you have is a lot better from interactive latency
> point of view.  I'll take the version from gitk.git and push the
> results out.

Thanks.  I have now pushed out Mark Levedahl's two bug fixes as well.

Paul.
