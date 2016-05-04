From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 14:41:32 +0200
Message-ID: <CAP8UFD0QeZqLaPwFe5wo0n1fdtSppJmYdUDc+Yo1duH1uyWbpw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
	<CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
	<alpine.DEB.2.20.1605041304050.9313@virtualbox>
	<CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com>
	<alpine.DEB.2.20.1605041416030.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 14:41:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axw7X-0006ty-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 14:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbcEDMlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 08:41:35 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37277 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbcEDMle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 08:41:34 -0400
Received: by mail-wm0-f54.google.com with SMTP id a17so91905568wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oGLrd3H6CQaCF6lkwPRY6wh3BSmDV23GX+ZgJCdfRaY=;
        b=sHDTyIkUH4tgKJhS99k1lUIi93FqSus/IcdcMQVC8WYYXSsbBCUF8sPlYUlXjQYgWu
         ZdWSs2s0BNVEzMdAx+Fmkz0lvjH6Ts6ddO0FMPSLHCXXs8laBJicTSJNSnvUkY9RwfYu
         oorgLwhSa4EbfuFlXt/Y6FJbkMZQaLOqzf2OPevbnHTQyG/S2hrBOaJTO/hxZ1EkGQJh
         BZUIsYIVL/qsko6tsVeiSLWyB8et7M/zDobfrMzQ0Utg3FClstMFHL5coHzkvv2tShwf
         LTpoJ/XIoyc/2z9385I9dpxiv/MK/WbHpvxvqpEkJjsBNhsI6yXROs+cN/gKo0ibPm8V
         r2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oGLrd3H6CQaCF6lkwPRY6wh3BSmDV23GX+ZgJCdfRaY=;
        b=ddNDh5HdaMc1IHDSb2lvHdH+zNwmfWOoHl+goctqyaN9aiJ0eIQ3iU3HnfD21PPI0h
         MA5RDof4FZ/v1Wlg36JatAYM5xuPVNXKdupJ6ScglbZyVreIiBaMEuxZpXkis8lGTJOz
         nmDDCyaTpxRXC/t+8AdVju+uy6MMSLD3KTyNfK8GQofXNZWEyODXKrpKFpkaQ3YmauFJ
         PBTD6H2fcTzHWX+svShtpmXNby5R9+H7AguGRcJUqIzNVmPzFYIjBH4sEdsVoFPg58+8
         8T+VTLQofwCJereg+IgSdv3bb7QxDP1Khu7gm5PXGyAve1t4NY3YugkKxuwSpgUMCBTo
         m0Og==
X-Gm-Message-State: AOPr4FU2u4jBtrhps3BXSsHzAfmLVSngGQ9B67S2KSPW5HXdutz1HITWEIjSs3afMsTdVwwh6F381/FDCNCNUw==
X-Received: by 10.195.17.166 with SMTP id gf6mr8362930wjd.124.1462365693083;
 Wed, 04 May 2016 05:41:33 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 05:41:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605041416030.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293548>

Hi Dscho,

On Wed, May 4, 2016 at 2:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If your patch series contained *one* patch whose intent was to prepare for
> a libified 'apply', yes, indeed, I would think that it would make for a
> fine commit subject. Especially if the other patches tried to do
> completely unrelated things. Then your "low-level" change would really
> benefit from a "high-level" commit message: the "low-level" aspect is seen
> easily enough in the patch itself, thankyouverymuch.

One can also say that if the long term intent is described in the
commit message and if the commit message is already "high level", then
a "high level" subject on top of it doesn't provide any more benefit.
A "high level" subject on top can just make it harder to relate the
patch, when you only see its subject, to what it contains.

> It really misrepresents my comment to pretend that I had tried to
> suggest something as utterly confusing as identically repeated commit
> subjects.

Sorry but that was not my intent to suggest that. My intent was to try
to show that there is some important value to make the subject close
to the "low level" thing the patch actually does.

Thanks,
Christian.
