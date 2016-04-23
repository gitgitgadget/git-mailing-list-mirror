From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: GSoC Project Selected | Incremental Rewrite of git bisect
Date: Sun, 24 Apr 2016 01:40:27 +0530
Message-ID: <CAFZEwPMr=imv==kvVULy4PDYKW-0RRQ5a+X8DFqNFhNjCSyWKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:10:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1au3t8-0007hO-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 22:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbcDWUKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Apr 2016 16:10:32 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33541 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcDWUK2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2016 16:10:28 -0400
Received: by mail-yw0-f195.google.com with SMTP id o63so20004215ywe.0
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=6jZAC9EUERt0w7sSwMiV8IC/LDU7udgp0jfnStuA/TA=;
        b=zRBHyLc4JYH9GUD4H8HXsjTvkbSnIda8AApZAyQeH+olfrY3L/atxnBw7gvT7FobnP
         DzLLKZ4axJD+An7Ud8Ed6s3bGtZdONdonD8foce4CQBYBd+tkF+HIyD4shYSRtUXIaKQ
         QWqZW4PsW/5RfwPwEoOVUC3qGQL5vJ/niuLwXgvsqxLI9hUDmjFCKkNwm+QRGGfvSD3I
         yOYDAnJAk/afoWBYwBzTA9vuYg1HTPWj0hI1EnB+6A8Bj8tGRyjqATknvBRptZczGqdU
         9NKMwqr+WJwK+FtsGZj7klDiavh1UoZ1o59hWmm/DbjqIKSLnyMtpbyoXsXTVLT1mfqB
         6/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=6jZAC9EUERt0w7sSwMiV8IC/LDU7udgp0jfnStuA/TA=;
        b=gtG/HMpM+z+i52MEmY8F77CYHfFrmLIAjugjcNphi5VhfpqgfrsxplIkHHGIgGDpMy
         GYQiwwBeBd8Bg/0YqNQoNQNTaSjUWtK6JAV+LV8aPVvpv2fGtrK1kH/8tAEHOWpP2W2y
         urVbzk+RECqJ01hMtwH5beync35zl8JKAc2FfB1LofsOJvO5BIJfk04Y8m50WnW+UoXZ
         8Af+JSQuM5EfGeS82mYpXIPY3ZNgm1IerqnqMNfrmDE3hGsLfqnlAtgB6QCSYjH/aj8s
         MlINaZiiH6EB6e4uHn6vVWxCv6HHNXRUTSnHzmSceduQzgQm1PRCreSnqyKcukCgtslu
         NfSA==
X-Gm-Message-State: AOPr4FXBLOVY+p7N0fmAfliHcmFxqWo9c3YJMH3b9llNSL1DHxVxMvz6/QnqOmsFmgsWEuUoapwRthTW88uriQ==
X-Received: by 10.13.221.212 with SMTP id g203mr8817606ywe.68.1461442227412;
 Sat, 23 Apr 2016 13:10:27 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sat, 23 Apr 2016 13:10:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292308>

Hey everyone,

I am Pranit Bauva studying Mining Engineering at Indian Institute of
Technology, Kharagpur. I have applied for Google Summer of Code 2016
under Git organization and my project[1], "Incremental Rewrite of git
bisect has been selected under the guidance of mentors namely
Christian Couder and Lars Schneider.

Overview of the project:

Git bisect is a frequently used command which helps the developers in
finding the commit which introduced the regression. Some part of it is
written in shell script. I intend to convert it to portable C code
thus making them builtins. This will increase Git=E2=80=99s portability=
=2E


A word of thanks:

=46irstly I would really like to thank everyone who was involved in
planning GSoC for Git especially my mentors. Also thanking Eric
Sunshine, SZEDER and Junio for patiently reviewing my micro-project
and helping me through that. It was a really great experience. I had
previously no clue about git bisect and have never used it mainly
because I was never involved with maintaining big projects. Posting my
idea to the mailing list (which initially contained a lot of mistakes)
was extremely helpful. Thanks to Christian Couder, Matthieu Moy,
Johannes Schindelin and Stefan Beller for providing useful comments.
Experimenting by converting one function really helped me a lot to
write the proposal. Thanks Roberto for making submitgit.

The subtle hints dropped were the most helpful. Thanks for explaining
those when I could not pick up those hints in the first time.

Status of Micro-project:
I had finalized v14[1] but recently Junio pointed out that the series
requires ordering and restructuring so I will finish with that. I have
my end semester exams going on so I will try to squeeze out some time
in between and try to work on the patches.

Status of the function conversion:
I had attempted to port a function 'check_term_format' from shell to
C. The last version was v3[2]. In the newer version (there only exist
a local copy as I have neither sent it in the mailing list nor I have
pushed it on github) as one test is not exiting properly. The code
written with confusing error handling and return statements which were
mainly there to help me understand "What's happening and where is it
happening?" As requested by Christian, I will still push these changes
to my github fork[3]. Also the function I have written does not use
the API of git as at that time I wasn't quite familiar with it. I am
still not completely familiar with it but I guess that will take some
time.

Status of learning about git plumbing commands:
I have learned about:
 - git-check-ref-format
 - git-rev-list
 - git-rev-parse

The one's left are:
 - git-symbolic-refs
 - git-show-branch
 - git-update-ref
 - git-for-each-ref

Status of Week 1 of my proposal:
In my 1st week I was going to set up kcov to test the coverage of
shell scripts as gcov does not cover them. kcov is a lot trickier than
gcov which I hadn't realized it before. I tried to use it in a simple
way but it just wasn't possible for me. So I dug further and found a
patch[5] submitted by Dmitry Vyukov. The linux kernel recently started
using kcov for their coverage and to also find bugs by using some
fuzzy logic. Setting this up is well not a piece of cake at least for
me. I tried reading his patch and wasn't quite able to digest it in
the first read but then I didn't look into that further. I would
really like if someone could look this up and recommend whether I
should try and implement this or not in the first week. If let's say I
try to implement it, then I probably think it is more than a week's
job. I recollect Matthieu saying that Paul Tan had used this before.
Could you please explain how he achieved this?

When will I officially start working?
My end semester exams end on 29th April, 2016 and I will reach my home
on 1st May, 2016. I will officially start working from 2nd May, 2016
and will complete reading up on plumbing commands and other API parts
which seems a bit ambitious as for now.

Other remarks:
 - I can now finally use git-send-email when I reach home.
 - I will regularly (weekly) keep posting my progress on my blog[6]
which will be revived  as it has been a bit stale for some time now. I
will also send the text-only version to the mailing list as requested
by Christian.
 - The more I dived in, the more it started to realize that my time
line needs some restructuring which I guess can be determined by the
above paragraphs.
 - I will also work out on a time line and post it on my blog[6] and
send it to mentors.

[1]: https://docs.google.com/document/d/1stnDPA5Hs3u0a8sqoWZicTFpCz1wHP=
9bkifcKY13Ocw/edit?usp=3Dsharing

[2]: http://thread.gmane.org/gmane.comp.version-control.git/291311

[3]: http://thread.gmane.org/gmane.comp.version-control.git/289599

[4]: https://github.com/pranitbauva1997/git

[5]: http://thread.gmane.org/gmane.linux.kernel/2126762

[6]: http://bauva.in
