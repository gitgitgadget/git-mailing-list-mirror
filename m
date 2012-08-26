From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: misleading diff-hunk header
Date: Sun, 26 Aug 2012 12:43:35 +0200
Message-ID: <5039FDD7.2090800@gmail.com>
References: <503385D0.5070605@tim.thechases.com> <87a9xoi82i.fsf@thomas.inf.ethz.ch> <5033AC55.8080405@tim.thechases.com> <7vfw7gdtfg.fsf@alter.siamese.dyndns.org> <20120824142908.GA15162@sigill.intra.peff.net> <20120824164415.GA23262@sigill.intra.peff.net> <50381F52.9030007@tim.thechases.com> <7va9xjy4or.fsf@alter.siamese.dyndns.org> <5038CB66.1040006@tim.thechases.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 12:43:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5aJv-00031p-G9
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 12:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab2HZKnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 06:43:47 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35685 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2HZKnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 06:43:46 -0400
Received: by bkwj10 with SMTP id j10so948313bkw.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 03:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=a+GyWBZ8C4uyPYda7cuEpj0tENiiwFSLQhjR806A5zY=;
        b=uzaC5fOkvwzUAULafKBAtZ92vbSaIi+uEM3ecQaTZdnsvXVkcQ1NAzaUPpqbS+UNPI
         OKdQmi2Bs5AWIT/L1YxDp62BRrSYBqeilztSaDUGCi3NmxyHq8e/uXEsdjO/LGJaPk0O
         DUHGT1zxB/cRL9lUR71HuXRggxrcVSKFRqAipplcH6HdqNedba26viRdXSoSZRxbVN8H
         XFEjtjlDDK7gX2bmHJKUlG5pMWTNYqgZX51mjOJHri2XvRT9v4x8F7pFNmtYgk73J830
         SF/2enZZDJ0coF2Gzd32rvNmsAwg01f4m0AUInBdH51C71oBCpqNOxq3x6gCTohixsc/
         y+rg==
Received: by 10.204.4.130 with SMTP id 2mr3029212bkr.37.1345977824707;
        Sun, 26 Aug 2012 03:43:44 -0700 (PDT)
Received: from [192.168.178.21] (host166-38-dynamic.56-82-r.retail.telecomitalia.it. [82.56.38.166])
        by mx.google.com with ESMTPS id gq2sm8671216bkc.13.2012.08.26.03.43.43
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 03:43:44 -0700 (PDT)
In-Reply-To: <5038CB66.1040006@tim.thechases.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204297>

On 08/25/2012 02:56 PM, Tim Chase wrote:
> On 08/24/12 23:29, Junio C Hamano wrote:
>> Tim Chase <git@tim.thechases.com> writes:
>>> If the documented purpose of "diff -p" (and by proxy
>>> diff.{type}.xfuncname) is to show the name of the *function*
>>> containing the changed lines,....
>>
>> Yeah, the documentation is misleading, but I do not offhand think of
>> a better phrasing. Perhaps you could send in a patch to improve it.
>>
>> How does GNU manual explain the option?
> 
> Tersely. :-)
> 
>        -p  --show-c-function
>               Show which C function each change is in.
>
That's in the manpage, which is basically just a copy of the output from
"diff --help".  In the texinfo manual (which is the real documentation),
there are additional explanations, saying, among other things:

    To show in which functions differences occur for C and similar languages,
    you can use the --show-c-function (-p) option. This option automatically
    defaults to the context output format (see Context Format), with the
    default number of lines of context. You can override that number with
    -C lines elsewhere in the command line. You can override both the format
    and the number with -U lines elsewhere in the command line.
    The -p option is equivalent to -F '^[[:alpha:]$_]' if the unified format
    is specified, otherwise -c -F '^[[:alpha:]$_]' (see Specified Headings).
    GNU diff provides this option for the sake of convenience.
    ...
    The --show-function-line (-F) option finds the nearest unchanged line
    that precedes each hunk of differences and matches the given regular
    expression.

You can find more information in the on-line documentation:

  <http://www.gnu.org/software/diffutils/manual/diffutils.html>

HTH,
  Stefano
