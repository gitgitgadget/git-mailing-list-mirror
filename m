From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 10:13:41 -0400
Message-ID: <CAM9Z-nnrFxhX7XxBqe4qfuqZigpD12CrN2W6d=L996rJ_ecWFQ@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
	<CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
	<CAEUsAPZC80aSwnS0sBTt9nEu0HgyPp0BD2TWjSBb7tS7=i=VhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 16:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkfb-0000p0-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 16:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933118Ab2JZONn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 10:13:43 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33019 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043Ab2JZONm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 10:13:42 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1283631bkc.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RdKBbK2RHoqY0QIMmN9PXTmyzvEWNBclFvNR7SKU+S4=;
        b=J6IPGrtSrWOz8NseWqZZmwlJNK4TYBBwPg1I86bvxtFmcK0xn+19mi6E6zvvq+53nn
         kq1gT7LsxSVjjnRd2PAsI5t4ZBhdwDSTIL2WBEbsGYWUVGcSCqoVE1Gge7OLCqKGzd6a
         6FYiJqf0kn/UrMrvgbnAe8uxNT8hjN09u/zia9ok9QM1nj8cOd7YOiCMskEQUyVqqaDb
         sglFBTw6njUQxEQU1c/tl13Dk7+B6+qPYxuZ+hJvTW/e4ASGkD8EP8ZmvYFIvLzIN2Fh
         Fdm8N671rvj0b/ODoLFNAagJnSOjwnbShCpepWWIeOp9q6Wf6TgkwDjEhpsXoWwdyih7
         tHQA==
Received: by 10.204.11.210 with SMTP id u18mr7294766bku.123.1351260821471;
 Fri, 26 Oct 2012 07:13:41 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Fri, 26 Oct 2012 07:13:41 -0700 (PDT)
In-Reply-To: <CAEUsAPZC80aSwnS0sBTt9nEu0HgyPp0BD2TWjSBb7tS7=i=VhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208451>

On Fri, Oct 26, 2012 at 9:59 AM, Chris Rorvick <chris@rorvick.com> wrote:
> On Fri, Oct 26, 2012 at 8:37 AM, Drew Northup <n1xim.email@gmail.com> wrote:
>> (As for deleting the current branch, you can't really do that on a
>> proper bare remote anyway as there is no such thing as a "current
>> branch" in that context.)
>
> Really?  When I clone a bare repository I see a HEAD, and Git doesn't
> want me to delete it with a push from a remote repo.  So is this not a
> "proper" bare repository?

Chris,
If there's no working directory in the remote repository is there a
"current branch" in the _remote_ repository? (I am not talking about
the tracking branch here. I also presume that attempting to delete the
one and only branch is somewhat nonsensical.)

In any case, this is a different mental model than the one Angelo
seems (to me) to be arguing.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
