From: Paul Mackerras <paulus@samba.org>
Subject: Re: Bug in gitk search box
Date: Thu, 26 Jul 2007 14:46:47 +1000
Message-ID: <18088.10039.780711.708582@cargo.ozlabs.ibm.com>
References: <20070725135621.GC21692@lavos.net>
	<18087.60033.676105.538784@cargo.ozlabs.ibm.com>
	<7vtzrrc1sb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: bdowning@lavos.net (Brian Downing), git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDvTq-0000HZ-S1
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbXGZFBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXGZFBj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:01:39 -0400
Received: from ozlabs.org ([203.10.76.45]:47216 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbXGZFBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:01:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 11FF5DDEC1; Thu, 26 Jul 2007 15:01:37 +1000 (EST)
In-Reply-To: <7vtzrrc1sb.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53764>

Junio C Hamano writes:

> There was a recent message from Linus on the list, stating that
> NUL in -z format is inter-record separator, not after-record
> terminator.

OK, I'll have to change gitk then.  It looks like both Marco and I got
tricked by this.  I suggest it's worth a mention in the documentation.

Paul.
