From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RESEND] [PATCH] fix gitk with lots of tags
Date: Fri, 21 Apr 2006 08:19:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604210817570.3701@g5.osdl.org>
References: <20060406203637.GA15009@blackbean.org> <20060418180614.GA31543@blackbean.org>
 <17480.50829.466038.316769@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Radford <radford@blackbean.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 17:20:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWxQg-0004ke-JC
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 17:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWDUPUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 11:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWDUPUM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 11:20:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbWDUPUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 11:20:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3LFJrtH003553
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Apr 2006 08:19:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3LFJq2H004694;
	Fri, 21 Apr 2006 08:19:52 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17480.50829.466038.316769@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19020>



On Fri, 21 Apr 2006, Paul Mackerras wrote:
> 
> Junio, did you tell me some time ago about a flag to git-rev-parse
> that spits out just the file/directory names?  What was it again?

	git-rev-parse --no-flags --no-revs "$@"

should fo what you want.

		Linus
