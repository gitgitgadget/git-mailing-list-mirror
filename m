From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 10:35:32 -0800
Message-ID: <3ab397d0812301035w3dcd872fkae9509629a0ed7de@mail.gmail.com>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org>
	 <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com>
	 <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org>
	 <gjdmm6$9oj$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 19:40:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHjW7-0001fb-Sj
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 19:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYL3Sff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYL3Sff
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 13:35:35 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:29188 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbYL3Sfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 13:35:34 -0500
Received: by rn-out-0910.google.com with SMTP id k40so3595328rnd.17
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MPbR2lgAAYXOUm5LDodwH6MwU1DWxi0w0e5VC2Bitl4=;
        b=Dbe9+mWpXyz+2t8lHVVfj+f6n1CWAIwdiQnRTSh0WhGRl8jUsCXhJluqGAwIGEDLu8
         Fqdu3ZeCL4FLuDnxOOMdlgbK/2Jq165JUxmlYiYnYJp4TbhBHDTHskUrH7qtz/JIIa0U
         +2lGFPeipPVEuQJlrXdBQiilrcEKwUSeYP3xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AQUFr7wNygvC+O91oeDYIgd1hZqmFCyPfHTnrGnBRg33DHO1NtAQANaQJ6TD4KR5fX
         2q49i3d1JcLzlvRwGepZ+6w2mJig+QoVK9c83PKqQjxPdbDDDdfiZyUtBKQCp4nY5MsJ
         h8d133YQXt9f4qNmq0TebHyZeIQHXLRixjXzM=
Received: by 10.100.121.12 with SMTP id t12mr8484799anc.96.1230662132939;
        Tue, 30 Dec 2008 10:35:32 -0800 (PST)
Received: by 10.100.105.20 with HTTP; Tue, 30 Dec 2008 10:35:32 -0800 (PST)
In-Reply-To: <gjdmm6$9oj$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104197>

> commit -a detects that files have been deleted, and takes them out of the index !
> could also have used $ git rm <specific files> and then $ git commit ..

hey! i like your changes! the post is pretty polished now.  the only
thing else i would change (srysry), is the above.  "-a detects that
files have been deleted"  -> heh, not true.  you don't need -a here;
it does something else.

okay i just recreated your repo and did the same thing.  with your
syntax "git checkout versionA ." i got the same result, and i'm not
sure why, but i think it was because of the detached head.

good news, use "git checkout versionA", not "git checkout versionA ."
(so, use it wihtout the dot), and you should be back in working order.

the other (good?)  news is that you probably _do_ want to be using git
reset --hard in your case, because you're trying to build up a history
from some project, so you do want to erase some faulty commits after
you bodge something or miss some files.

the bad news is that my opinion is that you should probably move on
with your life, because my own past tells me that you'll never
actually use those old project versions, hahah :p
