From: Paul Mackerras <paulus@samba.org>
Subject: Re: --ignore-invalid flag to git log et al.?
Date: Wed, 11 Jul 2007 19:07:32 +1000
Message-ID: <18068.40404.772354.34192@cargo.ozlabs.ibm.com>
References: <18068.34542.502048.222112@cargo.ozlabs.ibm.com>
	<81b0412b0707110046n5ec27328pab0ff33c183f79e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 11:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8YAi-00020h-D3
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 11:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbXGKJHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 05:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbXGKJHk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 05:07:40 -0400
Received: from ozlabs.org ([203.10.76.45]:56777 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768AbXGKJHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 05:07:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AA346DDE2C; Wed, 11 Jul 2007 19:07:38 +1000 (EST)
In-Reply-To: <81b0412b0707110046n5ec27328pab0ff33c183f79e@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52146>

Alex Riesen writes:

> git rev-parse --revs-only ref1 ref2 ref3 ...?

That stops when it sees an invalid ref and doesn't check the rest.
Also if you give it a string of 40 hex digits it will print it out
whether it's a valid object ID or not.

Paul.
