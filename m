From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: The merge from hell...
Date: Thu, 2 Feb 2006 22:16:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602022210540.3462@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE838@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 07:16:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4uFd-0008TZ-0z
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 07:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWBCGQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 01:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBCGQ0
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 01:16:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751196AbWBCGQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 01:16:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k136GADZ028477
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 22:16:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k136G5Tf028187;
	Thu, 2 Feb 2006 22:16:07 -0800
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE838@hdsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15529>



On Fri, 3 Feb 2006, Brown, Len wrote:
>
> In the back of my head I was worried about using plain
> numbers when I saw somebody refer to "shorthand SHA1".
> Hopefully this is an idle worry and it is not possible
> for the tool to confuse a numeric branch name with a SHA1 id.

It _is_ possible, but the rule is that references will be resolved first. 

If you mis-type a reference and it could be construed as a short hex SHA1 
ID (it needs to have more than 5 characters in it to trigger, though), the 
auto-completion of SHA1 ID's could bite you, though.

It's pretty unlikely, of course. But it's one reason to try to avoid using 
ref names that are numeric.

		Linus
