From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 02:04:36 +0530
Message-ID: <CALkWK0kMdQEXMTAwFLdz=FXEFiJfemM-+80SCALqS8q9yyr2Qw@mail.gmail.com>
References: <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin> <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com> <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net> <CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
 <20130609180437.GB810@sigill.intra.peff.net> <CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
 <20130609184553.GG810@sigill.intra.peff.net> <20130609195706.GA2919@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlmKg-0002qO-ML
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab3FIUfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 16:35:19 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55165 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab3FIUfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 16:35:17 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so14772786iet.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OtnB2HzuCsnd3Uqv57GTZVmAioyjeO1RhvvsodbT9vA=;
        b=oWpZ9e4LQlLT1iJ231ENRmOpUpkvYGXakxfgyIkk5KX125zzmjFohotNp0a9GeQYha
         WnQP7YhzEFdXDa92hSruVZxUI9Dhr/Jid9w2tmG396qqlE4sD11FxkjDa4QvPVYkAEEu
         uDlMELqiT5lqQsJOCO/ySSg77wVDEiAlKBUBrPqKELGWeGzTj90vN8tdFbJEqcpb/VHb
         bgLFMsAmkbKOAvTd9Ah+uYGjMO4Wy7iQaV1/2ubzplROFjYxkB2Mg7MoNIjk47nnqJz7
         2aPxoN1CLQQ3twveLPSeUV6sMme3ERS/3xAQ3WtHsUZLLveTDgEZbmCDm4OBxORNp+1W
         UOMw==
X-Received: by 10.50.56.20 with SMTP id w20mr2756421igp.40.1370810117314; Sun,
 09 Jun 2013 13:35:17 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 13:34:36 -0700 (PDT)
In-Reply-To: <20130609195706.GA2919@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227164>

Jonathan Nieder wrote:
> Of course the git development community is not organized enough for an
> intervention, but as context I thought I'd mention that that's what
> works.

Atleast this is more interesting that the canned
Felipe-demeanour-complaint people constantly bring up boring everyone
to death.

> In that case, I can see a simple solution.  Felipe, who provides the
> most patches in git.git, by far (I don't know what that means, but
> I'll take it as an assumption), can put up a fork of git that you run.
> He can solicit whatever level of review he is comfortable with before
> pushing out changes, and then the result is available, without the
> pesky middle-man of those theorizers that were trying to develop git a
> different way and then got annoyed.
>
> No harm done, right?  It doesn't have to involve the list, because
> what's relevant in this worldview is code, not the people.

I'm still scratching my head over what you interpreted.  People are
not unimportant!  Code is result of everyone in the community
scratching their itches.  I value each and every community member, and
git.git wouldn't be what it is today without everyone.  How did you
interpret that as "I am only interested in Felipe's work, and everyone
else is a theorizing buffoon"?  I specifically said theorizing about
Felipe's behavior over and over and over again is not changing
anything.  Stay on topic, and discuss how to improve libgit.a.

To me, it is important that everyone stays productive, so we can
maximize output.  I want more review, more discussions, more code.  I
get bored out of my mind when Junio does feature freezes and nothing
goes in.  Obviously, people getting offended and writing long
emotional rants on the list is unproductive and undesirable.

> So why aren't I privately ignoring his messages and letting the list
> become what it may?  It would seem that I'm making the problem much
> worse, by starting discussions that focus of how to stop pushing other
> contributors away instead of (what's important) code!

It is imperative that you express your opinion and discuss it, if
something is troubling you.  What is this dichotomy between
contributors and code?  When did I discuss pushing contributors away?
