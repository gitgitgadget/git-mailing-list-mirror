From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New features in gitk
Date: Thu, 1 Nov 2007 08:16:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 16:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InbnC-0002BB-Ux
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 16:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbXKAPQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 11:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbXKAPQ4
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 11:16:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51757 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753717AbXKAPQz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 11:16:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1FGPLG004429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Nov 2007 08:16:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1FGPxa002233;
	Thu, 1 Nov 2007 08:16:25 -0700
In-Reply-To: <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-2.732 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62973>



On Thu, 1 Nov 2007, Paul Mackerras wrote:
> 
> The other thing --topo-order does is reorder the commits so that
> related commits come together.

If that's the only reason for using it, then please stop, and use 
"--first-parent" instead.

		Linus
