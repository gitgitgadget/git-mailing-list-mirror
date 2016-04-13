From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Wed, 13 Apr 2016 13:27:46 -0400
Message-ID: <CAPig+cSvvAJT6yb2h6B1S5LDr8H03t-b66rmbKWpo88Fw-ehmg@mail.gmail.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
	<010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
	<CAPig+cTB=bYNxR8yN2CGvkmtCZKomnbdNnZon9HA5uE9aivW=Q@mail.gmail.com>
	<CAFZEwPMU5KSoBJ0kHGnnPCq0zsoj8ROAXhJ9HFn66fqDehvWGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:27:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOa0-0005G4-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbcDMR1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:27:48 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35668 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbcDMR1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:27:48 -0400
Received: by mail-ig0-f195.google.com with SMTP id fn8so7448582igb.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=nN4jBmlleRvyLviIu9mQwy5T6HwsEv77q7NsjV/zk0U=;
        b=DnlWZz2YPcf/eov/HE1R/hfR0SqQgZwLXDOo0DPdDGMpU3asF4KyHG8wWb78Cuihkd
         u9F8TUCdEqBRBrIurb81eOBzoy1lAa/mcv4hn3syjUD4ReukXkv5rxmMIi9vZ9YaN1QX
         0fZHYX80ipA/yM+0mfLGBLbhPrZD0XzBhhd8SwgnpdRorvKpGtDYy1oLN0dFQBI3+LiZ
         T0OLpk3mZJ68SGo0CjrDUgNu1CeCQRBnyoLTIZVRUOVqIwDTbg6LSUqs8pF0Xpm/j9kS
         lb1qDL6gNJYoc0YPaRvCuzsgLOpTYfJUReVM5YhS5pj4IwDhqxnvS1alKKnQt5ZDzcJS
         E8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nN4jBmlleRvyLviIu9mQwy5T6HwsEv77q7NsjV/zk0U=;
        b=O4jhNdxDjiNl4b9UHPjt5/pU+JW0+E8/vQf/QCAE0T88qMKFH415YF2n7TvKY9creJ
         Ycb1Ja+wdt59eI3DXos8rmEoot+e1m4u8wdQJPxoFRHJ9fA3JijSRoqMsCj3EDQ7QbUG
         FVz0AHa01EQDSRTnGGcjilyVWNOPz08XDo9kz/OnAn2ExN7lZRS402SH3dRX3v6JInEZ
         mzLIftTbhliefZ231Ig9Ru90OrTyBQ6CUNI/aWl4zskqnVYV7SHMx+twGKXVlLDdxCJ3
         k1cMI5zbNLab+XdVZlmKzpLOXgDl02QzVd9AdZhMd/zMOrMh5TOWR+GTt/BaL99jN5IC
         QH5w==
X-Gm-Message-State: AOPr4FVHnuys3vSMPicue1EIfebRAtBb/6dh0IrnNpZbelTwMyIHhZZs6z1CLB0byJeW7zQZgbe1lfYTHd+nQg==
X-Received: by 10.50.77.107 with SMTP id r11mr12187015igw.91.1460568466814;
 Wed, 13 Apr 2016 10:27:46 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Wed, 13 Apr 2016 10:27:46 -0700 (PDT)
In-Reply-To: <CAFZEwPMU5KSoBJ0kHGnnPCq0zsoj8ROAXhJ9HFn66fqDehvWGw@mail.gmail.com>
X-Google-Sender-Auth: dKMzD4akGeJqKK3RmsX_XiLEVrM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291463>

On Wed, Apr 13, 2016 at 4:59 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Apr 13, 2016 at 10:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Apr 12, 2016 at 7:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> +test_expect_success '--no-quiet sets quiet to 0' '
>>> +       test-parse-options --no-quiet >output 2>output.err &&
>>
>> Meh, as implemented, this isn't a very interesting test, is it?
>> 'quiet' started at 0, so all this shows is that --no-quiet didn't
>> disturb the 0. To really test that it resets it to 0, you'd want:
>>
>>     test-parse-options --quiet --no-quiet >... 2>... &&
>>
>>> +       test_must_be_empty output.err &&
>>> +       test_cmp expect output
>>> +'
>>>  test_done
>
> This is to test whether the 0 of quiet remains 0 if --no-quiet is
> included. This test "defines" the current behavior. Then when I change
> OPT_COUNTUP(), this test will ensure that this behavior is not
> interrupted as promised by the commit message of that patch[1]. I
> guess this also describe why I choose to include these tests between
> 2/5 and 3/5 rather than 3/5 and 4/5. And also see the extended
> discussion[2] for this. If I do a re-roll then I include `--quiet`
> before `--no-quiet`

Each of these patches should have a single conceptual purpose. It
seems, from the above explanation, that you're mixing and mismatching
bits of such changes between patches.

* The two new tests for --no-verbose and --no-quiet should be together
and check that they correctly reverse --verbose and --quiet,
respectively.

* The test you describe above which ensures that --no-quiet leaves
'quiet' at 0 should be bundled with the change that might break that
behavior, namely, the OPT__COUNTUP() change.
