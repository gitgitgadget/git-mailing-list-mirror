From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 11:47:28 -0700
Message-ID: <CAPc5daVU77hpsWeJb9BhvHW9YwoSVb8Jgc38zZ9xEnx0cB2QDw@mail.gmail.com>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, David Kastrup <dak@gnu.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 19:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZkug-0003NZ-LT
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 19:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbbCVSrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 14:47:49 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34638 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbbCVSrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 14:47:48 -0400
Received: by oier21 with SMTP id r21so125676948oie.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZKTJvDfHa4xK4BjadcCb7vPuzg+rzFaIkiD8bdbRANM=;
        b=VDeqjuFkO3i70/QyT//WMKeLYhkzpg+fB+Dr9J1bLiKbIOhJz/HWXH7wy/6LSRf4J8
         McvrxCltGkt4WBfQauvZ6hfET73clUjWEFMKEAt9dvWGYIVjOPB/CKDrCBL3ZQZIc3r4
         bcdGrsnyoxf1+fFkWKWxc9WlJsT9gItE9Uhi7GngnrRd3XhvoRLW8inrf5yW3RNie5UE
         cOWatNNKcZX0whfZVxHa8ulcaQllI/Vsd3osMR/pnnzI8FCtOTJOLvO294j/UtBBy3rO
         A+WACgSqENnFa+VKzIZUC5a5ivhEGI5XQp2wxNbpMMhu4oLaFwjN4PaMl9KXQ4VN6q/8
         6HSA==
X-Received: by 10.202.69.67 with SMTP id s64mr25004611oia.134.1427050068239;
 Sun, 22 Mar 2015 11:47:48 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Sun, 22 Mar 2015 11:47:28 -0700 (PDT)
In-Reply-To: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
X-Google-Sender-Auth: _7rn67diLbS5uBUa3-6cMr2Kr6U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266081>

Thanks.

The most important question I would ask you is this:

Did you two enjoy writing it?

That ends up counting the most, as it affects the quality of the
end result (readers would enjoy reading it and feel the love you
put into its production), and also its longer term relevance (if it
gets to be more burden than enjoyment to you, it won't last).

And I hope the answer is a resounding yes ;-)

A few comments:

 - Some might be a bit too detailed. Because each header is
   a pointer to the list archive, picking only the points that you
   found are the most thought-provoking may be a good way
   to shorten it (and readers interested in the topic can follow
   the link). Another would be to drop the mention like "Junio
   also reviewed..." that does not say what was said in the
   review. If a review did not have much thought-provoking
   value to deserve a summary, perhaps it is enough only to
   leave it to be discovered by readers who are so interested
   to follow the link to find the full discussion.

 - You do not list your own contribution to the discussions,
   but you should. Of course it would take some discipline
   to prevent the newsletter from appearing to have a self-
   promoting agenda, but I think you two are adult enough
   to be capable of handling that ;-)

 - As a periodical, you would want to have "This edition covers
   period between these two dates" at the beginning of each
   and every edition. Publication date may serve as the upper
   bound of the range, but for an inaugural one, it is essential
   to have the date the coverage begins.

 - As an inaugural edition, we may want to have a word on
   the purpose of the publication. Perhaps a sentence or two
   to declare what the publication is about in the "Welcome to"
   section is good. I would imagine that the primary purpose
   is to cover the discussions on the list (but don't call that
   "the list" in this paragraph, but spell it out to help readers,
   as "the Git mailing list") that is not visible in the "git log"
   output from my tree.

 - As an inaugural edition, we may want to have a word on
   how it came in existence by covering the discussion that
   led to its birth. Perhaps the discussion that led to the
   publication should be made into as an item on its own,
   next to "make git-pull a builtin", "Forbid log --graph..." etc.
   Because it is neither a review nor a support discussion,
   "Reviews & Support" heading may want to become
   "Discussions". I think that is a better title for the section
   anyway, if its purpose is "what happened on the list that
   are not visible from "git log", as I expect future editions
   to cover design discussions that advanced the shared
   understanding of a problem but not quite solidified to
   become a patch series.

> Thomas and myself plan to publish this edition on Wednesday the 25th of March.
>
> We call it an "edition" instead of an "issue" to avoid confusion with
> GitHub issues.

Good thinking.

Thanks again.
