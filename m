From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 02:11:55 -0500
Message-ID: <CACh33Fpk8_ZXw8Ladx83J+rmdRYf7ruYAMMkqOKcoH3OApKPJQ@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
	<20121212033043.GA24937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 08:12:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TigUH-0007IO-QE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 08:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914Ab2LLHL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 02:11:56 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46089 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2LLHL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 02:11:56 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so295428obb.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 23:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=8u9P0T/5LkZaUvNtb0VKcoWLdJlYnXmAQjmH0xiel3E=;
        b=NFCwixtueB3iVNpSUopGjvBZdVzpobkiPsgGEemjakcZkEuxEKx/U0FvEmnafU3K1O
         bdBade5P1M5x/YZQ8uxtKfTMCHtFJ5T5mpe7VTCcIT00kVS6ni/fQdQRnitbQ0bNHj5m
         Qy0K/nSAqHr9da9fvvnXESRIxCyONRO1wqRU6w+Ozv8peIhq67qaMaYvBZiY0liVl6sK
         A6EEsuhDz/61tv4RCtN0pkvAPcaDwhWyPa3lSI3LKI0wbyqfBjgh5oldL+eSJ0CeVewV
         fIVvUToMIxGWF8wCKhRCOc1i/XIRJvHha6X5y4tCsF9ookBetkBu/thHnhoh8mnY1e8m
         4hAg==
Received: by 10.60.0.199 with SMTP id 7mr7868oeg.139.1355296315641; Tue, 11
 Dec 2012 23:11:55 -0800 (PST)
Received: by 10.76.28.101 with HTTP; Tue, 11 Dec 2012 23:11:55 -0800 (PST)
In-Reply-To: <20121212033043.GA24937@thyrsus.com>
X-Gm-Message-State: ALoCoQkwOpTGJN1XCmc4Fi5B1EhS3u9TTYMsr/ZwR/7fKBvsqs4N+WKGjmp1P3R2PEg25cLUQ343
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211331>

Hi Eric,

On Tue, Dec 11, 2012 at 10:30 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> It might be a good fit for extending git; I wouldn't be very surprised if
> that worked. However, I do have concerns about the "Oh, we'll just
> lash together a binding to C" attitude common among lua programmers; I
> foresee maintainability problems and the possibility of slow death by
> low-level details as that strategy tries to scale up.

I think this is quite a prediction? Could you give an example
scenario? How would another language (e.g. Python) mitigate this?

> And, of course, one problem with calling back into C a lot is that
> you walk back into C's resource-management issues.

C resource management can be effectively dealt with by relying on
Lua's GC to track C resources via userdata.

> My sense is that git's use cases are better served by a glue language
> in the Python/Perl/Ruby class rather than an extension langage. But
> my mind is open on this issue.

I don't see how these languages are more appropriate based on your concerns.

--
- Patrick Donnelly
