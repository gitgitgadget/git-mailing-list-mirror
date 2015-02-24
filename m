From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 16:46:46 +0700
Message-ID: <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com>
 <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com>
 <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com> <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Guilherme <guibufolo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQC5N-0003rK-Kn
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 10:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbbBXJrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 04:47:20 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:38761 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbBXJrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 04:47:18 -0500
Received: by iecrd18 with SMTP id rd18so30610776iec.5
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 01:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+ceMvEp5UK+4DOXpWSiVBiAmSWYJuZBrjG7GjmFuJS4=;
        b=1ELWijGK55Z/tpMmpxni/B9by30q+MSruOKohxH//cIcTPkP4yESO5Rijs13JWuEGb
         NLf6wXGlKZoCrRzybUYVe4Sby5VxNKA7zGlh/G5MXtXJUAqmxg7DcT3FI1BgRqp2TcuJ
         OAK+l9Zy76wB5gNspKRr4Atw5/ilsu9vN86mYthGia8CYI50jXFrF3PSmOumLLFVJ8+N
         rRTUhx5yRF6+VfScOnYX22ELQAcxmvMQHzbr3lwi6PZc5+33wAPrrkqEiNWo+vS896iz
         G/1omTeIQSV2DDr1VzQCFOnBZgZoY3FQNCYr/7ynR2sd/ukYmrIwhxc6uVxMk7bmaDSi
         H8+A==
X-Received: by 10.50.222.70 with SMTP id qk6mr18578208igc.47.1424771237883;
 Tue, 24 Feb 2015 01:47:17 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Tue, 24 Feb 2015 01:46:46 -0800 (PST)
In-Reply-To: <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264318>

On Tue, Feb 24, 2015 at 4:29 PM, Guilherme <guibufolo@gmail.com> wrote:
> That discussion seems to have just died off.
>
> Whom should i write to about making the license change effective? You
> (Duy Nguyen) seemed to be fine with the license change. Can you, or
> anyone else, further guide me on the process on making sure i can use
> the file(s) in TSS?

I'm not a lawyer, but I think after you double check

 - what Jonathan Neider wrote about GPLv3 and Apache2 is true
 - perhaps check with Anthony Ramine, who is the only person besides
me that has made changes in wildmatch.c, in b79c0c3 (wildmatch:
properly fold case everywhere - 2013-05-30)

then wildmatch.c is good for reuse. You probably need to check with
other people who made changes in hex.c and git-compat-util.h.
git-shortlog and git-blame could be used to get the email list of
these people. But maybe it's just easier to rewrite those, hex.c is
not big and I suspect you don't need much of git-compat-util.h.
-- 
Duy
