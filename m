From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 14:38:30 +0000
Message-ID: <CAMOZ1Btu=TOSqJu9uu3if_RFH6UQco+dFv-edVNoW9SauVQdmQ@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <3c10d6593152436c9dd3a5b5773e3c79-mfwitten@gmail.com>
 <CA+sFfMcMgPDyCi6SCS=Sc4XFrug_Ee7vbmBBkmkwfwwpXg8yCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "John S. Urban" <urbanjost@comcast.net>,
	PJ Weisberg <pj@irregularexpressions.net>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 16:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Dxh-0000sM-D9
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 16:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1IDOqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 10:46:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36666 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab1IDOqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 10:46:10 -0400
Received: by iabu26 with SMTP id u26so5242214iab.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=54qOib1U17a0kSrFjoekacmC8Uvj7+IE8TuSaSsz8EY=;
        b=ZE8LI2WWyzEC8rs6CzI41inCGSxr/GCY60TLqlUJmaUAmFuqdv8qfmzIO4O230taHW
         k+O+KKwlH+JdFya3ZGFoUOMbBCyelthB3c3h8TK0c1amEWhDsGx8L122JB6CAZzSgLuf
         20jeWK6bI5/ytzhLhIqGCTH4JBM/PhgyvuMpc=
Received: by 10.42.76.69 with SMTP id d5mr2527343ick.330.1315147140181; Sun,
 04 Sep 2011 07:39:00 -0700 (PDT)
Received: by 10.42.178.198 with HTTP; Sun, 4 Sep 2011 07:38:30 -0700 (PDT)
In-Reply-To: <CA+sFfMcMgPDyCi6SCS=Sc4XFrug_Ee7vbmBBkmkwfwwpXg8yCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180685>

On Sun, Sep 4, 2011 at 14:16, Brandon Casey <drafnel@gmail.com> wrote:
> That's true, but git is also a tool with a purpose and tags are intended to
> be permanent.

Tag *objects* are intended to be permanent (like commit objects);
however, don't forget about `lightweight' tags.

> A valid workflow would need to be demonstrated before such a
> high-level operation as rebase made it so trivial to rewrite tags methinks.

How is it any different than doing the same with commits?

Let's say I have a private repository with an appreciable graph of
commits and collection of tags, and that I want to clean up the
history a bit before publishing it publicly. Well, it might save me
a lot of trouble if I could use `rebase' to create an alternative
history without also having to dicker around with creating the
associated tags.
