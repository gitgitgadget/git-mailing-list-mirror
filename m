From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 08:03:15 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org>
References: <1177482982542-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 17:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgj2c-0007Xj-IP
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 17:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030965AbXDYPDv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 11:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbXDYPDv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 11:03:51 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:33791 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030971AbXDYPDu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 11:03:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3PF3G8a029522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Apr 2007 08:03:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3PF3FDe005165;
	Wed, 25 Apr 2007 08:03:15 -0700
In-Reply-To: <1177482982542-git-send-email-junkio@cox.net>
X-Spam-Status: No, hits=-5.031 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45534>



On Tue, 24 Apr 2007, Junio C Hamano wrote:
> 
>  * I got tired of looking at +0000 timestamps on commits
>    imported from CVS at day-job.  Does not seem to break
>    existing tests, but I am not sure if this is useful.

I think it's useful (read: I've occasionally wanted it), but I think we 
should make the date option syntax be more extensible.

Ie, it would be better, I think, to use a

	--date=local
	--date=relative
	--date=UTC
	...

kind of syntax, than have each date flag be different ("--relative-date" 
vs "--local-zone"?).

			Linus
