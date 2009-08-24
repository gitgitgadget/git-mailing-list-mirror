From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
	mark
Date: Mon, 24 Aug 2009 09:24:58 +0200
Message-ID: <20090824072458.GF3526@vidovic>
References: <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <20090823171819.6117@nanako3.lavabit.com> <7v1vn2yklo.fsf@alter.siamese.dyndns.org> <20090824060708.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic> <20090824141623.6117@nanako3.lavabit.com> <20090824071711.GE3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 09:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfTvW-0001cT-8q
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 09:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZHXHZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 03:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbZHXHZC
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 03:25:02 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:60373 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbZHXHZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 03:25:01 -0400
Received: by ewy3 with SMTP id 3so2113943ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=drdLbO9C836QMBc8MBPTFwekv5l4WYOrlk81BJ1gv44=;
        b=BzIO4bKNgi6wEszbNQgAWuqiWSiwUynreCKWYsNqEuSVjYyjE0LCEv7IXBkDY5epaA
         3MygOwXjP9YEQI1yHbz0eHZaSrouY3PDiVx+fDHdiChtD+N7NP5DP/9CWTSHSVtAjCFq
         5QLH7+3J1thlhtc0Bc8wQJtMTXLnFuPa649Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Kv3fRNxyAl5t7bo2gnQ4Fh8PhhCDTNQewpHKCogR+2bNpl6oKD25EOTAB6BH5qlO1k
         fSkmnXP8Nug89PRjLvzcjOKID0IhPIVCAO+2RVF5wwfkd0ZEjgIEmHjcQ18zzfYh2BQC
         oJ4NamsEEvGYAaEgq/FZSm4ZJ24e+dvobSGSM=
Received: by 10.211.148.2 with SMTP id a2mr4427274ebo.68.1251098702033;
        Mon, 24 Aug 2009 00:25:02 -0700 (PDT)
Received: from @ (88-121-114-119.rev.libertysurf.net [88.121.114.119])
        by mx.google.com with ESMTPS id 5sm8054355eyf.28.2009.08.24.00.25.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 00:25:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090824071711.GE3526@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126914>

( Paste error, sorry. )

The 24/08/09, Nicolas Sebrecht wrote:

> [ Please, please, please, wrap your lines. ]
> 
> The 24/08/09, Nanako Shiraishi wrote:
> 
> > Looking at the way other people use the mark in their messages, I think this explanation isn't correct.
> 
> I'd say that should not document what people do but what the program
> does.
> 
> > A scissors mark doesn't have to be at the beginning. The line has to contain the mark, and it has to consist of only the mark, '-' minus, the phrase "cut here", and whitespaces.
> 
> ...and (">8" or "<8"), you're right. But isn't the following mark a bit
> too much permissive?

->8
Subject: [PATCH] squashme to 925bd84 (Teach mailinfo to ignore everything before -- >8 -- mark, 2009-08-23)

---
 Documentation/git-am.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fcacc94..5294d47 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -138,6 +138,12 @@ The commit message is formed by the title taken
from the
 where the patch begins.  Excess whitespace at the end of each
 line is automatically stripped.
 
+If a line contains a mark in the body of the message, everything
+before (and the line itself) will be ignored.  A mark has typically
+the form "-- >8 -- cut here -- >8 --".  Strictly speacking, it must
+have one dash at least and a ">8" (or "<8").  Spaces and strings
+"cut here" are permited.
+
 The patch is expected to be inline, directly following the
 message.  Any line that is of the form:
 
-- 
Nicolas Sebrecht
