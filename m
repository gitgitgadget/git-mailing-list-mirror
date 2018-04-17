Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9701F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDQSCF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:02:05 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33279 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQSCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:02:04 -0400
Received: by mail-io0-f176.google.com with SMTP id s14so6693446ioc.0
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bdJtjD6u1h96xFJ1JpGv/+vwEkfX1G37NIJBy0jbod4=;
        b=AXVMkMfVQn30oRcDzQZI8CM0sms5DKR8XvgV9XRBS1iNDA3hcUQZA+7PShMce/b2ND
         wTriMh+qck+Mm/5aBtdo13j92LZRU4/oiwQ3NGtwYMH3S/f+VemngRBeuldRFRNhxyvl
         fsWuk+dtvg4S7WvywJ9VWjNvzBxB62/IK59XRbnrLI8vb5ok49AncQhLzbpzn5hjAVTT
         lkhboGgPDvdAhfsy4/xJ/nS59QJNwmd6lyG9hD6CpRP/v+jKJqMYbfbfxutTlu9T7x8i
         q0wQCvSK9Gh7xCjH9GxLVQi/lw+ZqYQtOzIZsSoK3m09i0Z/d05mMYy59/vvkuhKkTnx
         oYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bdJtjD6u1h96xFJ1JpGv/+vwEkfX1G37NIJBy0jbod4=;
        b=WuMmfmsIbVl7hyFHhHXeqhRN5kx/+VN/lQQpirRmf9mUPTcOJQS3BgHgdwYfPg4qDl
         DsKHcegO0KYLaOmTeYwV3299sJYdRM+FEYrfYz0AljVDU7PKxHXYIF2gZg+KYBYoDSM5
         QjkVGfBAO5JNXFbLbUexrfTiE9f/R8FEALeHMYHf2CE5XtCK/CFMWaFEYi4DKkd47zDY
         djIDOZw4q5w0WxHl+xfLkd6jWtDpDjA8FgYerfkE02dFzVSx84Z+9lt5CgI80gOLdujc
         QLMrRw/ml9J81lnS6S1dpnL0TSqW28t1hoWoJM/EoWAziWIgvViNxztdN1mGb0+GrZa2
         AsuA==
X-Gm-Message-State: ALQs6tDJAeMTY2P0F0XxCh9QafrB0cCqpXGtYXbqiGhL+SzlISjxMU5/
        f92rEG9ymWp25FqUc9gganZssItmzNU9iHu00NA=
X-Google-Smtp-Source: AIpwx4+TBrH2aTR/LALzRINHcFCxJ64Ay2iiTVhY26Jx66xUHodGiflRrUGuV++mEaIqhvCTdM8sWUpR4Rm4CAhj0SE=
X-Received: by 10.107.151.146 with SMTP id z140mr3014376iod.237.1523988124250;
 Tue, 17 Apr 2018 11:02:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a78a:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 11:01:23
 -0700 (PDT)
In-Reply-To: <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com> <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
 <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
From:   Thandesha VK <thanvk@gmail.com>
Date:   Tue, 17 Apr 2018 11:01:23 -0700
Message-ID: <CAJJpmi_Qk-Q3ndiOFiYy5fGsKsJ0mF=nKbSDkdY-NE0DRkZTEg@mail.gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sounds good. How about an enhanced version of fix from both of us.
This will let us know that something is not right with the file but
will not bark

$ git diff
diff --git a/git-p4.py b/git-p4.py
index 7bb9cadc6..df901976f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2566,7 +2566,12 @@ class P4Sync(Command, P4UserMap):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.encodeWithUTF8(relPath)
         if verbose:
-            size = int(self.stream_file['fileSize'])
+            if 'fileSize' not in self.stream_file:
+               print "WARN: File size from perforce unknown. Please
verify by p4 sizes %s" %(file['depotFile'])
+               size = "-1"
+            else:
+               size = self.stream_file['fileSize']
+            size = int(size)
             sys.stdout.write('\r%s --> %s (%i MB)\n' %
(file['depotFile'], relPath, size/1024/1024))
             sys.stdout.flush()


On Tue, Apr 17, 2018 at 10:33 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
> Sure, I totally agree.
> Sorry, I just wasn't clear enough in my previous email.
> I meant that your patch suppresses "%s --> %s (%i MB)" line in case "fileSize" is not available,
> while my patch suppresses just "(%i MB)" portion if the "fileSize" is not known.
> In other words,
>  * if "fileSize" is known:
>  ** both yours and mine patches don't change existing behavior;
>  * if "fileSize" is not known:
>  ** your patch makes streamOneP4File() not print anything;
>  ** my patch makes streamOneP4File() print "%s --> %s".
>
> Hope, I'm clearer this time.
>
> Thank you,
> Andrey
>
> From: Thandesha VK <thanvk@gmail.com>
>> *I* think keeping the filesize info is better with --verbose option as
>> that gives some clue about the file we are working on. What do you
>> think?
>> Script has similar checks of key existence at other places where it is
>> looking for fileSize.
>>
>> On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wrote:
>>> Huh, I actually have a slightly different fix for the same issue.
>>> It doesn't suppress the corresponding verbose output completely, but just removes the size information from it.
>>>
>>> Also, I'd mention that the workaround is trivial -- simply omit the "--verbose" option.
>>>
>>> Andrey Mazo (1):
>>>   git-p4: fix `sync --verbose` traceback due to 'fileSize'
>>>
>>>  git-p4.py | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>>
>>> base-commit: 468165c1d8a442994a825f3684528361727cd8c0
>>> --
>>> 2.16.1
>>>
>>
>> --
>> Thanks & Regards
>> Thandesha VK | Cellphone +1 (703) 459-5386



-- 
Thanks & Regards
Thandesha VK | Cellphone +1 (703) 459-5386
