From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] merge-tree: remove unnecessary call of
 git_extract_argv0_path
Date: Fri, 22 Jan 2010 08:40:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220840120.13231@localhost.localdomain>
References: <4B596519.8060508@viscovery.net> <1264160879-26079-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMZo-0004jx-ME
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab0AVQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385Ab0AVQlh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:41:37 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49920 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371Ab0AVQlg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:41:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGeUep017979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:40:31 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGeTCm015777;
	Fri, 22 Jan 2010 08:40:30 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1264160879-26079-1-git-send-email-j6t@kdbg.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.448 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137765>



On Fri, 22 Jan 2010, Johannes Sixt wrote:
>
> This call should have been removed when the utility was made a builtin by
> 907a7cb.

Ack.

			Linus
