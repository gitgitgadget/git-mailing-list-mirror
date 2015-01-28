From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-push.txt: document the behavior of --repo
Date: Wed, 28 Jan 2015 15:30:18 -0500
Message-ID: <CAPig+cR-45NzCK5mu9d=1o8nss54ShYn1Snexx5rT+En8XeMcA@mail.gmail.com>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
	<d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
	<CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
	<xmqqfvauhdfi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>, Prem <prem.muthedath@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZFw-0007u5-GR
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbbA1UaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:30:24 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:56176 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225AbbA1UaT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:30:19 -0500
Received: by mail-yk0-f173.google.com with SMTP id 142so10006801ykq.4
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 12:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RMbBgFjj0aXJ9qz+jOEc4KEBreu8D825AOJD3BD8c74=;
        b=RdjErA61bZCecpTpj8cfNmS4khqtzVI+XpKpx0BBhtFT2KvtdmVPNmt8v6Zx8FLLZA
         08e7JWBdP2hEoEOqtjheZ5X9mw/caCbWx6NOvrcx0nNj+H2JzowzMFNWNOjYtXc1NSOV
         GLCaxYyBHFBITKnDHMRrHfS74UXxvdC6eS4bfh3p6RfCyjyOsx09i20D791OXVbJ4nwn
         JpV6cfOh9oV19E1ZqPVVIqVwgEYee1Q/TiQSydou34j3w33sibDLIxz9dwi9KE7Y+GkQ
         wmZf6/7sQ6ybx3wcSy9+C+23BKqBIXVvBA6yvNTzcsrEltIJSjEwOlUSZ6dbopY+/mh7
         FtRw==
X-Received: by 10.170.83.11 with SMTP id z11mr2157093ykz.91.1422477018305;
 Wed, 28 Jan 2015 12:30:18 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 28 Jan 2015 12:30:18 -0800 (PST)
In-Reply-To: <xmqqfvauhdfi.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: GYf4u-9sn3Dct4F01lCzsj7EVzI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263110>

On Wed, Jan 28, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +       This option is equivalent to the <repository> argument; the latter
>>> +       wins if both are specified.
>>
>> To what does "latter" refer in this case? (I presume it means the
>> standalone <repository> argument, though the text feels ambiguous.)
>>
>> Also, both the standalone argument and the right-hand-side of --repo=
>> are spelled "<repository>", so there may be potential for confusion
>> when talking about <repository> (despite the subsequent "argument").
>> Perhaps qualifying it as "_standalone_ <repository> argument" might
>> help.
>
> I didn't find that "latter" too hard to understand (I admit that my
> reading stuttered there, though).
>
> I do not think saying "standalone <repository> argument" there would
> help very much, because there is no mention of "standalone" around
> there.  The earlier part of the sentence mentions "option" and
> "argument", so "the repository specified as an argument is used if
> both this option and an argument are given" or something?

Yes, that addresses the two (minor) ambiguities and sounds fine.
Thinking about it afterward, I came up with this:

    This option is equivalent to the <repository> argument. If both
    are specified, the command-line argument takes precedence.
