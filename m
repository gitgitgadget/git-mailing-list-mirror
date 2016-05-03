From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 21:48:17 +0530
Message-ID: <CAFZEwPMef2TnFS9yT6Gh-L8MwnWogzsNthktAN4CxjOxbY5JFw@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
	<CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
	<CAFZEwPMLcyAu67MrVWKpN2ytAFaB6rOj4ASUi3VG81DSS0Euiw@mail.gmail.com>
	<CAPig+cQC0r6Lm9kOFQ2xukN-GiU0iTV5BNc7W8t4f0trkdtHsQ@mail.gmail.com>
	<CAFZEwPOYi0rv-WhVuV5ALwd=2_w2F2aeKN61EoZxswQQRGqcnA@mail.gmail.com>
	<CAPig+cRa4z2ZUsQ7a-w1MT8S=haaqFeELK8fjwp62BZLBfnnQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:19:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axd1j-0007U0-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756190AbcECQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:18:19 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36757 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113AbcECQSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:18:18 -0400
Received: by mail-yw0-f175.google.com with SMTP id o66so26470087ywc.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=o8lkoPwUy6GOnHtk/Cd3G81yQxn2XBXIk+bk197XK9E=;
        b=cbMHYeyBZYwJnoOUJppG4sdJMXRC8fWEDyvMTAk4wheTTpt0+D4ISOffl3hokua3t9
         +3SZ1nD6DdhigM4sa+sdPmOAJ1TpFEVrpok4MAGo3w67o3XMUPF1Kw5/21p5xr5T+tdI
         tWBPjopc3tJ47vcPL1Nhq3Mwfw2Xph8OaTgVdKAMvVuAgUBqC3h80VO/uuzH9OT3EjLM
         fAUR/lnjvDjTt5ixX6aj/jGOEEhGTXQtVCLEdIxd+q8fJrFUS5ObeXL9OwA+qwiN8ohR
         3yIYgqWXO+amKWu4RxZasa3P7W1qlpBDiMh3dtsqhkCME4IqunQkguyEwE/3akruRc8e
         sMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o8lkoPwUy6GOnHtk/Cd3G81yQxn2XBXIk+bk197XK9E=;
        b=ejDcyQw8cSsteP8UJCjVFSNdbsjKFjQ3lcbsKMsdGH6eHONKcrOgOWyvNjjSy8GCK+
         ojiNHljmWKHHNZhH6wO8RB1i1xG3G5R+pP+XdXDCBlO9Old1xGj6EeWQ5dVgVAnCbyGb
         2PXjQK5SMlaaksk0QSRwkdCXvrusR8k9oWtTXFmsVu88Dmgm4RKYjfLKArtdLP/8q0xK
         eOblQ0UsDCmAtdM97Ng3etScr2EgjnX/A1/41/uQKkRIraON4cERYjVMR6hHqDuAlbH3
         OFKTSTgqaZ8teD85uRoU43dvHxtbll5R6bbVE562J4iNfBkQBz4v5d1Tc1ZSZfmLIQtD
         JzaQ==
X-Gm-Message-State: AOPr4FXsnfeWQHNSjK2jKTSkBH1SiYjoRUY4vKpi34uHby8/ZKX/tw31Y1wmEqkI63nrD3CWwreU89w6seiGBw==
X-Received: by 10.13.244.134 with SMTP id d128mr1693014ywf.72.1462292297693;
 Tue, 03 May 2016 09:18:17 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 3 May 2016 09:18:17 -0700 (PDT)
In-Reply-To: <CAPig+cRa4z2ZUsQ7a-w1MT8S=haaqFeELK8fjwp62BZLBfnnQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293410>

On Tue, May 3, 2016 at 9:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, May 3, 2016 at 5:18 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Tue, May 3, 2016 at 12:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> Step back a moment and recall why these tests were added. Earlier
>>>>> rounds of this series were buggy and caused regressions in git-status.
>>>>> As a consequence, reviewers suggested[1,2] that you improve test
>>>>> coverage to ensure that such breakage is caught early.
>>>>>
>>>>> The point of these new tests is to prevent regressions caused by
>>>>> *subsequent* changes, which is why it was suggested that these tests
>>>>> be added early (as a "preparatory patch"[3]), not at the very end of
>>>>> the series as done here in v15.
>>>>
>>>> Sure! I just wanted the commit message to be detailed as per the
>>>> guidelines given by SubmittingPatches. I will swap the patch 6/7 and
>>>> patch 7/7 changing the commit message. Also I will make the commit
>>>> message less detailed.
>>>
>>> This patch should be inserted before 4/7 since it needs to protect
>>> against breakage which might occur when 4/7 changes the behavior of
>>> OPTION_COUNTUP.
>>
>> I forgot to mention about this earlier. When I was rebasing, this stroked me.
>> I guess making any changes in ordering the commits will make one of
>> the test as absurd. One of the test uses a configuration variable
>> 'commit.verbose' will won't be effective before the patch 6/7. So I
>> guess I will have to only change the commit message to reflect as
>> "improving test coverage".
>
> I also had intended to talk about this but forgot. What would be quite
> logical is to introduce only the "git-status without --verbose" test
> in this new "improve coverage" patch before 4/7. The other test, which
> ensures that git-status doesn't regress with commit.verbose, would
> then very naturally be included in the patch which adds the
> commit.verbose functionality (currently patch 6/7).

Sure. Will do. Thanks!
