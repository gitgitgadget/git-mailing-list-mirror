From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Tue, 3 May 2016 12:17:00 -0400
Message-ID: <CAPig+cRa4z2ZUsQ7a-w1MT8S=haaqFeELK8fjwp62BZLBfnnQQ@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOAWh48YCxA3B+kRxVpkwN32OHW7Qrb9ajs2Cy0S8sjLw@mail.gmail.com>
	<CAPig+cR7pPHZv_z3G+BsLPqP7WYSVUb_7c2qmM+0y-TFeWjaSg@mail.gmail.com>
	<CAFZEwPMLcyAu67MrVWKpN2ytAFaB6rOj4ASUi3VG81DSS0Euiw@mail.gmail.com>
	<CAPig+cQC0r6Lm9kOFQ2xukN-GiU0iTV5BNc7W8t4f0trkdtHsQ@mail.gmail.com>
	<CAFZEwPOYi0rv-WhVuV5ALwd=2_w2F2aeKN61EoZxswQQRGqcnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:17:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axd0W-0006Sv-MN
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbcECQRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:17:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36151 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbcECQRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:17:02 -0400
Received: by mail-io0-f196.google.com with SMTP id k129so2769087iof.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=9Q6auZFHQ5zbqa87Gwu58j4jPP4PHESdNbI3enJSUEQ=;
        b=HdRjuC4XzbxZ/a3A0msVqN5Lg3okH8N/otwuiy+jk0kC41phPcE2ZMTuNItvvB5sua
         5+oLEnljhr8/fFxuaveqDLeJKPmLAgevDnCad5ZgmbMKmbltxGZbemhyhsAlYbucms+P
         5PCu+u3E6u/Z1UepTlBE0pw4ZjgM/1C1XgiLYEH/AnbPtCes0j/27554KrBlkaDN/ebd
         ZC95xjlX6nEoQGSSRYhG7QKou3ZroymgNpD+mTkXIA7XRk5YgpnaI0ZTz0r39G8J0GPL
         S/YaT5tmUgvjNehob5cZ/AZK0i1zARR1rc7I7lA32yZenjzNCNVxIpdTHP6+TcXjseDT
         aFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9Q6auZFHQ5zbqa87Gwu58j4jPP4PHESdNbI3enJSUEQ=;
        b=cMqGMzKR36Go3LJ8mSGq9SjB5Ic5YMa1+UMah0n5ft5Pd4XPpxNxVjFtqHNdxbH0v1
         Sv4piCf3WiNzbSJVtanyZBQcmFkW/XHpVACQ9gQrRJ+PwbRcakZMR40Fsh8vLRJwd2Gt
         mDbDCNWwwtjvwIbR5W5FtYcE1KosIXixyZcwVQMHVxK1nlKoXboo+HmqAifC+e7okl8U
         Big833LT/APavefRGzAd6LDbE8uhAxkFjGuBdlKClHXB6cBJrkBiL2+/ECMuJKGMb96O
         cpDrLLLVbXWnUDJpCTk/Jot7rE21iZnc+gktTEz1EFW1yO0FiHjLVGioG0QU9iLywDd4
         AW3g==
X-Gm-Message-State: AOPr4FVsGGhC3lTOIlR94NpQrH75+0GmrsldFRJ2B48EoY1yDPpTNACuTwceDTSGVst5dzJL0pxAay7BGikYfw==
X-Received: by 10.107.25.13 with SMTP id 13mr3538360ioz.104.1462292221050;
 Tue, 03 May 2016 09:17:01 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 3 May 2016 09:17:00 -0700 (PDT)
In-Reply-To: <CAFZEwPOYi0rv-WhVuV5ALwd=2_w2F2aeKN61EoZxswQQRGqcnA@mail.gmail.com>
X-Google-Sender-Auth: dU58MIX8I7Xukm7CG0_CfQhU9us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293409>

On Tue, May 3, 2016 at 5:18 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Tue, May 3, 2016 at 12:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> Step back a moment and recall why these tests were added. Earlier
>>>> rounds of this series were buggy and caused regressions in git-status.
>>>> As a consequence, reviewers suggested[1,2] that you improve test
>>>> coverage to ensure that such breakage is caught early.
>>>>
>>>> The point of these new tests is to prevent regressions caused by
>>>> *subsequent* changes, which is why it was suggested that these tests
>>>> be added early (as a "preparatory patch"[3]), not at the very end of
>>>> the series as done here in v15.
>>>
>>> Sure! I just wanted the commit message to be detailed as per the
>>> guidelines given by SubmittingPatches. I will swap the patch 6/7 and
>>> patch 7/7 changing the commit message. Also I will make the commit
>>> message less detailed.
>>
>> This patch should be inserted before 4/7 since it needs to protect
>> against breakage which might occur when 4/7 changes the behavior of
>> OPTION_COUNTUP.
>
> I forgot to mention about this earlier. When I was rebasing, this stroked me.
> I guess making any changes in ordering the commits will make one of
> the test as absurd. One of the test uses a configuration variable
> 'commit.verbose' will won't be effective before the patch 6/7. So I
> guess I will have to only change the commit message to reflect as
> "improving test coverage".

I also had intended to talk about this but forgot. What would be quite
logical is to introduce only the "git-status without --verbose" test
in this new "improve coverage" patch before 4/7. The other test, which
ensures that git-status doesn't regress with commit.verbose, would
then very naturally be included in the patch which adds the
commit.verbose functionality (currently patch 6/7).
