From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 02:40:57 -0700
Message-ID: <CAJDDKr4M-QjbiF6Yu=JKYvGP1QVm4MwkU0q8d0gDXtys3VAiog@mail.gmail.com>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 29 11:41:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3jws-0004Up-Oq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 11:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab3G2Jk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 05:40:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44631 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab3G2Jk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 05:40:58 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so5604461pad.8
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eRsjGgGALKojOdzZ74OcIJJsCDLXSY3Qq2kYcQ0byrc=;
        b=ezpzYlrdhhfHwKBBaJ1MF5oRjk3dyewEaf6aPuqKlbbQWgcP3B1hwXWYgK6A7iTq4H
         ndIGhF+phWGxV9b3Z0VUUveDD+yz8W0Q5kCP8APRzTng/R2IvbYutIQ9OmR9GpFRiIEa
         BM9Yb28X2SGwQc7Na4MBfogNNppN/fWT7QOdPb6mjOxknUsO9/2an7tXAsfkDe4n9PnR
         oPN/srDg0j/4bdCGoXb9yFCgMwlS+hbcxfrj7IjXCct/cFSu/1H2gP3YXdYlFLFRtJ3+
         utgswhm4CzmN1skPHnJvD0zEutIktgWLddQYZ46AKpYiBUyXmyvvQTXik2acunhcPD3g
         JN0Q==
X-Received: by 10.66.155.102 with SMTP id vv6mr32495599pab.89.1375090857625;
 Mon, 29 Jul 2013 02:40:57 -0700 (PDT)
Received: by 10.70.47.1 with HTTP; Mon, 29 Jul 2013 02:40:57 -0700 (PDT)
In-Reply-To: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231279>

On Mon, Jul 29, 2013 at 1:18 AM, Ond=C5=99ej B=C3=ADlka <neleai@seznam.=
cz> wrote:
> Hi,
>
> I improved my tool and it catched following additional typos.
>
> As with any big project best way to catch errors is to have automated
> checks that catch them ( Other possibility would be to read everythin=
g ten
> times to get error rate down but nobody wants to do it).
>
> If you want you could add a pre-commit hook
> stylepp-spellcheck --hook
> that checks comments for likely typos (misspells by aspell and not
> occurring in code). It uses aspell to identify them so you need to
> teach aspell which words are valid.
>
> I would like make possible to share dictionaries so teaching phase ca=
n
> be done only once instead for each person but I did not found suitabl=
e
> workflow yet.
>
>
> Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
>
> diff --git a/pathspec.c b/pathspec.c
> index 6ea0867..27ffe77 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -40,7 +40,7 @@ void add_pathspec_matches_against_index(const char =
**pathspec,
>  /*
>   * Finds which of the given pathspecs match items in the index.
>   *
> - * This is a one-shot wrapper around add_pathspec_matches_against_in=
dex()
> + * This is an one-shot wrapper around add_pathspec_matches_against_i=
ndex()

"one" is pronounced like "wun" so we use "a" instead of "an" here.
These should stay as-is.
--=20
David
