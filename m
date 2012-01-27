From: Arnaud Lacombe <lacombar@gmail.com>
Subject: Dynamic diff [Was: Re: [PATCH] merge: Make merge strategy message
 follow the diffstat]
Date: Thu, 26 Jan 2012 22:24:52 -0500
Message-ID: <CACqU3MURpHyQZMWVJ_H9xQdbn7RCiv2e2HLK7uCC-VjQ9rQL9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 27 04:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqcRP-0005Xd-Nd
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 04:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab2A0DYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 22:24:54 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46655 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab2A0DYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 22:24:53 -0500
Received: by wics10 with SMTP id s10so903958wic.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 19:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5SmsMHEj975XeVfCjKb8El1/+Keg4oO+cYwS3kMM2zE=;
        b=TAh+NXgebmD5uQc1XBmygWzT+XPA8rihVakkYtI6SO+Azn4tQnFMmtiJ4LnwZG6GHm
         hGfNkdFq+ekqrJgsyFSaCjpUgWKopA0T11dvtiQyUctcVze1+xVdN2eyW4TkbLIdezVU
         MUGV6uyB/++pikpPDAS+KT8xeTwfPYJB6Rg64=
Received: by 10.180.104.4 with SMTP id ga4mr8683162wib.17.1327634692253; Thu,
 26 Jan 2012 19:24:52 -0800 (PST)
Received: by 10.216.82.2 with HTTP; Thu, 26 Jan 2012 19:24:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189184>

Hi,

On Fri, Jan 13, 2012 at 2:49 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 13, 2012 at 11:27 AM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
>>
>> Still, diffstat from a fetch/pull is sometimes too verbose. It'd be
>> better if we have something that fit in one screen (dirstat or maybe
>> just a first few lines from diffstat then ellipsis) then refer users
>> to "git diff --stat HEAD@{1}" for more detail stat.
>
> Yeah, I've wanted that. Show the beginning, the end, and the summary
> line of the diffstat would be lovely.
>
> It would be lovely in "git commit" too. Not just
>
> =A0 =A0Modified: filename
>
> but a diffstat that shows now many lines.
>
> And what I've *really* wanted is to actually see the diff itself if i=
t
> is small. So some kind of "dynamic summary": for one-liners (or
> ten-liners), show the whole diff. For medium-sized changes, show the
> whole diffstat. And for really big changes, show an outline and the
> "768 files changed, 179851 lines added, 7630 lines removed" stats.
>
> IOW, whatever fits in, say, 50 lines or less.
>
> That would be absolutely lovely if somebody were to do it.
>
something like:

https://github.com/lacombar/git/commit/3d90830fc8730e4f0cad9974070c6e92=
41797489

?

I'm still not a huge fan of having the `shortstat' before the
cumulative `dirstat', and still have some trouble wiring correctly the
thresholds.

 - Arnaud

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
