From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Fix typos in comments
Date: Sun, 21 Jul 2013 01:21:10 +0530
Message-ID: <CALkWK0kzsVLGXZsxWO5rYahb39LSTFvGuE3hZaCgrJ=nuaoo7w@mail.gmail.com>
References: <20130720190707.GA30044@domone> <20130720191311.GB30044@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Jul 20 21:51:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0dC8-0000zf-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 21:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab3GTTvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 15:51:52 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48608 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739Ab3GTTvv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jul 2013 15:51:51 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so12154433ief.12
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yvwXVzZh4Eq5NKmsHO311hIecD/zYnrPGLCovClnpdc=;
        b=bSz+kOI9RH5oHUrIuQJ7fLWwqVrDoxXV6hl+29CyTLU34RqCAFnse74bfJhjsBcT1S
         XosH6ENE7Xfx27atHHsIzQMHlmIz997Syc6rcFtUtQf2iROG2p2kMeRUwZhYkGKXb+rP
         gFiBIbV9hcvMUSQOTookim6xLGb6v2KG2u/21cwKQFevgXcTQXw9QokaQnJzEzx9cDa1
         iNda70EKIHWG/8N7ERzNnnbLEGhU+iIVCYDs3VhsqmFzHvXO2gp4mGxJg8HiXS2HGvfB
         vIDmwJblWqa9e+InbAzDb8KA/cIllgln39dBrZKz/8gwMA9ZZ7sB8c9ptUu9r3aPZn2S
         pKng==
X-Received: by 10.43.15.68 with SMTP id pt4mr14121340icb.35.1374349910991;
 Sat, 20 Jul 2013 12:51:50 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 20 Jul 2013 12:51:10 -0700 (PDT)
In-Reply-To: <20130720191311.GB30044@domone>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230906>

Ond=C5=99ej B=C3=ADlka wrote:
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 7fe0bff..9f29bb2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1137,7 +1137,7 @@ int cmd_checkout(int argc, const char **argv, c=
onst char *prefix)
>          *  3) git checkout <something> [<paths>]
>          *
>          * including "last branch" syntax and DWIM-ery for names of
> -        * remote branches, erroring out for invalid or ambiguous cas=
es.
> +        * remote branches, erring out for invalid or ambiguous cases=
=2E

Didn't look through the entire patch, but this caught me eye: what's
wrong with "erroring out"?
