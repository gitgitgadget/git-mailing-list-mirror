From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 15:07:17 -0500
Message-ID: <CAMP44s3w0JuV1rryZP_UDzTseX3KjUnHtqPNbw3Qj4EbjqSdYQ@mail.gmail.com>
References: <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<20130609195706.GA2919@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulltc-0006Mx-FS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976Ab3FIUHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 16:07:20 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:38208 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3FIUHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 16:07:19 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so1555115lab.8
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IPcbCibFaGuqUHZznmmTfjSm1+H7RozRY2czi/kfgrE=;
        b=l/7bXsAu8T56vc6C9LTOhfrBtzy8TL+6FvgRd9fLVAeQAC2rej2f+swMa7eayPPfy3
         uPaPgUMl5b89GeOuv/joMheLsOAq0pxR1v72KD5Ye2FQonZg2DfnPdjBgjp02EX/YQBS
         BpYsNaoJK3XWr9lndAm623lJcG3gRsemRt5Ot/r4aVmabE/nf2BOwN6lwG0pZRypkQCW
         Grrsbt4Y2jLdzs76m3PYcPx6pGx4ZjoZfVGdJT4NR3/o1ZO1af8ssXGC81lLm0LpyvBl
         I9qEgAkXDzphcrp1n/6z1D4q6LysI+Z5ievIR5/UCs2yrZu1mTKhuS5Wy/FW+wxSTbgU
         uzgQ==
X-Received: by 10.112.166.67 with SMTP id ze3mr5202669lbb.25.1370808437608;
 Sun, 09 Jun 2013 13:07:17 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 13:07:17 -0700 (PDT)
In-Reply-To: <20130609195706.GA2919@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227160>

On Sun, Jun 9, 2013 at 2:57 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Jeff King wrote:

> Of course that's not the intent: the intent of ignoring someone is to
> hope they'll go away. :)
>
> In the context of other unhealthy behaviors (like alcoholism) there i=
s
> a concept of enabling behavior.

The only one that can enable me is Junio. If he stops merging my
patches I would stop sending them.

It appears Junio is a good maintainer though, as he puts the needs of
the project, and thus our users, above your personal issues.

>> I'll be frank: I'm a pragmatic person, and I want to see work.
>> Despite all this mess, who has shown me the most number of patches
>> with some direction?  Felipe.  Who gets the most number of patches
>> into git.git, by far?  Felipe.  And who is wasting time theorizing
>> about what's wrong with Felipe in various ways?  Everyone else.
>
> In that case, I can see a simple solution.  Felipe, who provides the
> most patches in git.git, by far (I don't know what that means, but
> I'll take it as an assumption),

Maybe this will help understand the meaning of that:

% git shortlog -n -s --no-merges --since '3 months ago'
   221	Felipe Contreras
    83	Junio C Hamano
    71	Jeff King
    62	Michael Haggerty
    48	Ramkumar Ramachandra
    35	Thomas Rast
    33	Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
    32	John Keeping
    30	Ren=C3=A9 Scharfe
    23	Kevin Bracey

--=20
=46elipe Contreras
