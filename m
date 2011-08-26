From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Fri, 26 Aug 2011 13:59:35 -0700
Message-ID: <CA+55aFy=T82q==OxAzRfUgyfzMvy7=oeLOEAL8=rTJWOwkw-iA@mail.gmail.com>
References: <4E56CE8F.8080501@panasas.com> <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
 <7vfwkndhc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 23:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx3Vh-00070l-4Z
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 23:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab1HZVAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 17:00:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46684 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755111Ab1HZU77 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 16:59:59 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7QKxuZS007950
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Fri, 26 Aug 2011 13:59:58 -0700
Received: by wyg24 with SMTP id 24so2761389wyg.19
        for <multiple recipients>; Fri, 26 Aug 2011 13:59:55 -0700 (PDT)
Received: by 10.216.14.234 with SMTP id d84mr2124652wed.85.1314392395118; Fri,
 26 Aug 2011 13:59:55 -0700 (PDT)
Received: by 10.216.187.66 with HTTP; Fri, 26 Aug 2011 13:59:35 -0700 (PDT)
In-Reply-To: <7vfwkndhc4.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-105.003 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180199>

On Fri, Aug 26, 2011 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Not quite sure what you exactly mean by "extend it from just binary-vs-text".
> Do you mean update buffer_is_binary() and add source language detection?

Yes. Except the "detection" would be just "if we auto-detect it as
text, then use the standard file extensions to also make an automatic
hunk rule detection".

So it would do the most common cases (*.[Cch] etc)

                         Linus
