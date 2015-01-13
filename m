From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v2] standardize usage info string format
Date: Tue, 13 Jan 2015 00:49:47 -0700
Message-ID: <CAMMLpeReN_X5+RR8XrxRmt6HQo_Wikv8Ac_xG_mKxmiWdF7GrA@mail.gmail.com>
References: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>, madcoder@debian.org,
	barra_cuda@katamail.com, dpotapov@gmail.com, git@adamspiers.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, barkalow@iabervon.org,
	Stefan Beller <stefanbeller@gmail.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>, rhansen@bbn.com,
	Petr Baudis <pasky@ucw.cz>, s-beyer@gmx.net,
	c.shoemaker@cox.net, grnch@gmx.net, l.s.r@web.de,
	Philip Oakley <philipoakley@iee.org>,
	michal.kiedrowicz@gmail.com,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	pbonzini@redhat.com, Alexa
To: i.grok@comcast.net
X-From: git-owner@vger.kernel.org Tue Jan 13 08:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAwEz-0000GP-QO
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 08:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbbAMHuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 02:50:10 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:62258 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbAMHuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 02:50:08 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so15682434igd.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r27hO5wv5rnYTOHKXfjhNDjQ8vZyBAGCY18fWtoEG3U=;
        b=jEi37hEpLLwA8NY86trEcmKpvqmfBTALfsS81YeIhETB3THvYrQ9F+cLvuhIHHmsXl
         HRixfiwREQ3QSf5qawEk+/EzQMRn5gJBT9nbf7TrAivuunstyEh+4dWkxND9VDvTeAGY
         08tPnPv2LfPcCLk5tqsIC0pK7rWxk7MCPevkp0jJwe9lIfxgHnM52il1EyZrCyC8Nq7x
         sHmRZkkqQSr7vgHjeS6vjH9U0ySE4fGRljOHJsKcgEEvOcQ7KU1V606anoRWpnkwwgUB
         YOvm65+Mma6u47cXCQ1fEEB3l4Mj7N/aPYyn/LqYRUjQOgmZGgS3Jv6K2AbQSzRNnqkO
         zhUA==
X-Received: by 10.107.166.149 with SMTP id p143mr32496758ioe.16.1421135407975;
 Mon, 12 Jan 2015 23:50:07 -0800 (PST)
Received: by 10.107.128.194 with HTTP; Mon, 12 Jan 2015 23:49:47 -0800 (PST)
In-Reply-To: <1421135087-7284-1-git-send-email-alexhenrie24@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262328>

2015-01-12 22:29 GMT-07:00 Scott Schmit <i.grok@comcast.net>:
>
> On Wed, Jan 07, 2015 at 11:28:21PM -0700, Alex Henrie wrote:
> >
> > diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> > index 9200069..1abeba6 100644
> > --- a/builtin/diff-files.c
> > +++ b/builtin/diff-files.c
> > @@ -11,7 +11,7 @@
> >  #include "submodule.h"
> >
> >  static const char diff_files_usage[] =
> > -"git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
> > +"git diff-files [-q] [-0/-1/2/3 | -c | --cc] [<common-diff-options>] [<path>...]"
>                          ^^^^^^^^^
> This deserves cleanup too (the man page shows it as "[-0|-1|-2|-3|-c|--cc]").
>
> ...which makes me think the man pages need to be modified to match.

Patch v2 cleans up this usage string, but I think the man pages'
inconsistencies should be addressed separately. The man pages don't
appear to be translated, so their inconsistencies are unlikely to
cause translators any headaches.

> Also, it looks like items 1 & 4 are already codified in
> CodingGuidelines, but items 2 & 3 are new.  If we care to make the
> changes in 2 & 3, we should document the new conventions there.

Patch v2 modifies the documentation to match. By the way,
CodingGuidelines was inconsistent before. It had this example without
spaces:

   [(<rev>|<range>)...]

And this example with spaces:

   git remote set-head <name> (-a | -d | <branch>)

> Bike-shedding, I'm sure: I find "[-0|-1|-2|-3|-c|--cc]" more
> readable/logical than "[-0 | -1 | -2 | -3 | -c | --cc]" (which I admit
> seems counter-intuitive), but I wouldn't be surprised if opinions on
> that are about as split as the existing usage lines are :-).

I counted 29 usage strings that used spaces in this case, and 16 that
did not. Since spaces seem to be the more prevalent choice, I'd like
to use them consistently.

Thanks for the feedback!

-Alex
