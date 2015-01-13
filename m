From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 12:00:18 -0800
Message-ID: <CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq387eed30.fsf@gitster.dls.corp.google.com>
	<CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
	<xmqqppaicwww.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB7dj-0005dN-7a
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 21:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbbAMUA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 15:00:27 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:62675 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbAMUAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 15:00:24 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so5877106iga.5
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=drULuwdiwLwq6lzfRs8vU/4ZK6xIml7RU3Vw0u+JH6M=;
        b=P0HqgfgheUU5otpEfyV2BvsynNsfTo3cO+Ux/CsnMpAl0VaGqL1w1WMgjqWjGzcT5+
         8m93pRz4/NTgecbfrnBirgz86L+mA73f7USVfB+TyRiZc8vKHJfYMXz4w5E7jxF64Xub
         VFUGQzr1hzadgL/+m/6x3LbCg8yM7lPHTiS6JvJH36UfOYz3I1GeF6MO7j9tMxNDjInS
         1UVh+0FU3P8bzT65z5e135aryunb9uMepfbUzwFgt3GiJYOeCEqmmLhLWy75HV1kqbUL
         VXLcKTgvmWqv/bIw/8W9BU735sA5ELp2NKZK+V0RbDZr8jbc+stXnJxZjbIGL3BkXs4G
         CRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=drULuwdiwLwq6lzfRs8vU/4ZK6xIml7RU3Vw0u+JH6M=;
        b=Pjh5Qa17D/VkdXKz0XC3uuGxbDU67PupFNoje2wMPswdeEoLmg6RR91AHdrLn2XulV
         WJLZGopzjW9Xxvo1hNIqTF6irukd4L00jspB6FTDcafdBWrbRtBXJXFewjq3HrhPVFYk
         8423QMmTm2RbcWmplr4DAEdx9PNI9N+ZFkNxw1plAQZANURRTUXE/9XgklbmEUi+XoQA
         KW7cgkgxnY48YDKSl8Bqtlf4XM6852s3SainZeLLgMflyvcdCgoYs7hcsKzbMD7zJNWj
         lNB+gME2ZoKUTLzmM7xtZT7FumL3KZufbHoem57WJB0iZKGrveJ4+C/Lomn99Fw2TJa1
         FNdg==
X-Gm-Message-State: ALoCoQlDV30MZQDeC2sD65YfjDwKaMgSWuQjaJ+xwys6ZBd9av1cnXhixBAPzlevy6X9iWB501P7
X-Received: by 10.43.82.72 with SMTP id ab8mr1224868icc.76.1421179218521; Tue,
 13 Jan 2015 12:00:18 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 13 Jan 2015 12:00:18 -0800 (PST)
In-Reply-To: <xmqqppaicwww.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262353>

On Tue, Jan 13, 2015 at 11:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> 2015-01-14 0:43 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>>> Why?
>>
>> As some commands does it when they are executed without arguments,
>> like git config, git blame and etc...
>
> For format-patch, I think the current behaviour is more of the lack
> of implementation of the obvious default.  "git blame" does not have
> any obvious default (would there be a single file you would want to
> dig the history when the user does not tell you which one?  No), so
> it proabaly is the right thing to do to error out.
>
> But I would not surprised if those who build on top of others' work
> to wish that "git format-patch" that was invoked without argument on
> a branch created by "git checkout -t -b" to default to format commits
> since the branch forked from @{upstream}, for example.

My initial reaction was to assume HEAD^ if no arguments are given to
format-patch. Though after thinking about it, the behavior you're
proposing makes more sense.

Another idea would be to take the first commit which is pointed to by
another branch as the first commit in the commit range. I am currently
thinking about the atomic patch series which I developed on top of
origin/mh/reflog-expire and that would be the first branch you find if
you just go back in history and look for any branches. Usually that
would be the upstream tracking branch though, so this would be an
extension to your proposal.

Though I am not sure if this scales. (Who has many branches anyway? ;)
