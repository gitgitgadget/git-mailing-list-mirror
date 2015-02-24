From: Guilherme <guibufolo@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 13:22:37 +0100
Message-ID: <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
 <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com>
 <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
 <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com> <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: gitster@pobox.com, l.s.r@web.de, Duy Nguyen <pclouds@gmail.com>,
	torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Tue Feb 24 13:23:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQEWJ-0001V8-VS
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 13:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbbBXMXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 07:23:20 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53751 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbBXMXT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 07:23:19 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so25007392wid.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+8EVZ4YcsE/A9N9xi1UZRH2Jdtj4Z29Y9C8LyuZuuwg=;
        b=vDgybKMGheU11Kv5RHRwRYIHyBs9OuJSuOhKVNp6qxpgTP8mHST3UQUdjETCQSZKAV
         RuTyddWJZLLIN0zGh7Smk1G2NBMa/+TwU1JxMgGKtesWva+OhogLZ5ULwTmNyBf9hqrH
         hZvMCoZ0jNpjYi3croxUX8v3Y4YQhurZLW6khd9+USKN3PpzIUyFDE8ds4/3c86mLT4a
         5VmlJV2VOZhhTXES1qzYkSaY4ggvMTowhJ8t+zA6IBv/YKJoEJKPLUw+2qVm3806+xdK
         hKEXISqydgDE/2x4UUMN1CAX2uBqDJjYiFIuI9Onrb4lytIlwxtf/gAz30h+U0CB1o+X
         MI4g==
X-Received: by 10.180.198.19 with SMTP id iy19mr13512159wic.8.1424780598125;
 Tue, 24 Feb 2015 04:23:18 -0800 (PST)
Received: by 10.27.95.230 with HTTP; Tue, 24 Feb 2015 04:22:37 -0800 (PST)
In-Reply-To: <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264322>

Hello,

I'm writing to you in regards to the files ctypes.c
which you have modified part of in the git project.

I'm currently working on integrating gitignore pattern matching into
the_sivler_searcher(http://github.com/ggreer/the_silver_searcher). PR
https://github.com/ggreer/the_silver_searcher/pull/614

For that i needed wildmatch.c and it's dependencies. That is parts of
ctypes.c lines 8 to 31.

Unfortunately TSS is Apache licensed wheras git is GPL, those licenses
are incompatible and thus i ask if you agree that your portion if the
code is also licensed under Apache2 for the use in TSS.

You can follow the discussion under
http://article.gmane.org/gmane.comp.version-control.git/264312

Thank you very much,
Bufolo
