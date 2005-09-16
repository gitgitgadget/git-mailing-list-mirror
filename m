From: Wolfgang Denk <wd@denx.de>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 13:03:10 +0200
Message-ID: <20050916110310.90115352B7B@atlas.denx.de>
References: <tnx3bo59tm8.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 13:05:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGE0H-00029V-QF
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 13:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbVIPLDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 07:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbVIPLDe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 07:03:34 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:7816 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932631AbVIPLDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 07:03:33 -0400
Received: from fwd34.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1EGE09-0002mL-02; Fri, 16 Sep 2005 13:03:29 +0200
Received: from denx.de (VrMRAYZAQelNhVwZS4-R2pJAjFzCUlRcG6gz7OlNEXpKJYmnVImQEr@[84.150.84.114]) by fwd34.sul.t-online.de
	with esmtp id 1EGDzy-0NB3aa0; Fri, 16 Sep 2005 13:03:18 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id CB1B4428FE; Fri, 16 Sep 2005 13:03:16 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 90115352B7B;
	Fri, 16 Sep 2005 13:03:10 +0200 (MEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-reply-to: Your message of "Fri, 16 Sep 2005 11:47:43 BST."
             <tnx3bo59tm8.fsf@arm.com> 
X-ID: VrMRAYZAQelNhVwZS4-R2pJAjFzCUlRcG6gz7OlNEXpKJYmnVImQEr@t-dialin.net
X-TOI-MSGID: 0281ab3b-57a0-41a4-9b74-759644832995
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8677>

In message <tnx3bo59tm8.fsf@arm.com> you wrote:
>
> > -> git-fsck-cache --unreachable $(cat .git/HEAD .git/refs/heads/*)
> > unreachable commit 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770
> > unreachable tree 29a4c18afd958cc6cee938f0fe7fa59764418097
> > unreachable tree 3b722a7278e02b272ddc8aefbc7be22703d8a94f
> > unreachable tree 4ebc50d240d99b4236952d13d5044691f9078e3c
> > unreachable tree 63af5944e130b449338cc907ee77c51f4a69e339
> > unreachable tree 79c9a6bb02a80df15c7d829bdac0901f88c5e301
> > unreachable blob 85dcf4b5c4c0f6833cd63fa1d0fd29ef250162af
> > unreachable commit c1b779fbce762c970e3ace4332bb6ddc0de65e61
> > unreachable blob d70d1d44f12db7b2a3976c2a5313c90568a62c25
> > unreachable commit e1bcd2a5d53bceef2679737474487e32d87e7f2c
> >
> > I have to admit that I don't know what to do next...
> >
> > a) I understand that these  messages  are  indications  of  problems,
> >    right? What can I do to clean this up?
> >
> > b) Is there any way to find out what I did wrong in the first place?
> 
> Did you use StGIT on your tree? StGIT can leave unreachable

No, I did not. I *think* these unreachable commits resulted from "git
resolve"s  which  resulted  in  merge  conflicts,  which  I  resolved
manually. After this, I ran "git commit" manually, but probably I did
something wrong. I just don't understand what this might have been...

> objects. Otherwise, git-prune should remove them.

Ummm.... I hesitate to  do  this  before  understanding  where  these
messages come from and what sort of data is affected.

> Note that if you use StGIT, git-prune will also remove the commit

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...
