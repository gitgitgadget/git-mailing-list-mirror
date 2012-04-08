From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Sun, 8 Apr 2012 16:47:04 +0300
Message-ID: <CAMP44s3c2SNSh=TGhYv=JKGu4QJfPB_xoBip5wwLoDh3dLHYNw@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
	<20120408124652.GN2289@goldbirke>
	<CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
	<20120408132704.GB4103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 15:47:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGsSZ-0003He-QZ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 15:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab2DHNrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 09:47:08 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63963 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab2DHNrF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2012 09:47:05 -0400
Received: by eekc41 with SMTP id c41so958337eek.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fBfy8yo1DGvAeNuWqaGtn5fVS097hZqtZOp6ijSjsl0=;
        b=AHQgvxqLRrMw98Pf5jQ8r2ZZv98yHiJyg7/1cwRq/dEsXnO39LUJtb+f0vcqBeIaYf
         kRySKsJ+wiiNOyO/s4Ao0te91y/cLM7MFGlEhzfi4TLeSX2uO++Fy/llEy8Nx0XPJ4EI
         jTB65JAMDrleHVtGujsqITBZBz+zEB3vE4wTJqLcC2ekQHbCBc9QtH1xbv3/JBBPrJGx
         1+RD3T2ABczInQ5vOvP7+OjzFPANQKtkgHZhks22MDVfxY0JbA8czKsU6uplFByFoJgL
         +t26gVBGDjk5gP98kqhecz6nuZ6g3Y7iuATWw/J66nx2OSpFj1iNU3Q04vNeB0Wmp3Fd
         lNtw==
Received: by 10.14.96.3 with SMTP id q3mr492334eef.42.1333892824389; Sun, 08
 Apr 2012 06:47:04 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 8 Apr 2012 06:47:04 -0700 (PDT)
In-Reply-To: <20120408132704.GB4103@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194999>

On Sun, Apr 8, 2012 at 4:27 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Felipe Contreras wrote:
>
>> So we should never make any cleanups because some custom completion
>> functions might theoretically break?
>
> No, tasteful cleanups that don't break custom completion functions ar=
e
> very welcome.
>
> Also if you have evidence that this is definitely (not just possibly)
> only a theoretical problem, then it would not be a regression. =C2=A0=
But I
> actually find it likely that custom completion code would have
> imitated the old completion code in git that used the suffix argument=
,
> so...

Show me an example. If you do something like:

 __gitcomp "foo bar opt=3D" "" "" "suffix"

The result would be 'foo suffix' 'bar suffix' 'opt=3Dsuffix'. How could
that *possibly* be useful?

> Can you remind me what the benefit that the user is getting from this
> patch

Absolutely none.

> in exchange for us breaking their tab completion?

Whoa! Breaking their tab completion? Where? Can you show me some eviden=
ce?

> =C2=A0The title
> ("simplify __gitcomp") tells me exactly nothing about its impact
> except that it is perhaps supposed to result in no behavior change.

That is correct. No functional changes. I would need to update the
tests if something changed, right?

Cheers.

--=20
=46elipe Contreras
