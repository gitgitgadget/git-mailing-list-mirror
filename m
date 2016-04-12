From: Stefan Beller <sbeller@google.com>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 07:52:02 -0700
Message-ID: <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com
X-From: git-owner@vger.kernel.org Tue Apr 12 16:52:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apzfm-0005qC-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 16:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbcDLOwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 10:52:06 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35508 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932643AbcDLOwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 10:52:04 -0400
Received: by mail-ig0-f176.google.com with SMTP id gy3so89806727igb.0
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PriMltC8bQKYh9JYbnOiOzEYBhXTmwQELwX/kcGX8N0=;
        b=S20WQwGVhsYYrFH4MrKMJGbJrYx6ry98Dbsqs2kE3Df1+j5jv33sqI2G1awkzYK94U
         6tKxE0zJlkAGJ5becgowEY5Hnf4fClcH6H6Zd8no/C6X16qLfsoT6ui/evCWEVZDtQbc
         ila6vVumGwL8b3wD8mSMeHLx2APSnyHPsHN7FFq/sBnxnhxYPz/F4aT1gajLU2Cy6Xoi
         VAjW6MXXHMIOK4IgTke2LSGTSl1sruvWkEcgPDFwqahR8Mz3sMRg7AEfq2FPzWFTPpTP
         ClVkidY7cBAPDt6eXvTQi/fTrW+JLgzhbCvaFpVBwrBlNcnwBXPbSMjS2tOeRdxxNYPh
         q80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PriMltC8bQKYh9JYbnOiOzEYBhXTmwQELwX/kcGX8N0=;
        b=lEpA91E6nFNndnCF8ymTVuggjCmDjghPRBQyjGpixpzTbOUAH9GblyZen9HbBm1OaO
         sLFrtEGz5r12I9hmFy4UDuQIoCHXEWlp8RVqzX45qrO2A9hmQEWO1/L44j5tc3qyMQaw
         AKJ27BbERCvm5ImLkUEG+8DErty3EcaChvBKrNvh7YjuQctf8XGBZcFfDdTgAzHacSBr
         +PatIyxgYQdzRHUHEFKH6siLShKLfTpeMadG2f97KCUR+kQyRhAM59vvCM/x0VRQpttm
         u93k+XiMwRRhQ82m65I1jClFp4nDrWF+J+SMglnIQQPpEud9T/DUAq4zLI3pdaD1olyl
         0Cmw==
X-Gm-Message-State: AD7BkJLMam4L5N0OQa6/fgDLuXmQQTLPmiS34S7eOpwvU8QcxTyFclRX5BUcLX/oXJpB7Qkp8jpfWJZTdIlJen6o
X-Received: by 10.50.23.80 with SMTP id k16mr26104685igf.94.1460472722608;
 Tue, 12 Apr 2016 07:52:02 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 12 Apr 2016 07:52:02 -0700 (PDT)
In-Reply-To: <vpq60vnl28b.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291264>

On Tue, Apr 12, 2016 at 12:23 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Hi Greg,
>>
>> Thanks for your talk at the Git Merge 2016!
>> The Git community uses the same workflow as the kernel. So we may be
>> interested in the 0 bot which could compile and test each patch on the list.
>
> In the case of Git, we already have Travis-CI that can do rather
> thorough testing automatically (run the complete testsuite on a clean
> machine for several configurations). You get the benefit from it only if
> you use GitHub pull-requests today.

But who uses that? (Not a lot of old-timers here, that's for sure)

> It would be interesting to have a
> bot watch the list, apply patches and push to a travis-enabled fork of
> git.git on GitHub to get the same benefit when posting emails directly
> to the list.

That is better (and probably more work) than what I had in mind.
IIUC the 0 bot can grab a patch from a mailing list and apply it to a
base (either the real base as encoded in the patch or a best guess)
and then run "make".

At least that's how I understand the kernel setup. So my naive thought
is that the 0 bot maintainer "only" needs to add another mailing list
to the watch list of the 0 bot?

Stefan

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
