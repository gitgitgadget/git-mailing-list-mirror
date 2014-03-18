From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: [GSoC14][RFC] Is there any interest in adding a port of
 checkpatch.pl to contrib/?
Date: Wed, 19 Mar 2014 00:53:03 +0100
Message-ID: <CAL0uuq3Rgp-7tvqOnN1PX_ZhK3M529MGQB3jcMRMPOTY2JdUng@mail.gmail.com>
References: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
	<xmqqeh1z8fv8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 00:53:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ3oj-0001kM-RU
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 00:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682AbaCRXxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 19:53:05 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:45582 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757305AbaCRXxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 19:53:03 -0400
Received: by mail-vc0-f180.google.com with SMTP id lf12so8345308vcb.11
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oHH2gRiigJOxTmEDDyQ44U0RwPiKDH94w9ju/UyvCtw=;
        b=IevYWZPVaRbnEitpISHvKddLuTQCCW7mINwDW5aDr8o2NBd3BGmtbDaALPGVBn3c6R
         BWfMdG9c6s1wLLHin98gIMHi4Ien0ef8e1zJCFiK0PqtriqkRMxeAaGW3yD/tfsz2SWT
         L6lTi1jUb6a1RiOTQtD2KLhTOfLTFCtlm1iH9g3YHOXIe9EMpyRHI8iiPATDY91JJBGn
         +KopPjXVZLLMBa/pTvr/FCL3mNsvtULWrS+bjXyRtKGFd8NcFZ2Y8Wps4mLyl2syznNE
         P15TrEf/8mVsfArexINOltb+h2E4C5gOSb2SKIBcGCUZZ7ghbiLy60GFliivgFoKVoXy
         OY5w==
X-Received: by 10.58.238.35 with SMTP id vh3mr26952549vec.16.1395186783181;
 Tue, 18 Mar 2014 16:53:03 -0700 (PDT)
Received: by 10.52.2.165 with HTTP; Tue, 18 Mar 2014 16:53:03 -0700 (PDT)
In-Reply-To: <xmqqeh1z8fv8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244398>

On Tue, Mar 18, 2014 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I've never said any such thing.
>
> I only said I am not enthused against a proposal to add a build
> target that runs checkpatch or equivalent over *all* existing code,
> which will invite needless churn (read again the part of the message
> you quoted before I say "I am not enthused").
>
> It is a totally separate issue for submitters to make sure they do
> not introduce *new* problems, and use of "checkpatch --no-tree"
> could be one way to do so.
>

Sorry for misrepresenting your opinion. My summarization algorithm
sometimes is _very_ lossy :)
