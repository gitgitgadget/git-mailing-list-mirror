From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk - error in git repo on cygwin
Date: Thu, 5 Jul 2007 09:38:28 +1000
Message-ID: <18060.12148.313090.53861@cargo.ozlabs.ibm.com>
References: <468BA1B8.4010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 01:39:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ERD-0006UB-T7
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 01:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbXGDXjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 19:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755473AbXGDXjJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 19:39:09 -0400
Received: from ozlabs.org ([203.10.76.45]:55153 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434AbXGDXjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 19:39:08 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2E288DDF1D; Thu,  5 Jul 2007 09:39:06 +1000 (EST)
In-Reply-To: <468BA1B8.4010406@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51649>

Mark Levedahl writes:

> This doesn't happen on my Linux box, so this is most likely due to a tcl 
> feature introduced more recently than the tcl used in Cygwin (8.4.1). My 
> guess would be that the more recent tcl is more forgiving of an 
> attempted access to a non-existent element.

I don't think anything like that has changed.  I think it is probably
due to the commits being batched up differently in getcommitlines.
I'll look into it.

Paul.
