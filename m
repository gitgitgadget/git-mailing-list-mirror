From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 07:50:15 +0200
Message-ID: <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-2-git-send-email-srabbelier@gmail.com>
	<CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
	<20121024180807.GA3338@elie.Belkin>
	<CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
	<20121024191149.GA3120@elie.Belkin>
	<CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
	<20121025042731.GA11243@elie.Belkin>
	<CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
	<20121025052823.GB11243@elie.Belkin>
	<CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 07:50:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRGKv-0005DC-MN
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 07:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842Ab2JYFuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 01:50:17 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34713 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab2JYFuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 01:50:15 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1229795obb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PrmSphg5T/+3fNCQ5A5j0AwgPTfc2zA8PNoKFbal9rc=;
        b=Sv0NxyNaySbPY120N4R/FqnFmIjMnKOrbnj0TBAIIz+4w33SWaYGbQ7ghTcXkny7QC
         9FT9OrLNemfxTh0/nnuswIhBR0vKBs/sDB/qgxQvElZ15aEZcnLmW/hsCLqh4KJwtitT
         ReP3JYIYjZyFB0TOixjoUiNmzm6vaJ7l4ILScma7OSiA+49OzZ/OZbUZOyw0ZiTbYwiL
         A6S+i+oXs1PwcQMM5Sr3njOkJsSGh8HBsN4DGGgVJFMrWtBSnARSnSoVvnE7+GqcLnkq
         XtMyi3nv+dr2/53OBHTonC+6yQGn6/fXh7+bOxhlydic7shszaaGWnW8fXZ5WerxNxF0
         VlHQ==
Received: by 10.182.194.70 with SMTP id hu6mr14864000obc.4.1351144215237; Wed,
 24 Oct 2012 22:50:15 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 22:50:15 -0700 (PDT)
In-Reply-To: <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208347>

On Thu, Oct 25, 2012 at 7:39 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Oct 24, 2012 at 10:28 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> The testcase is imho correct and does not need changing.  So yes, I
>> don't want your help changing it.  I don't suspect you will be using
>> "git fast-export $(git rev-parse master)..master".  It is safe and
>> good to add additional testcases documenting the syntax that you do
>> use, as an independent topic.
>
> To re-iterate Dscho's point, the reason for this testcase is that if
> you do this:
> $ git checkout master
> $ git branch next
> $ git push hg://example.com master
> $ git push hg://example.com next
>
> With the current design, next will not be present on the remote. This
> is caused by the fact that git looks at "fast-export ^master next",
> sees that it's empty, and decides not to export anything. This patch
> series solves that, by having "fast-export ^master next" emit a "from
> :42\nreset next" (or something like that, assuming :42 is where master
> is currently at).

Only if the remote helper is using marks, and this particular patch is
adding a test-case without any use of marks at all.

IOW; this test is testing something completely different, which
happens to fix the original issue, but this is not the only way to
fix, and in IMO certainly not the best.

As I showed in my script above:

$ git checkout master
$ git branch next
$ git push hg://example.com master
$ git push hg://example.com next

This works just fine. Go ahead, apply my patch, and run it, the second
branch gets updated.

It will fail this test, but that's because the test is not testing
what it should: that *when using marks* the second branch exported is
ignored.

This test does that:

---
cat > expected << EOF
reset refs/heads/master
from ##mark##

EOF

test_expect_failure 'refs are updated even if no commits need to be exported' '
        cp tmp-marks /tmp
        git fast-export --import-marks=tmp-marks \
                --export-marks=tmp-marks master | true &&
        git fast-export --import-marks=tmp-marks \
                --export-marks=tmp-marks master > actual &&
        mark=$(grep $(git rev-parse master) tmp-marks | cut -f 1 -d " ")
        sed -i -e "s/##mark##/$mark/" expected &&
        test_cmp expected actual
'
---

-- 
Felipe Contreras
