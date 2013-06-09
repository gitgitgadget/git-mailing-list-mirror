From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 12:57:06 -0700
Message-ID: <20130609195706.GA2919@elie.Belkin>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulljs-0001Tf-EJ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800Ab3FIT5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:57:16 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:63791 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIT5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:57:15 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so1187148pab.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y+wkeuk6dzU7zBCOxly4pwwofOuYI06/pwJDeuheV+k=;
        b=Melfo+JQSJDwNAN2xO3pckuqFcjRQyU9Wh9oYrPqm74JB7rbUcPManDgvvf/H1b4z3
         QafolRkCHABNHAyHbp3CgN20SauKfffT1BLt2tG44UZm9nbQW7J8wOJQtVR0rFJVUO9A
         bSQR0PaNVtrH/yydKa88BuiWxOCoA6b0ZO5XRHL4vj1Xbylx7qngEk0bVQF8GzPIAJ1K
         oRop+wzZ0RdR6lYdWMV2XgV+cwaIGs+AxEt+SP1M667XgJFe1QyDM6bDcLE9OE1tEpqY
         rBqDxdB52E/m2U9T330gvgRoy5pk+a05SyKT4DADItv+2CJbXtkrxMcKuxHeXuNjpEwL
         z6yg==
X-Received: by 10.66.50.4 with SMTP id y4mr11347639pan.216.1370807835070;
        Sun, 09 Jun 2013 12:57:15 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id vu10sm7563576pbc.27.2013.06.09.12.57.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:57:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130609184553.GG810@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227158>

Jeff King wrote:

> My advice would be to ignore him when the discussion proceeds in an
> unproductive direction.

There is something appealing about that option.  The problem is that
it doesn't work, at least for someone that relies on the list as a way
of understanding patches that have been applied (which often don't
have self-contained descriptions, sadly) and the context of other
patches.

Of course that's not the intent: the intent of ignoring someone is to
hope they'll go away. :)

In the context of other unhealthy behaviors (like alcoholism) there is
a concept of enabling behavior.  One of an addict's friends might
confront her and try to help her understand that things have gone too
far.  Another friend says, "What a mess.  Let's go to a bar and talk"
and they are drinking again.  The usual approach for avoiding this is
an intervention, where a large group of people that care about a
person together agree to confront the addict and make sure she
actually understands and work together to find a real way out.

Of course the git development community is not organized enough for an
intervention, but as context I thought I'd mention that that's what
works.

Ramkumar Ramachandra wrote:

> I'll be frank: I'm a pragmatic person, and I want to see work.
> Despite all this mess, who has shown me the most number of patches
> with some direction?  Felipe.  Who gets the most number of patches
> into git.git, by far?  Felipe.  And who is wasting time theorizing
> about what's wrong with Felipe in various ways?  Everyone else.

In that case, I can see a simple solution.  Felipe, who provides the
most patches in git.git, by far (I don't know what that means, but
I'll take it as an assumption), can put up a fork of git that you run.
He can solicit whatever level of review he is comfortable with before
pushing out changes, and then the result is available, without the
pesky middle-man of those theorizers that were trying to develop git a
different way and then got annoyed.

No harm done, right?  It doesn't have to involve the list, because
what's relevant in this worldview is code, not the people.

So why aren't I privately ignoring his messages and letting the list
become what it may?  It would seem that I'm making the problem much
worse, by starting discussions that focus of how to stop pushing other
contributors away instead of (what's important) code!

Jonathan
