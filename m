From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Thu, 24 Mar 2016 00:53:19 +0530
Message-ID: <CAFZEwPM1tukRCewKCgvYMQNDRMWh4MXcrXAbdn4S3Hg8c1R+hA@mail.gmail.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
	<CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
	<CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
	<CAPig+cSCrdxYb=0WOiAARrrPK07PeyTKsopPfwDOLAO4m3scnQ@mail.gmail.com>
	<CAFZEwPNKozf+owtJtaE27MqQb3koL0L=HDnErVoWrTnQpieGgw@mail.gmail.com>
	<xmqq7fgtc88i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 20:23:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aioNJ-0001sT-19
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 20:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbcCWTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 15:23:21 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33256 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcCWTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 15:23:20 -0400
Received: by mail-yw0-f196.google.com with SMTP id a140so2874932ywe.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lnUEUaSXlrXEd8hhr8zpTdMe63aPIrW9VGr/CwVY2j4=;
        b=cr0KvN3nb28CQU0Xjv/0SW3uFOygqcX59I4PJF5qe1eyGPwcF/W59+sRaWGyFff2BO
         /phyNeLaPqd9ngZtQCd4M4IrqWuafhOL1Hw5HqmgKsOyKS1m0Oy03FkFp9ATv5ubeHW0
         vfHDStwDHB8WKn+kMD7nI74npZ8RtFs+J8kmE38adpD+CLmBuJcunh3Lh/O4As79B9gj
         gVYHxiZvIlLuSzxyc+IaR2xBIvPOMB3C/0reln/Me50MAtrglapK8qCNNLf/5Lx+r5Tj
         BaNWmW+PNui4AxhVjjcuoTLXUgSXfXsNMXd6Byvic3PsBx0UovZLqrmtPfFNiCOrYa4W
         +kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lnUEUaSXlrXEd8hhr8zpTdMe63aPIrW9VGr/CwVY2j4=;
        b=bsy96enXqYAOGLqPhQBGEjpPlSPk7i56PSxd5Y3/ZMndriqxip7/1LcH5c/5OXiOya
         ueC7t6jQTjI6/5jb8yaLNTuT6jUozvZxRGwJqHRgkexBUgR9U+9JGvdZuHcaby4+rAwG
         gJvz0rCo9yS0mO0WKsMRRN9XaOxre4mzMOJ/SBWYCF0HFMQL+x0URDGR1PCoXt7XPNul
         zzy8m6DdOsYPsKNXMDCS2czYgKL1Sfz+iP8jbhUrWZNyuGaCWxRGXwOQQIY1JvVj3m8j
         UJeOthMuLTkSzGaXM8Ukc+Y4z8FzPLXdxGbeuPvPVjZuL2mCBSz0cRn9YH0uBw14HwjA
         +jbw==
X-Gm-Message-State: AD7BkJJHbk78rFRhjdI5Pcvvwtj3g/0uBtJaws9wRaX95jmjDS6Lap4iLVdAmsDazBP+gEZUBSW7a4U8y8Fomg==
X-Received: by 10.129.155.81 with SMTP id s78mr2244556ywg.24.1458760999867;
 Wed, 23 Mar 2016 12:23:19 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 23 Mar 2016 12:23:19 -0700 (PDT)
In-Reply-To: <xmqq7fgtc88i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289678>

On Thu, Mar 24, 2016 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> On Sun, Mar 20, 2016 at 11:04 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> ...
>>> Alternatively, combine #1 and #2 into a single patch which drops the
>>> global test_set_editor() and, as an aside, also does "while here,
>>> let's use write_script() to create 'check-for'diff' rather than doing
>>> so manually".
>>
>> These changes seem nice. I will update and send the patch.
>
> So, has anything happened to this topic or has it been abandoned?
>
> I am not in a hurry, just wanted to see if I need to keep the old
> one in my tree as a reminder to myself.

Sorry for that! Actually I am bit caught up with writing my proposal
for GSoC 2016. I would be able to complete that in around an hour.
Then will work on this. Then on the shell function -> C function
porting patch. Please bear with me for a little while.
