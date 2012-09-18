From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 12:47:42 +0530
Message-ID: <CALkWK0kbeLtU-5_9QnmQKS1yO02SvCW3ERvami9bmCa0Vym8oQ@mail.gmail.com>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com> <7v7grstlp9.fsf@alter.siamese.dyndns.org>
 <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com> <7v627bq0gx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDs4b-0003rt-1Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab2IRHSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:18:06 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33410 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757212Ab2IRHSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 03:18:03 -0400
Received: by qcro28 with SMTP id o28so5143633qcr.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XioGfnWB03mR/c+R9wcF1PKUBhOImixW7Yf6BWPBGF0=;
        b=DoiTgHxvwHwWtWOW2tVXOKLddcfZdulO3f6R53S0LBGTS+bnT9tVYpE2hGuCp7Me3C
         mPULTmCYOH7kqy6HlFcCDxig/W7Ef6tSJ+OCDRqQR214UIvlLn71+l8sYic8woadKs5l
         +33L35mDLgXvMxBmQ+Rj/ZJWGzi/vrwXtp8q3NEUo4YkjrCy/hVsfMUPA2rJlA9CJAII
         xfDNlWuXIzLi8tLb4weshb0c1jVEKCw8DOCBHZUp5u7HRec8zfzHSMaOFsqonM46x4g1
         upPJXkS9f/eDY8KuSYMjmqWzatitrX+QaXzS2FCqSR6+RN3lbHNMrYN7B0LbyBlMdkFG
         JLgA==
Received: by 10.224.213.10 with SMTP id gu10mr31470541qab.10.1347952682353;
 Tue, 18 Sep 2012 00:18:02 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 18 Sep 2012 00:17:42 -0700 (PDT)
In-Reply-To: <7v627bq0gx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205804>

Hi,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Hi Junio,
>>
>> Junio C Hamano wrote:
>>> Is this a sufficient replacement for what you removed from 0000?
>>> Can the BUILD-OPTIONS file exist when your build of git failed?
>>
>> Oops, I didn't realize that BUILD-OPTIONS would be written when the
>> build fails.  How about something like this instead:
>
> Yeah, but why change it so much?  Wouldn't writing
>
>         "$GIT_BUILD_DIR/git" >/dev/null
>         if test $? != 1
>         then
>                 : You haven't built git!
>         fi
>
> just like the original in 0000 be sufficient??

Because that emits an ugly
./test-lib.sh: 54: /home/artagnon/src/git/t/../git: not found

Ram
