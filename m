From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git super slow on Windows 7
Date: Wed, 25 Nov 2015 21:23:46 +0100
Message-ID: <CACsJy8Becrc57+56BCLSq8Pd9p5m2qpERqXwY2AN21H=BfADNA@mail.gmail.com>
References: <EEA07A84-26D8-4709-97AC-2C4F3A0CC5BD@gmail.com>
 <0B47434E-00FE-463A-95F1-1F10537C9F7A@gmail.com> <CAGZ79kZQd4JrQsp6sk8x-OAWMxxbF+a8BXZb1VQSdJeiQ8jhuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>,
	stephan.arens@autodesk.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:24:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gbz-0002ad-AW
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbbKYUYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:24:18 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35322 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbKYUYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:24:17 -0500
Received: by lfdl133 with SMTP id l133so73995522lfd.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cGaFxxvor/TVq4CH0NTIH/y76KW50D3XS/82v15f9tA=;
        b=jwyZPD2t7W4okQO2Y9hwc2E9BWbqY4Bx5yEajxUk+rrYdjk9wVAxy13GeJnOHNxoUX
         r0IQionc0xUvtNPAZYTnTfGY2UKblhK89DzShcX6IO05yK3lkuOiOEgnlv0d5EPlaNRs
         aeoa1V2U2ZvRdTW2D6g/q3CQ7U9LzP6EH8LUg8Yq1ISVRUwjvjgH0fnzDRbGiXrT7LR9
         s6ljZGjdLNby3opuznAhMeEv55whVYeiuZe8Jz448ZKH8+uLfTP6ZaMLzZ0GRRaS9Bna
         5Eq9Obone7+EP5ejlRDdpxIx9LN6vwQzNi6YR3zycPWYlpscr9Yh3nBk1OY57e8Ksy8N
         fu4g==
X-Received: by 10.112.202.168 with SMTP id kj8mr15948554lbc.12.1448483055748;
 Wed, 25 Nov 2015 12:24:15 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 25 Nov 2015 12:23:46 -0800 (PST)
In-Reply-To: <CAGZ79kZQd4JrQsp6sk8x-OAWMxxbF+a8BXZb1VQSdJeiQ8jhuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281739>

On Wed, Nov 25, 2015 at 7:47 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Nov 25, 2015 at 10:42 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> After some investigation I figured that ~50 Submodules are the culprit.
>> Does anyone have an idea how to speed up Git on Windows while keeping 50 Submodules?
>>
>> Thanks,
>> Lars
>>
>>
>
> Use the latest version of Git ;)

Does it do parallel refresh yet? I think it would help.  I only looked
at "git log --merges origin/pu" and nothing caught my eyes.
-- 
Duy
