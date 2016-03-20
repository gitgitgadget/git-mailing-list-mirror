From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Sun, 20 Mar 2016 23:32:11 +0530
Message-ID: <CAFZEwPNKozf+owtJtaE27MqQb3koL0L=HDnErVoWrTnQpieGgw@mail.gmail.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
	<CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
	<CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
	<CAPig+cSCrdxYb=0WOiAARrrPK07PeyTKsopPfwDOLAO4m3scnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:02:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahhgB-0005qM-C3
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbcCTSCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:02:14 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36335 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbcCTSCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:02:12 -0400
Received: by mail-yw0-f196.google.com with SMTP id p65so15223065ywb.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=CLb5SSN/r6/iFRVds4XOOiMsa7aTU19CsXYjO0+zrwA=;
        b=gH48gV/htfH+SRsoyvmIcAtL8XO/twXMBBl1ptB2dSxtOFct6U1R0uSlcgNJDPetL6
         DNCEB2G8zE4jfa8L0E0N5A5PCj1HLwsiujDV5k/Tb/QBNy8vWAXoigEIMYWHPsY+RJXF
         aLNkGmUvv480FWCz43D86MkiRDjjweKYBoOPoqT/s4MncX+rrw9bBspjwmBlA7WmgksA
         n5LEt6NNYEDGP5PpCnRUWLRhqCNIGimMsz46Z2/IhTxQcvO4h/8sSIXAHKfW1pzPC1FO
         S9vnzWtH6qA6SoJGEDlk8izJPRsD3kG9zCklIFPdNvMj5mZQ1DusyfG34E36Kc8iWNEU
         k78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CLb5SSN/r6/iFRVds4XOOiMsa7aTU19CsXYjO0+zrwA=;
        b=luylSPAd7xj1C93ELaRJYMExQWCReH/KKckJqIonxyyVgA5mmi6ex21I9pB23dv+bT
         XrVogGT/kt1GsPwDagFJrI+CJ5EKG1tPUzAPO4BT8ftOrJrDzfQPXE9/G6TR+zC9WKmn
         UvdyAa9VmYWHipEi9Gq+Ug89M/3btLqlTMH4km7nlOkLz57pSVtGwv9qruVT2PgX/sg4
         n/ti2AiNnxoADgy6OIyW9r5GyasyxpbLfBfypA5mDxPkAS+XKvM5duTqFIWM2I1j0P8b
         nhooaMgTtSqFHDcVzKGYmwj1NPSGUp5Ku/NeH8o6FoMzI8+f3Z3Z6xjqLm2oaGLH4V8X
         ubLQ==
X-Gm-Message-State: AD7BkJK690SMNBbThb1mU7yOSLiujTphbgPu2MWVEgxvLxmYdx/uRg3vR4x30ILB3Li0YFbmFiRMmgceR6XcqQ==
X-Received: by 10.129.91.6 with SMTP id p6mr11140642ywb.325.1458496931519;
 Sun, 20 Mar 2016 11:02:11 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 11:02:11 -0700 (PDT)
In-Reply-To: <CAPig+cSCrdxYb=0WOiAARrrPK07PeyTKsopPfwDOLAO4m3scnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289372>

On Sun, Mar 20, 2016 at 11:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Mar 20, 2016 at 7:05 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, Mar 20, 2016 at 9:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> However, more intuitive would probably be to create another "editor"
>>> similar to the 'check-for-diff' editor this script already uses. (The
>>> 'check-for-diff' editor is an obvious example about how to go about
>>> such an undertaking.) You would need to invoke 'test_set_editor' in a
>>> subshell for this particular test in order to avoid clobbering the
>>> global editor used by this script. Or, have a preparatory patch which
>>> ditches the global setting of the editor and has each test invoke
>>> 'test_set_editor' as needed (and only if needed).
>>
>> I guess it would complicate things as sometimes I need to check
>> whether it has 1 line and sometimes 2 lines.
>
> It's not really a big complication. If I'm reading the patch
> correctly, you should be able to re-use the existing check-for-diff
> "editor" for the first of the new tests for which you're currently
> setting a custom GIT_EDITOR. To do so, you will need to modify
> check-for-diff to also count lines and assert that only one was found,
> which should work for the new test and continue working for the
> existing tests.
>
> Then, you just need to create one more "editor" for the two tests
> where you set custom GIT_EDITOR and expect two lines.
>
> By the way, I forgot to mention in the review that, rather than:
>
>     wc -l out | grep "1"
>
> for counting lines in a test script, you'd use:
>
>     test_line_count = 1 out
>
> However, if you're doing it in an "editor" (which I recommend), then you'd use:
>
>     test $(wc -l <out) = 1
>
> And, another "by the way": You can use the write_script() function to
> simplify creation of the new "editor(s)".

Thanks for a detailed explanation.

> In fact, it would be nice to convert creation of the check-for-diff
> "editor" to use write_script, as well. So, basically, I'm suggesting
> splitting the current patch into three, where the first two are
> preparatory cleanups:
>
> 1. use write_script() to create the check-for-diff "editor" rather
> than creating it manually
>
> 2. drop the global test_set_editor() and instead have each test invoke
> it as needed (and only if needed)
>
> 3. the current patch which adds new tests along with a new "editor"
>
> Alternatively, combine #1 and #2 into a single patch which drops the
> global test_set_editor() and, as an aside, also does "while here,
> let's use write_script() to create 'check-for'diff' rather than doing
> so manually".

These changes seem nice. I will update and send the patch.
