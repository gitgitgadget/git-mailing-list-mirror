From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 12:16:00 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 21:19:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAT53-0001hr-Q1
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799Ab0EGTTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:19:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48944 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755211Ab0EGTTT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:19:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47JHu9b013056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 May 2010 12:17:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o47JHtBK006825;
	Fri, 7 May 2010 12:17:55 -0700
In-Reply-To: <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146558>



On Fri, 7 May 2010, Avery Pennarun wrote:
> 
> Unfortunately this option wouldn't be as flexible as Eyvind's current proposal.

Oh, absolutely it is.

> What his method allows is to mark some files in a project as "these
> should be the native EOL style" and others as "these should be left
> alone."

But that's what a .gitconfig would too. We _already_ have that 
.gitattribute thing to then distinguish particular pathname rules. It's 
just that currently .git/config is needed to _enable_ it.

			Linus
