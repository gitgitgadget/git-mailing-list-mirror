From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 00:02:11 +0530
Message-ID: <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
References: <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <20130608164902.GA3109@elie.Belkin> <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net> <CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
 <20130609180437.GB810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkQC-0006oT-CF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab3FIScx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:32:53 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62812 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab3FIScw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:32:52 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so6115053ieb.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+S2EM727vpUK7qo20AJx17WE1rYr66O96SvedkhAybE=;
        b=n3qDJYWbahwspXEoV0EMHIHZa0c2wHEdRAW8wRrhUF25p3UGzshAcevErMfiX+D8GI
         6nsDEvEEVcqVVm/aYDHYqZQ5xPSxGSKVpG1kwalEJLpjRY+rcfHAfs1EDfw1k78V19nC
         0vkJrNqbxVK3yRzu9Od+zwTzuAl5xMviHJHxdjN1f7gzAmqYQ1CfgB96/nYQplwj/PEa
         BFT0Ig4Q153eBsj4spWpTdNwyrGO8Yuj1vSkmcrQbo2Mx4MbAMFEyaq2cl7VFB3ZVYk3
         j8hA5+1xsTikxvUZ6WsveMXDdgNYKdQQxe++Ufh+f3f1Ep5nJdd8qOaqK+/HKy6I2biJ
         hZ7A==
X-Received: by 10.50.79.231 with SMTP id m7mr2631069igx.40.1370802772010; Sun,
 09 Jun 2013 11:32:52 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 11:32:11 -0700 (PDT)
In-Reply-To: <20130609180437.GB810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227090>

Jeff King wrote:
> I actually think word choice and politeness is only a small part of it,
> and one that I live without.  It is not just _how_ something is said,
> but _what_ is said. And sometimes what is said does not lead in a
> productive direction. I found Thomas's comment here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/227053
>
> sums up the core of many of the conflicts I've seen on the list.

This is all very good, Jeff.  Various people have expressed what's
wrong with fc's "demeanour", "tone", and "style of discussion" in
various different ways at various different points in time.  This goes
on and on and on with no end in sight. WHAT do we do?

I'll be frank: I'm a pragmatic person, and I want to see work.
Despite all this mess, who has shown me the most number of patches
with some direction?  Felipe.  Who gets the most number of patches
into git.git, by far?  Felipe.  And who is wasting time theorizing
about what's wrong with Felipe in various ways?  Everyone else.

> I am less interested in people's feelings than I am in discussions
> trying to reach a productive position of agreement, rather than turning
> it into a point by point debate that may no longer have any use for the
> project (sometimes individual points need to be refuted or discussed, of
> course, but it is easy to lose sight of the purpose of an email).

Felipe has discussed the {sequencer.c -> builtin/sequencer.c} move
with a bunch of us (and sent a patch), discussed how to write tests
properly with me (with a patch), and discussed how ruby can be used to
call into libgit.a (with code that I'm currently playing with).
