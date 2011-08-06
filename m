From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 00/40] test whitespace - perform trivial whitespace clean
 ups of test scripts.
Date: Sat, 6 Aug 2011 19:03:47 +1000
Message-ID: <CAH3Anro-Qi5c5ojiudqctCcuaN5SPO=YcAEbcfO06DhsObDdgg@mail.gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 11:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpco9-0004Qp-JT
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783Ab1HFJDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 05:03:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46240 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HFJDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 05:03:47 -0400
Received: by vws1 with SMTP id 1so2413972vws.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BSGysc4dzh4Lh8doebMQU1QsIbBw6ZRFBrYG/7V9/F4=;
        b=EzISfGSQdLMmsvbD15M6SGeNXmMAQBW/znzYkQeou3Sfqtbr9b16sYoeeDuU/Tx2Vq
         ChZpPDIgceRCpUetRzlCP1TIZ0yrrXItd6xfBdX5CPa6Vq8VzWKkKzlqB8aY90/NcbOn
         vHHhZG9p51CJH9T1YRsWJvNazEpe3veWsc+n8=
Received: by 10.52.66.226 with SMTP id i2mr3333465vdt.268.1312621427104; Sat,
 06 Aug 2011 02:03:47 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sat, 6 Aug 2011 02:03:47 -0700 (PDT)
In-Reply-To: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178872>

On Sat, Aug 6, 2011 at 6:41 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>
>...

One can imagine generalising test-cleaner.sh to things that aren't tests.

So, something like:

         git whitespace-cleaner --test "make test" *.c *.h

would do whitespace cleaning on all .c and .h files and then use a
bisection process to find the edits that cause a break in the test
suite. Then rewrite the history and iterate the process to find the
maximal series of whitespace fixups that does not break the test
suite.

jon.
