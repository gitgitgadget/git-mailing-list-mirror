From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 14:25:56 +0100
Message-ID: <CAP8UFD2A_u5HeHYLn68nP=j1+68jtGwcU8je=E-nR9OgzHSmXA@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 14:26:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahdNG-0005mN-HV
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 14:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbcCTNZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 09:25:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35179 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbcCTNZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 09:25:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id r129so4070856wmr.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ECd9r+R8Ezu0i65dNi+uoT0Xck7G+xMlWAwYY9Pvc0E=;
        b=aZESqYjaBE6ZD1jWOI9l+reyO30b7xTqKEMUSaMhGowqNRO9eMm1Lcfh0Zz+IezkTJ
         861B+JOScOVjFKV4dVBdUUexW7uJCYQuyxDpvLmoYgQFapz7TZyvdCD6oYvHZbH6SmFo
         pp9P5B5lazQr97Pnlna5S+lNHNQjmtoh0PVa31MNH24fR06jNEh+Ng7NGzxFprfEFca2
         7ehWqoE87iUSuTlhpfFO7NgSTV20YxgEChqtj9WbTRvm/Cc4Hqbi129iu6LaqNP0mxn1
         2M/y5R89GxNtm3hAp5MFJmdaOOkX83YlgyLIFNz9A6nwFThspfQSljQwhl5/yYmI3di4
         myWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ECd9r+R8Ezu0i65dNi+uoT0Xck7G+xMlWAwYY9Pvc0E=;
        b=HTpqw4/6v+9FEy1DCLfS6U/OygyBKmylDtc9j32xptYBQoeuB+kpKw/SAx+cIOvZeo
         ujvlpipcFau2+na4Xt4TaZ4sTlkckwyEssew2AmzMMvKifYNwjiAYDmYbcFTp73dwK6/
         Wh4GyusRuDVDDh+3iis2IxI115PXWzep5sD6Qfhntjy1qcz+LYXY0cOpWy/0coWC/W08
         QC+GMbkIRr90MNNrz5k7QMjW3RyRpcr0X9iJ7+RHoFlvfW5AomF0UdGp/2dfwTwbKbXb
         ZOBoLWAEdl9hbyRpuEC8J1JZF/VFATzonwxGRpfrOyVAF+qRWVpWTmTPvfzjN+ZCOqWq
         NapA==
X-Gm-Message-State: AD7BkJK+d3zKMy2o6W6JT/IOYZW44iAf8AKICEApqanz6XcXiGAggc35Alc2aE1lJkfJBzPwNt5U1a81OHcwtQ==
X-Received: by 10.194.2.202 with SMTP id 10mr27743640wjw.94.1458480356659;
 Sun, 20 Mar 2016 06:25:56 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Sun, 20 Mar 2016 06:25:56 -0700 (PDT)
In-Reply-To: <CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289351>

On Sun, Mar 20, 2016 at 12:35 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> The project Idea: Incremental Rewrite from shell to C of git-bisect.sh
>
> The plan:
>
>  - Place bisect.c in builtin/
>  - Implement a skeletal cmd_bisect() which will redirect to
> git-bisect.sh (1e1ea69f)
>  - Introduce a structure for parsing the command line flags.
>  - Start converting individual functions and place it in bisect.c

I sent the following PR 8 days ago to add something about this idea on
the SoC Idea page, but unfortunately it has been merged only
yesterday:

https://github.com/git/git.github.io/pull/135

Also a plan like the one I outline in this PR has been discussed on
the list at least a few times.

As for working on --first-parent and generally speaking any project,
it is a very good idea to first search the mailing list (using for
example http://dir.gmane.org/gmane.comp.version-control.git/) to see
if the idea has already been discussed and to link to the previous
discussions in the proposal.

For example you could have found this (from a few weeks ago):

http://article.gmane.org/gmane.comp.version-control.git/286496/match=move+bisect+c

> The major objective would be to replicate function behavior rather
> than its actual implementation because what might seem to be a good
> choice in bash would not be a good choice in C and vice versa. For eg.
> bisect_skip() externally calls the command `git rev-list HEAD` to get
> a list of commits and then store the standard output in an array as
> bash can directly do the conversion, but it would not be a good thing
> to do in C. This might involve a very different approach to the
> existing code. To take care of this part, I will extensively debug
> git-bisect.sh and the other files it depends on ie. rev-list.c,
> rev-parse.c, for-each-ref.c, list_objects.c and bisect.c to study
> their behavior.

"builtin/bisect--helper.c" is missing from the list.

> I will spend some time in testing the functions for
> corner cases and running the ready-made tests to investigate its
> behavior. The goal would be to produce quality code that can be
> included in the next maintenance release 2.7.5.

Developments like porting commands from shell to C are very unlikely
to be merged in maintenance releases.

> I will try to
> extensively review the patches myself first and then add it on the
> mailing list. I intend to discuss the whole structure of bisect.c
> based on my observations in the first week. Then accordingly send
> individual patches for each method. Also I am quite unsure how the
> patches would be maintained by Junio. Would he create a separate
> branch for me in his personal repo and then add the patches to it
> without merging it to pu and then when it is completely done, the
> merge will take place? Or he will individually first place every patch
> in pu and the normal process?

I don't think it's worth worrying about that at this point in a proposal.
(And you could just look at what happened during the previous GSoC to
get a good idea about what happens.)

> Functions I intend to cover (This is from a first-read, I haven't
> actually debugged it. It might miss some technicalities or deviate
> from actual) :

...

I don't think such a list is very useful. At this point please focus
on the big picture, that is what you call "The plan" above.

> Should I also include "How git bisect works internally?" in the
> proposal along with this?

Yeah, I think it would help. But just show the big picture, not too
many details.
For example you could just tell what are the bisect related features
that are implemented in the different bisect related files that you
list above.

> This is not my "first look" of the proposal. I am still working on the
> proposal. Half way there!
>
> And most importantly, Would anyone like to mentor me for this project?

Matthieu and myself are listed as possible mentors for the bisect
related projects on the Ideas page
(http://git.github.io/SoC-2016-Ideas/).
