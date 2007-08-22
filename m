From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 16:10:30 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221607590.30176@woody.linux-foundation.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
 <86absjcqfq.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org>
 <85ir77ky0u.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 01:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INzMF-0004zK-TL
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 01:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbXHVXLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbXHVXLU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 19:11:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36613 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763683AbXHVXLT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 19:11:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MNAaxM007376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 16:10:37 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7MNAUsq009679;
	Wed, 22 Aug 2007 16:10:31 -0700
In-Reply-To: <85ir77ky0u.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-4.75 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56434>



On Thu, 23 Aug 2007, David Kastrup wrote:
> >
> > But your statement is provably wrong. Just *look* at well-maintained
> > projects that have extended way past their original design and usage
> > model. A lot of them are in C.
> 
> You mean like Emacs which is mostly scripted in Elisp?  Or the Gimp
> which is mainly scripted using script-fu?

No. I mean standard C code projects. Like the kernel. Like a huge class of 
other projects that are C. Not scripts.

Big, huge, projects are all done in C, and they are well-maintained.

Scripting is not the rule at all. And it is silly to say that regular 
all-C projects need to have scripting.

			Linus
