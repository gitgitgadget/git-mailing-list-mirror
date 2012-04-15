From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tests: add tests for the bash prompt functions in the
 completion script
Date: Sun, 15 Apr 2012 23:56:36 +0300
Message-ID: <CAMP44s3LJO_Ryc-ONjF+rEHCb1hB8+4Muar6pzjD3zrazYqK+A@mail.gmail.com>
References: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:56:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJWV3-0004QN-HX
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 22:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab2DOU4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 16:56:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43181 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab2DOU4k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 16:56:40 -0400
Received: by eaaq12 with SMTP id q12so1122524eaa.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SYopsVaTlihkbJbno0g+coucPSlveGxl3nLpKRjaw/4=;
        b=GygAsqbY5B40ucTPZeAiYitsYdYx47SfIKQ5+X5LuSZNnwFLD90+3+FrhL1jHOx++e
         qBtztR2eHl1MkfKItu7UCmV6lHLC4cOq9vZr6XI0E3X7bOd6JMs7qqeSZFcoL9dhsafG
         Ioiey+kx4jNLMlX2CflcH4bYKAQLR2jYmzlRfmnr4Q5v+T+N6F+qOwmzQkQRplY1LZAM
         bv0igYI7v7GKXhKpBbZwmqTSl8e7WFW49+u+9nL4mB2ghPhke09qJgmp5J+l2xO8WSLs
         t3H4cXxkCl5SGKN+VY/uZ1oYDi1x3fRTEV997m3pczymTDdI8nlGYFE2/ygy9zuejUVs
         YhSA==
Received: by 10.213.104.132 with SMTP id p4mr599954ebo.101.1334523396705; Sun,
 15 Apr 2012 13:56:36 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sun, 15 Apr 2012 13:56:36 -0700 (PDT)
In-Reply-To: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195588>

On Sun, Apr 15, 2012 at 11:31 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> The tests cover the discovery of the .git directory in the __gitdir()
> function in different scenarios, and the prompt itself, i.e. branch
> name, detached heads, operations (rebase, merge, cherry-pick, bisect)=
,
> and status indicators (dirty, stash, untracked files; but not the
> upstream status).
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>
> Goes on top of fc/completion-tests (b8574ba7).
>
> =C2=A0t/t9902-completion.sh | =C2=A0436 +++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 file changed, 436 insertions(+)

Perhaps it would make sense to create another file for these,
specially since there's the plan of splitting the prompt stuff to a
separate file.

Cheers.

--=20
=46elipe Contreras
