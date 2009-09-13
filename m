From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] Improve --patch option documentation in git-add
Date: Sun, 13 Sep 2009 15:48:40 +0200
Message-ID: <237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
References: <87ocpxb46g.fsf@jondo.cante.net>
	 <7vab1hdppb.fsf@alter.siamese.dyndns.org>
	 <87tyzp9da4.fsf@jondo.cante.net>
	 <7vskf954sr.fsf@alter.siamese.dyndns.org>
	 <87ab1gaol2.fsf@jondo.cante.net>
	 <7vbplw28js.fsf@alter.siamese.dyndns.org>
	 <87y6p08lz5.fsf@jondo.cante.net>
	 <7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
	 <87ab0zny27.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmpRf-0004bx-LJ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 15:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbZIMNsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 09:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbZIMNsi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 09:48:38 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64763 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbZIMNsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 09:48:38 -0400
Received: by bwz19 with SMTP id 19so1593494bwz.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8spgc6IIhD+6DwyvGmDrUziFu6J+yZPmGRM+TrSz1CM=;
        b=iqSwcHP4cPrjWvj8Kns0jmOBKzBveZJtZzOmNAi/4xejlJDnp9agDGzcMQ0WxCVh94
         Ap0n+NDzYJqHhoVDPSzZ9o6dESkDCMM39s9/pf/lI94TgIkMmYlQmsuj8i7MP5GzIZKN
         1YfJ6uqMyPzFnU7+Cp0I6ZYsRA60FQXUB0qyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=t8omv+lU55t/vVeeIXRLcVGkZR8tuqGAi1B1fJh4hrYnbz8teKCuKz/qLuY3Mpn97h
         nKcGsSoh+QweUB7bx3MBvoeCR6VDNOi1ViVftgXplFYpu6yHZ/9XGb2Ux1CTDizG5uX4
         bCz8Rnr4pHKDumvsudbkZPIWgKCe+s1t6VnY0=
Received: by 10.204.136.217 with SMTP id s25mr4146108bkt.149.1252849720421; 
	Sun, 13 Sep 2009 06:48:40 -0700 (PDT)
In-Reply-To: <87ab0zny27.fsf_-_@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128362>

2009/9/13 Jari Aalto <jari.aalto@cante.net>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jari Aalto <jari.aalto@cante.net> writes:
>>
>>>     --patch:
>>>     -p::
>>>         In a modified work tree, choose interactively which patch hunks to
>>>         add. This gives a change to review the difference between the
>>>         index and the work before adding modified contents to the index.
>>
>> Sounds sensible.  You may want to be even more direct and succinct, e.g.
>>
>>     Interactively choose hunks of patch between the index and the work
>>     tree and add them to the index.
>
> Thanks, see below,
> Jari
>
> From 63aa94e7782d6340ead0446ea80ed6223d7ac5c1 Mon Sep 17 00:00:00 2001
> From: Jari Aalto <jari.aalto@cante.net>
> Date: Sun, 13 Sep 2009 09:43:10 +0300
> Subject: [PATCH] Improve --patch option documentation in git-add
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-add.txt |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index e67b7e8..b94fbec 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -72,9 +72,14 @@ OPTIONS
>
>  -p::
>  --patch::
> -       Similar to Interactive mode but the initial command loop is
> -       bypassed and the 'patch' subcommand is invoked using each of
> -       the specified filepatterns before exiting.
> +       Interactively choose hunks of patch between the index and the
diff probably makes more sense than patch here

> +       work tree and add them to the index. This gives a change to
a chance

> +       review the difference before adding modified contents to the
differences? Not sure which I prefer on this one.

> +       index.
> +
> +       This effectively runs ``add --interactive``, but bypass the
bypasses

> +       initial command menu and directly jump to `patch` subcommand.
jumps

> +       See ``Interactive mode'' for details.
>
>  -e, \--edit::
>        Open the diff vs. the index in an editor and let the user
> --
> 1.6.3.3

-- 
Mikael Magnusson
