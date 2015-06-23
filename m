From: Josh Hagins <hagins.josh@gmail.com>
Subject: Re: Dependency Management
Date: Tue, 23 Jun 2015 14:49:46 -0400
Message-ID: <CANuW5x0_B0F-CZ5-iq4c_JiZ99FyUvqywrdA8hPr4Pg2dfZ1sA@mail.gmail.com>
References: <45DF444C03B59343B5893402DC4F867E3A800EC7@PB2OAEXM01.oad.exch.int>
 <45DF444C03B59343B5893402DC4F867E3A800EF8@PB2OAEXM01.oad.exch.int> <CAGZ79kZkUvqDzf-j0Z3yM5q+spV-MFYL5da4LOrYoGOHFsftjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Jean Audibert <jaudibert@euronext.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7TH9-0008Bz-78
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933459AbbFWSuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 14:50:22 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35622 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbbFWSuQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 14:50:16 -0400
Received: by ykdy1 with SMTP id y1so10813475ykd.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rbxlZMF06MueB5mnsu4SxiPKccSH3xL2KXiPhpBXLWo=;
        b=vpoaJabbK5O2GjMwmTg2K3eqCHtBi3zZBPyeVCVd3QCcwzUB+4Xe8QCiZzUE75hvcL
         +9d2V4rxfq0Apsvx1mw7CXxKgNqNbxy7wGTG/Y3RTIryYPN+wchCSEhymyi02il+twR7
         Wm76Oeq5eW5lvLU3cpHqYM6x3ft+26J3tBsdVIFKTjlI3/SwNKyhYOPEcdPQ42DXDdDX
         wBkBvFXJDbXP+ii4i05mPv9TfuXExRmX8Nx1PDBEGZ2OOWtIfeTXixNdF+Jlor5d91Rv
         fWSzHHRQaoJ5mplof1GdsZ3RIFgXu2AFF/OZ0y+y6YrAZO8BXVJcN+5tRL/fbTl7s9YX
         C6ig==
X-Received: by 10.170.224.65 with SMTP id q62mr13535007ykf.75.1435085415855;
 Tue, 23 Jun 2015 11:50:15 -0700 (PDT)
Received: by 10.13.245.129 with HTTP; Tue, 23 Jun 2015 11:49:46 -0700 (PDT)
In-Reply-To: <CAGZ79kZkUvqDzf-j0Z3yM5q+spV-MFYL5da4LOrYoGOHFsftjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272479>

If neither git-submodule nor git-subtree is palatable to you, here are
a couple of alternatives you might try:

  * https://github.com/ingydotnet/git-subrepo
  * https://github.com/tdd/git-stree

On Tue, Jun 23, 2015 at 1:36 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Jun 23, 2015 at 1:52 AM, Jean Audibert <jaudibert@euronext.com> wrote:
> > Hi,
> >
> > Sorry to bother you with this question but I can't find any "official" answer or "strong opinion" from Git community.
> >
> > In my company we recently started to use Git and we wonder how to share code and manage dependencies with Git?
> > Use case: in project P we need to include lib-a and lib-b (libraries shared by several projects)
> >
> > In your opinion, what is the "future proof" solution?
> > * Use submodule
> > * Use subtree
> >
> > We know there is lot of PRO/CONS but I feel that subtree is "behind" in the race and the latest version of submodule work fine
>
> Use whatever works fine for your use case.
>
> My personal opinion/expectation is to see submodules
> improving/advancing more than subtrees advancing in the near future.
> Though this is neither the official nor a strong opinion.
>
> Stefan
>
> >
> > Suggestions are very welcome.
> > Thanks in advance,
> >
> > Jean Audibert
> >
> >
> > _________________________________________________________________
> >
> > This message may contain confidential information and is intended for specific recipients unless explicitly noted otherwise. If you have reason to believe you are not an intended recipient of this message, please delete it and notify the sender. This message may not represent the opinion of Euronext N.V. or any of its subsidiaries or affiliates, and does not constitute a contract or guarantee. Unencrypted electronic mail is not secure and the recipient of this message is expected to provide safeguards from viruses and pursue alternate means of communication where privacy or a binding message is desired.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
