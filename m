From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 11:09:02 -0800
Message-ID: <20131126190902.GB4212@google.com>
References: <528A9877.4060802@gmail.com>
 <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
 <528E2660.6020107@gmail.com>
 <xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
 <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com>
 <5293DE93.3020008@gmail.com>
 <CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com>
 <52947B42.4080105@gmail.com>
 <CACsJy8Dfibu96VchD=p_05deLm-46mfXZzcYQg+0BqaN2=To=A@mail.gmail.com>
 <529488D5.80605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: =?iso-8859-1?B?QW5kculzIEcu?= Aragoneses <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 20:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlO0b-0005jP-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 20:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab3KZTJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 14:09:13 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:51392 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab3KZTJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 14:09:11 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so6107460qeb.22
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yHczllSg4KzF4VWs9TRbNftshYwtu5nmQxDVz78MNOE=;
        b=fxLSaE5gtXyWmkyt94jL3OGj5NJJdcy9JbndmYWe3ub2HBjYsQN3LG1TBdLjQbaOQx
         PXEwPjpNhxokoNn5h1+hBMUDjUX00NQhu+/Amksq8afi0Zyb+VfggnXVKp6OEETe3LlM
         HRl3wkLpptJQEw0my3vQNMY0ox53AcubRGxaOH9xQFzGSEXYtzxFp7Jgyxj4yVhbFbLH
         02/qgXM420WoLZmdpOnABYsV/nwH2v5DGhCUhjYKuk3SLknAado3vOs6hsV0sNsu5/kT
         DrAjIROjOu+x08PpGXG3SwYM2wTDwvPuDDY/pS2qmOtFYS4z0r49Vl9LTQh72nx9gFHC
         3xcg==
X-Received: by 10.224.11.7 with SMTP id r7mr17565571qar.91.1385492950134;
        Tue, 26 Nov 2013 11:09:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id n7sm8131383qai.1.2013.11.26.11.09.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 11:09:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529488D5.80605@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238389>

Hi,

Thanks for tackling this.  This review will be kind of nitpicky, as a
way to save time when reviewing future patches.

Andr=E9s G. Aragoneses wrote:

> From 4f3b24379090b7b69046903fba494f3191577b20 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Andr=3DC3=3DA9s=3D20G=3D2E=3D20Aragoneses?=3D <knoc=
te@gmail.com>
> Date: Tue, 26 Nov 2013 12:38:19 +0100
> Subject: [PATCH] transport: Catch non positive --depth option value

These lines are redundant next to the mail header, so they can and
should be omitted to avoid some noise.

> Instead of simply ignoring the value passed to --depth
> option when it is zero or negative, now it is caught
> and reported.

Nit: commit messages usually give a command to the codebase, like
this:

	When the value passed to --depth is zero or negative, instead of
	treating it as infinite depth, catch and report the mistake.

> This will let people know that they were using the
> option incorrectly (as depth<0 should be simply invalid,
> and under the hood depth=3D=3D0 didn't have any effect).

Ok.  Do we know that no one was using --depth=3D0 this way deliberately=
?

> (The change in fetch.c is needed to avoid the tests
> failing because of this new restriction.)

Based on the surrounding thread I see that you're talking about the
test script t5500 here.  Which test failed?  How does it use "git
fetch"?  Does the change just fix the test but keep in broken in
production, or does it fix "git fetch" in production, too?

> Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
> ---
>  builtin/fetch.c | 2 +-
>  transport.c     | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

It would be nice to have a brief test to demonstrate the fix and make
sure we don't break it in the future.  "grep fetch.*--depth t/*.sh"
tells me t5500 would be a good place to put it.  For example,
something like

	test_expect_success 'fetch catches invalid --depth values' '
		(
			cd shallow &&
			test_must_fail git fetch --depth=3D0 &&
			test_must_fail git fetch --depth=3D-2 &&
			test_must_fail git fetch --depth=3D &&
			test_must_fail git fetch --depth=3Dnonsense
		)
	'

What do you think?
Jonathan
