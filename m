From: Stefan Beller <sbeller@google.com>
Subject: Re: Ensimag students contributing to git
Date: Mon, 18 May 2015 17:50:36 -0700
Message-ID: <CAGZ79kZF2Ne8vLTof_hq+UL3_U2GPeExqk7qjEQ=yFb6eQkyqA@mail.gmail.com>
References: <722582475.919095.1431991277969.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	galanalr@ensimag.grenoble-inp.fr, lespiner@ensimag.grenoble-inp.fr,
	pagesg@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 02:50:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuVk2-0004hB-P8
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 02:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbbESAui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 20:50:38 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35053 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbESAuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2015 20:50:37 -0400
Received: by iesa3 with SMTP id a3so2313763ies.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ScZc1kBvoeEng2o0TQ2Oy7uAmBB7pYgBtYmxqT7V3aU=;
        b=J/SmugfLH+DsipX2iAqME4YQNBwMJl5F5v7+l8WOx11r2CbOznRkBTSYlp6oqWrZNT
         RjJsRzWkVcT76Y5fsroHA9KGMShuUOehN1HACe1g6chzcrfow1m39O+NPl2UQt3t9565
         U8AkGyY7Fo+vjZWxVE3h9cPVCwzHj9b1e1uj8qiQndRM7WN7Sgf7ax5f0pAZt6gSNnX4
         l+2jwv+bFTRYcCxTuDh9KlT3hfQbsRDUy7xqFOtqscymSJ5FtB9rwCCaAAqhAm1KT8/5
         GHBWKNoIxWIo6z8Cgg8Pb/UzVT8a0CadFFF653gmbd6VYQ+gGFXhGYKXxBv8vczDNpji
         8uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ScZc1kBvoeEng2o0TQ2Oy7uAmBB7pYgBtYmxqT7V3aU=;
        b=eeUFxAr276Zq1ftqtD3HaVea+rOXaDITE6Uj5D4bSrUcFKUD3OVgE1AXvLQFIdnP59
         YH2r1JUryLRMd5zWu8C3SgOjxyHGhDNH/VeOsMDww27FJJVJU1nX9hL35wh9UljKloFP
         9jv9p2aPyVDuMtkrhDxqGiHERnAqCzJFxuKZPCWfyLcns9rbRmC8bwwHjbgAa/GEOOq3
         bgLlnHqG5oHSiRsteWajxcrno7CBx/lxcjltE83rGiuUicpv40SEeJG3R3LpYiPs1mMQ
         pKXIDvnMjlWWWTX6wj36AF/zLoq4ncsRQT90eHsSD50ZbsHvbb/Gt1fvSo9y9cDz7sPN
         0u8Q==
X-Gm-Message-State: ALoCoQm9biVmFFvSr+DWrpTlyDiwOQvGgG870IZJckdAuUf/mlDoETaTr63/mckWeRemAhtFx4b7
X-Received: by 10.107.8.144 with SMTP id h16mr690289ioi.49.1431996636764; Mon,
 18 May 2015 17:50:36 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 17:50:36 -0700 (PDT)
In-Reply-To: <388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269337>

On Mon, May 18, 2015 at 4:23 PM, Antoine Delaite
<antoine.delaite@ensimag.grenoble-inp.fr> wrote:
> Hello Git community,
>
>
> We are a team of five students from the ENSIMAG (a french school of e=
ngineering and computer science) who are going to contribute to git dur=
ing a month at least and after if we have the opportunity. We will work=
 under the supervision of Mr. Moy.
>
>
> We are glad to contribute to git and we are looking forward to gettin=
g advices and reviews from the git community. It will be a great experi=
ence for us as young programmers.
>
>
> We planned to work on =C2=AB git pull =E2=80=93setupstream =C2=BB for=
 the first days if nobody is currently working on it and then we though=
t of finishing the work of elder contributors from the ensimag on : =C2=
=AB git bisect fix/unfixed =C2=BB.

git pull is being converted from shell to C as part of the
Google Summer of Code (cc'ing Paul Tan who is the
student, and Johannes Schindelin and me who are the
mentors) so there may be some merge conflicts arising
if we go uncoordinated. See a planned timeline of Paul
at [1]. Depending on your timeline, it might be wise to
hold on a bit and then base your contributions on the C
implementation rather than the bash implementation.

git bisect fix/unfixed sounds interesting though (just
today I tried to find a fix and messed up, again). I am
not aware of the scope you're planning to contribute
to within the git bisect fix/unfixed topic, though I'd like
to share a result[2] of a discussion we had some time
ago, on how git bisect can be improved (nobody did it
yet though).

Thanks,
Stefan

[1] http://permalink.gmane.org/gmane.comp.version-control.git/266198
[2] https://docs.google.com/document/d/1hzF8fZbsQtKwUPH60dsEwVZM2wmESFq=
713SeAsg_hkc/edit?usp=3Dsharing
