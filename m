From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 16:43:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
References: <20060524131022.GA11449@linux-mips.org> <Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605240947580.5623@g5.osdl.org> <7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 25 01:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj30q-0006fK-Di
	for gcvg-git@gmane.org; Thu, 25 May 2006 01:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWEXXna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 19:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWEXXna
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 19:43:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932080AbWEXXn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 19:43:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4ONh8tH014176
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 May 2006 16:43:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4ONh3jk004337;
	Wed, 24 May 2006 16:43:05 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20712>



On Wed, 24 May 2006, Linus Torvalds wrote:
> 
> IOW, I think there's something more fundamentally wrong with the tag 
> following. We _should_ have figured out much more quickly that we have it 
> all.

Actually, maybe the problem is that Ralf's tree has two roots, because of 
the old CVS history. It might be following the other root down for the 
"have" part, since that one doesn't exist at all in the target and the 
other side will never acknowledge any of it. 

I'll play with it.

		Linus
