From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Fri, 26 Aug 2011 13:55:12 -0700
Message-ID: <4E580830.4010305@panasas.com>
References: <4E56CE8F.8080501@panasas.com> <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 22:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx3RG-0004wh-7t
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 22:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab1HZUz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 16:55:27 -0400
Received: from natasha.panasas.com ([67.152.220.90]:41051 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab1HZUz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 16:55:26 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7QKtL02012259;
	Fri, 26 Aug 2011 16:55:21 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 26 Aug
 2011 16:55:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180197>

On 08/26/2011 01:27 PM, Linus Torvalds wrote:
> On Thu, Aug 25, 2011 at 3:37 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>>
>> Add a .gitattributes file to the Linux tree to enable cpp parsing
>> of the source files.
> 
> Hmm. I'm not entirely conviced. If people really think that the hunk
> description matters that much, maybe we should just instead improve on
> the automatic diff detection, and extend it from just binary-vs-text,
> to also do the common hunk-headers.
> 
> After all, not having a diff pattern already *does* mean "automatic",
> so it would be just a rather trivial extension to that.
> 
> Junio?
> 

There was a patch submitted for new git version to auto detect file
extensions and do the right thing. 
(Look for the thread "git diff annoyance / feature request" on the git
 mailing list)

But this patch is for all the people and distributions that are going
to use the old git versions for a while, (Years).

It is important for the Linux mailing-list review, because you get
patches with:

@@@ lable out:
-	change foo
+	to bazz

And how the hell are you suppose to know where in the file it is.
This is such a trivial addition, that can help unify everyone's
usage. I don't see the down sides.

Thanks
Boaz

>                      Linus
