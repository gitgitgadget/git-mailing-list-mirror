From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/9] New option --ignore-whitespace for git-apply.
Date: Sun, 28 Aug 2005 09:58:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508280956320.3317@g5.osdl.org>
References: <1125242692932-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 18:59:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9QUB-0004Xp-PA
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 18:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVH1Q6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 12:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVH1Q6U
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 12:58:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750735AbVH1Q6T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 12:58:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7SGwGjA011862
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Aug 2005 09:58:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7SGwF0I021736;
	Sun, 28 Aug 2005 09:58:16 -0700
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <1125242692932-git-send-email-robfitz@273k.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7879>



On Sun, 28 Aug 2005, Robert Fitzsimons wrote:
>
> Allow the user to force a patch to be applied even though there might
> be whitespace differences.  Added a test case for the new option.

If you ignore whitespace, then you should probably accept patches that are
whitespace corrupted in another way: lines missing the ' ' at the
beginning. Especially lines that are empty. That's actually the most 
common form of whitespace corruption there is.

		Linus
