From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Supporting non-blob notes
Date: Wed, 19 Feb 2014 06:10:17 +0700
Message-ID: <CACsJy8C5Hxyj27cX=Jh60ouWpXf-iEeMd9PigKaJTp3rNZrydQ@mail.gmail.com>
References: <OF23F26261.C9E4823A-ONC1257C82.0032DA0B-C1257C82.0040D57A@local> <CALKQrgff4tnekfkQn9JpJbGrNJzNBYNv=sW6vc3FE+hySkjf3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: yann.dirson@bertin.fr, git list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Feb 19 00:11:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFtoU-0000od-OY
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 00:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbaBRXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 18:10:51 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58587 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbaBRXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 18:10:48 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so26699499qcv.33
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 15:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E8fRyGBkjjCyUdT8EIismp5MO9yMsvMmCgXymck9g/U=;
        b=Lst4wx1JB2pO2Cor/Di445sL8gjZOSyJx5KF4zrjPfDRvyo1W2QTlUzRtue2B4/FOc
         WbuSo4LTk0JGnb8jqtEbuDpEJOzU9ucCmN52bIQ5deulJ9KLziukw+Ehd5XcQJoYsFBW
         1W9o/OTtB7rVH6r5EmmgyqjkxudCGY2U3I166JnTSGsg1JELr4XsNygUAT3S6JDKC/IF
         LE2ZRe9NOy/tjF6gTB0CvJ8AqnTnRjJr5FxVJhRWl1oIvV8UK4Tch9Qk2hr2T1hONyX6
         icihg1ZYPQrIErhb1QYi1Isohuf+dJmPR20dW+qlSSJa3t59WtR+azU/2eRx8BOy9SoS
         pibg==
X-Received: by 10.140.84.19 with SMTP id k19mr6178899qgd.98.1392765047576;
 Tue, 18 Feb 2014 15:10:47 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Tue, 18 Feb 2014 15:10:17 -0800 (PST)
In-Reply-To: <CALKQrgff4tnekfkQn9JpJbGrNJzNBYNv=sW6vc3FE+hySkjf3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242373>

On Tue, Feb 18, 2014 at 9:46 PM, Johan Herland <johan@herland.net> wrote:
> On Mon, Feb 17, 2014 at 11:48 AM,  <yann.dirson@bertin.fr> wrote:
>> The recent "git-note -C changes commit type?" thread
>> (http://thread.gmane.org/gmane.comp.version-control.git/241950) looks
>> like a good occasion to discuss possible uses of non-blob notes.
>>
>> The use-case we're thinking about is the storage of testrun logs as
>> notes (think: being able to justify that a given set of tests were
>> successfully run on a given revision).
>
> I think this is a good use of notes, and organizing the testrun logs
> into a tree of files seems like a natural way to proceed.

Notes from the previous attempt to store trees as notes (something to
watch out maybe, when you do it again)

http://article.gmane.org/gmane.comp.version-control.git/197712
-- 
Duy
