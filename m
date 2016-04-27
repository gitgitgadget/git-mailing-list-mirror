From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Wed, 27 Apr 2016 23:46:41 +0530
Message-ID: <CAFZEwPMDuiDcxLWya_U=LxhpQCA5+yYgHE9Q8MFarB59fTUGiQ@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
	<CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
	<CAFZEwPMU5KSoBJ0kHGnnPCq0zsoj8ROAXhJ9HFn66fqDehvWGw@mail.gmail.com>
	<CAPig+cSvvAJT6yb2h6B1S5LDr8H03t-b66rmbKWpo88Fw-ehmg@mail.gmail.com>
	<CAFZEwPMsmay+tv48p=zh3r4L1d38tNU0Z6zyn3Op_pd-nsv3Aw@mail.gmail.com>
	<CAPig+cQJok5HnFYqqhvDxAKnoEjiwrzGuc04EWrnYBYcUfQpLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:16:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avU17-0004c2-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbcD0SQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:16:45 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33144 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbcD0SQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:16:43 -0400
Received: by mail-yw0-f196.google.com with SMTP id y6so779116ywe.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 11:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kXvslR6pLlg1VP3Tj+9i7Pm48ZsQcy3taocjIMAtLgU=;
        b=Ajws8tha/qaIhtcBJb/a30+EuXVOTR6Z4NhV+f0PnvxpVG4Pkl+IQ+/Z9B14WMgA80
         pARDh1PSfLzP+4EwPE4UHmuFW9VxNg1NkJKM4PqvxhLpHWZ40lovWoPd/K6UcDIp5BJ6
         tonzkmUQ+TbmgERDMsoqO2geuaQVHOe28dv84dPxzLbsXQc/xRDBpRBO8zjr+elS2IpT
         n7S6lYAJ4A8eLHcLs1Hq6PQN1UdAuWWsuDu4q/U/vY9SNAawMR9FmQDhrFewq29STLJ3
         NP0GmvL8vBUVLTU41jMM9mC89SA6u/OW+ec9ygA5NTtqRilguiC0FZx/NCpUIELPqMf4
         LbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kXvslR6pLlg1VP3Tj+9i7Pm48ZsQcy3taocjIMAtLgU=;
        b=emqerl5xm7jfFduvK1gLSSyJSN2GnkMghumLy03pTGY9yEYGqWQ1to0GG/OL2YpCpU
         YrgrMbPpOXuoU99/NAISBAo2htXcMI4Xq7cDbCELKlKGTjvULZsY3tzHmrPXWvZ5Tul7
         bd4iyZqYquVxyKwTA8WepcOqjgsEUAyQrvlQsbLIEGeaMv/VCwj/WlN6B7PES/A+t/Xd
         URsAkJhh/qC7VMhbq0z2T/srqiC2gJRBFsa0V35Y/WQ3hFK0NoC9CJxO1f7WJbBZh1SI
         SH2TVvcQ20U59J199UqBB9gfm1aJYVCHc3q+tZBf4MD9L9nWG6zn5BmQqeTXq/58yoIs
         tg9g==
X-Gm-Message-State: AOPr4FXfb6MfmF00BqnpNkNhi+YVHu3X6HinF/ujEik3mz6Wtp/MakGrJlM8JNjEW73/fyiXSdpdlcNOsDfy2Q==
X-Received: by 10.13.244.134 with SMTP id d128mr5871533ywf.72.1461781001439;
 Wed, 27 Apr 2016 11:16:41 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 27 Apr 2016 11:16:41 -0700 (PDT)
In-Reply-To: <CAPig+cQJok5HnFYqqhvDxAKnoEjiwrzGuc04EWrnYBYcUfQpLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292783>

On Wed, Apr 27, 2016 at 11:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 25, 2016 at 2:40 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Apr 13, 2016 at 10:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Each of these patches should have a single conceptual purpose. It
>>> seems, from the above explanation, that you're mixing and mismatching
>>> bits of such changes between patches.
>>>
>>> * The two new tests for --no-verbose and --no-quiet should be together
>>> and check that they correctly reverse --verbose and --quiet,
>>> respectively.
>>>
>>> * The test you describe above which ensures that --no-quiet leaves
>>> 'quiet' at 0 should be bundled with the change that might break that
>>> behavior, namely, the OPT__COUNTUP() change.
>>
>> I am planning to re-roll this.
>> So, I am just confirming whether I understood properly.
>>
>>  * I will add the tests for check for '-q --no-quiet' instead of just
>> '--no-quiet' sets to 0 and '-v --no-verbose' sets to 0 in the patch
>> which improves test coverage which will be before the OPT_COUNTUP()
>> change.
>
> These tests would be even a bit more interesting if you tested "-q -q
> --no-quiet" and "-v -v --no-verbose", respectively, to ensure that the
> "no" options actually reset to 0 rather than merely decrementing by 1.

This seems a better choice.

> I recall also suggesting adding a new test checking that "-q -q"
> increments the quiet count to 2 (which could be done in the patch
> which makes 'quiet' print as a number instead of a boolean or in the
> same "improve test coverage" patch).

Will include this.

>>  * I will then add the test for '--no-quiet' sets to 0 in the separate
>> patch after OPT_COUNTUP() change.
>
> No, this and "--no-verbose sets to 0" are logically related to the
> OPT__COUNTUP() change, thus would be incorporated into that patch.
> Alternately, these two tests could just be part of "improve test
> coverage" patch, establishing base behavior which the OPT__COUNTUP()
> patch shouldn't break.

I would prefer including it in "improve test coverage" patch to
establish the base behavior. This seems more natural to me.

You can expect this series from me within 2 days.

Thanks.
