From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 05:57:56 -0500
Message-ID: <536cb4b4cda1e_6b2dde730827@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch>
 <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
 <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
 <CABPQNSay4gDJ2Ea-w0=wnU1oqVZ_ATm1Q_M71zt+rAd1XUr0zg@mail.gmail.com>
 <536ca0a0f38af_39ea14ab31017@nysa.notmuch>
 <CABPQNSYJabLU5+9ODMWswu_7R_LRno9oEM=NyC6vhZ--tatb+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 12:58:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiiVE-0002c0-7h
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 12:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbaEIK6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 06:58:03 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:64646 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbaEIK6B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 06:58:01 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so4663850oag.13
        for <git@vger.kernel.org>; Fri, 09 May 2014 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=jmhPqX2M5UkX7olUMnCbezS4fele5hWdGzxuCPR9B0k=;
        b=M35d7EUWrIM2jFxlfMawDgoAH9RM3joM3QMRRy8/Es4AoP9icIzQCnTiUOGQwSaUiw
         c6/YQrwcnmxYj4UzegVLNcLzZly0WIuJIbG7JN8YJZnSzCFfQSVDnc3WFPlLp3G8cpkk
         rK3HNn1bxyspH+MMicacWLrDyzKU4l/25tHNI/z1XOW1pKY3U/5DsaEBIk8NNrcK0fbp
         tjvtQRFeUdgbOLi6ECecejaxHVYsAQ3gZUGtUxYwbDYOBpY55Q7mezr9Z+wO5PH4CPR4
         uz1yM/uQCHfMDL8hlwN8MZKV0MkFF98YPJUJ9EUxkzUsdLwPmm+Ss4S4b0ZlzQj6Z0Fk
         /Oqg==
X-Received: by 10.60.69.71 with SMTP id c7mr2400184oeu.82.1399633081138;
        Fri, 09 May 2014 03:58:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ub1sm15038378oeb.9.2014.05.09.03.57.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 03:58:00 -0700 (PDT)
In-Reply-To: <CABPQNSYJabLU5+9ODMWswu_7R_LRno9oEM=NyC6vhZ--tatb+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248550>

Erik Faye-Lund wrote:
> On Fri, May 9, 2014 at 11:32 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Erik Faye-Lund wrote:
> >> On Fri, May 9, 2014 at 10:48 AM, Felipe Contreras
> >> > You think changing the execution bit of a file is considered "activity"?
> >>
> >> Well, now we're getting into semantics, which I don't care so much
> >> about.
> >
> > Convenient.
> 
> Yeah, the part above here goes in my "don't argue with idiots, they'll
> drag you down to their level and beat you with experience"-filter.
> Good luck trying to convince *anyone* with this line of argumentation.

It has been demonstrated that there is inactivity. The fact that your
semantics about "inactivity" differ from the rest of the world is
irrelevant.

> >> It shows some sort of interest in the scripts, at least.
> >
> > Not it doesn't. Jonathan Nieder updated the execution bit on a bunch of
> > scripts in contrib, these being just in the way. It doesn't show
> > interest at all.
> >
> 
> All of those changes relate to the MSVC-build. So it's not "just some
> batch-fixup" as you're trying to suggest.

It is a huge batch-fixup[1]. In fact he mentioned he tested it on
Debian, not Windows.

> > If you don't care that these scripts keep working properly, I don't see
> > why anybody else would.
> 
> You're the one making up requirements for tests here, so this is your
> itch. This script gets fixed by it's stake-holders when it breaks, and
> that has worked out fine so far.

You are not interested in improving the quality of these scripts. Got
it.

> > The script doesn't depend on the version of the Makefile, and proof of
> > that is that is has *never* been changed even though the Makefile has.
> 
> Except it has, in 74cf9bd.

Once change in *four* years. My god! How are people ever going to keep
up with such amount of changes if it moves out-of-tree!

[1] http://article.gmane.org/gmane.comp.version-control.git/238347

-- 
Felipe Contreras
