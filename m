From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv2 27/56] string-list: Add API to remove an item from an
 unsorted list
Date: Fri, 12 Aug 2011 16:14:34 -0600
Message-ID: <CABPp-BFsqDhVnxDa9u3tV0yZky_az0MTCT_N5y+Oqm84+fOyvQ@mail.gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
	<1313126429-17368-28-git-send-email-newren@gmail.com>
	<4E44CF9D.8030501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jim Foucar <jgfouca@sandia.gov>, Johannes Sixt <j6t@kdbg.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Aug 13 00:14:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qs00E-0004Yz-CY
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 00:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab1HLWOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 18:14:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43349 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1HLWOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 18:14:35 -0400
Received: by fxh19 with SMTP id 19so2574725fxh.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bIm02oXuHQ/nDc2Xp86waeDLUiqcug4WN17BTD44Abs=;
        b=gAviBc7gZ6LZdrmugVBR67rnjz39Kq6tTBAPfn+lToXYmu+hqaE6MMSdc9s1sOghvE
         kkOhFPQ4+6qHUM23mOHg48bitz8LVaCNG27Ys+dmXmRRMbt4aINDYd6PCEkue4lb5zf7
         6/kRHtEywWB6BPQNlX6KeCjrHHXPQp4j9acIw=
Received: by 10.223.38.151 with SMTP id b23mr1908010fae.35.1313187274447; Fri,
 12 Aug 2011 15:14:34 -0700 (PDT)
Received: by 10.223.134.84 with HTTP; Fri, 12 Aug 2011 15:14:34 -0700 (PDT)
In-Reply-To: <4E44CF9D.8030501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179257>

On Fri, Aug 12, 2011 at 1:00 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/12/2011 7:20, schrieb Elijah Newren:
>> Here's an attempt for a delete_item API (note: only compile-tested).
>
> Seriously? You haven't even tested this patch, and still don't mark it
> with RFC?
>
>> Bike-shed painters welcome: delete_item, remove_item, free_item?
>
> You should know that a sentence like this shouldn't appear in the commit
> message.
>
> Yeah, I know, you just copy-pasted my email text. But that was not a
> commit message. Perhaps like this:

You are right.  I apologize; I messed up here.

However, I am unclear what you mean by not even testing the patch,
though.  I couldn't find any unit-test harness or any other kind of
testsuite for the string_list API.  I did review the code to make sure
it looked right to me, added a use of your new function, and ran the
standard testsuite in addition to my "re-merge all merges from
git.git" testcase.  I even single stepped through the code in a
debugger for good measure.  What testing did you want to see in
particular?
