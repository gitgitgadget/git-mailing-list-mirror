From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Wed, 16 Mar 2016 00:30:09 +0530
Message-ID: <CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:00:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuCW-0003TA-GK
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965677AbcCOTAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 15:00:11 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34410 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934145AbcCOTAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 15:00:10 -0400
Received: by mail-yw0-f173.google.com with SMTP id h129so33181357ywb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=hui0b42A+APaNEyhTBFTUyo7WvjC2JNI9Cgj4n7L/8s=;
        b=d+GMDNIWxYuFuMXogfP4jV1PRlmghJO5JLcw54spsqVx4635XSLYGMkctHKPQQNaHG
         nNw4VUE5cqDW01xRxQc0/prFWfLhHevR3UJKtWo89Vv+fl7v/DuqwhiwZaczmr8pyqY0
         okj1RQNib7uyPxbo9/nqHGJ2P6qXR+vSAS3lVlgbnKt6VoAIEkdvYDgFFwW+4ZXtuEFk
         Bv6KqE6jFtMlitN7RJQUDu7p2vMLYHEpmeoXe2QBVAyc9iLQ6WHlSXRRsy/6Ai7TPnzo
         H7z+EhEUdYIwpDF7r+55T9sEYUCLWo7SX9WZ74D521bparJJgAtsCod7UXveIsT6yWfk
         zzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=hui0b42A+APaNEyhTBFTUyo7WvjC2JNI9Cgj4n7L/8s=;
        b=dncu8T1UZVQB+4l0no7TBDCec7LE4yV9FSySVt+IGBivzSR49PckWWmVEMIuBPNM7+
         JtSqjH3CECqrZxVNUyZoq1Vy8mGvcgNZSv7C2lBrVdzeZd0S5/XTAjgZIJxgTLoqzRGt
         +ddHi18pqDwIQiJj96oNRHVbNuysx0m/LLAYSTfRERrYJHDbcu3rAgmrhEY8P6COZcnJ
         hqFLY5lqskRGL25olyACdQw6uaogz31QUQBsXPVMgXfI/CgYsXoVIoAPORkle7OoYPnM
         cl2m1X8ck//pM7Gl4mouDR0Oj2i2UBVDtRN6oq6NXxaGyc+sBMq62JEbLhW15bwp+CxR
         y81w==
X-Gm-Message-State: AD7BkJJ7YgHIqHxG0pntM6+kBRNfiiY4LxWq928fRl4rGqeUnCECceY9+DOP31spSL920N7/xwvE/Uvr5gK+eA==
X-Received: by 10.13.252.67 with SMTP id m64mr17779671ywf.67.1458068409136;
 Tue, 15 Mar 2016 12:00:09 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 15 Mar 2016 12:00:09 -0700 (PDT)
In-Reply-To: <1458041486-7044-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288891>

On Tue, Mar 15, 2016 at 5:01 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:

> You made 'commit.verbose' a boolean, so either verbose or not, ...
> ... but note these context lines telling us that --verbose can be
> specified not just once but twice (and who knows what the future may
> bring).  This raises some not entirely rhetorical questions:
>
>   - What does 'git config commit.verbose true && git commit --verbose=
'
>     do?

This is a nice thought which didn't strike me!

As Eric Sunshine mentioned ($gmane.org/288811), it would react
according to the multiple verbosity level and since its not currently
defined in `commit` it will react as it is reacting when verbosity
level is 1.

If let's say we incorporate this behavior now, it can lead to
confusion for the user (not developer) as to whether `commit` supports
multiple verbosity.

>   - Should 'commit.verbose' only care about the convenience of those
>     who always prever '--verbose', or about those who like '-v -v',
>     too?
>
>   - If the latter, i.e. 'commit.verbose' should cater for '-v -v' as
>     well, then what should 'git config commit.verbose "<verbose level
>     two>" && git commit --verbose' do?

If I was the user, I would use multiple levels of verbosity only where
I would feel that there is some problem happening with the commit that
is in progress. Having an "awkward" commit isn't usual and definitely
not every time. Though if in future it is required, We can add edit
the line namely :

 if(!strcmp(k, "commit.verbose")) {
-     verbose =3D git_config_bool(k, v);
+    verbose =3D git_config_int(k, v);
 return 0;
 }

Additionally we will have to define scenarios and mention them in the
documentation as to how `commit` will react as this cannot be known by
intuition. This would complicate things for the user who is reading
the man pages.

Regards,
Pranit Bauva
