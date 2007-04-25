From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 08:22:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704250805440.9964@woody.linux-foundation.org>
References: <1177482982542-git-send-email-junkio@cox.net>
 <alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 17:22:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgjK9-0006p5-7I
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 17:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031053AbXDYPW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031062AbXDYPW0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 11:22:26 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:49223 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031053AbXDYPWZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 11:22:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3PFMLop030745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 08:22:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3PFMKLU005584;
	Wed, 25 Apr 2007 08:22:21 -0700
In-Reply-To: <alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-5.031 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45535>



On Wed, 25 Apr 2007, Linus Torvalds wrote:
> 
> Ie, it would be better, I think, to use a
> 
> 	--date=local
> 	--date=relative
> 	--date=UTC
> 	...
> 
> kind of syntax, than have each date flag be different ("--relative-date" 
> vs "--local-zone"?).

Btw, when you do "--local-zone", you should drop the TZ printout too, I 
think. It doesn't seem to make any sense to give the *wrong* timezone.

			Linus
