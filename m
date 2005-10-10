From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Strangely broken git repo
Date: Mon, 10 Oct 2005 11:23:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510101123100.14597@g5.osdl.org>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com> 
 <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com> 
 <4349ED5D.6020703@catalyst.net.nz>  <7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.64.0510100742070.14597@g5.osdl.org>  <Pine.LNX.4.64.0510100800580.14597@g5.osdl.org>
 <118833cc0510101119n4e7e9399x705993b4608d63b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 20:27:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2Jw-0005bx-QH
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 20:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVJJSYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 14:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVJJSYR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 14:24:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbVJJSYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 14:24:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9AIO04s028689
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 11:24:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9AINxLb029300;
	Mon, 10 Oct 2005 11:23:59 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0510101119n4e7e9399x705993b4608d63b6@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9905>



On Mon, 10 Oct 2005, Morten Welinder wrote:
>
> Spaces in URLs are off-spec.  (And common, go figure.)

They may be off-spec in url's, but that doesn't mean that "curl" should 
just ignore them. It should either escape them, or refuse them. Using 
user-supplied data without any checks is usually a really bad idea.

			Linus
