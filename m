From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Wed, 23 Jun 2010 23:21:15 +0000
Message-ID: <AANLkTikXlb_4gSfOf3lk84cRglEvI-_-w9wATe1VWalF@mail.gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 01:21:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORZG4-0007Be-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 01:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0FWXVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 19:21:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64017 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0FWXVS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jun 2010 19:21:18 -0400
Received: by iwn41 with SMTP id 41so194500iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oO2MNwvEY9fW20Eb+ojuPHIP2zRy1T32hfHohUiz03M=;
        b=w3Js4MQb8t9gapy8fGQKT5vdYz/wZy5x0v1YZnbe4wBNgw2CjkLeuSfgLr7+SuHpl0
         Xow9wlqr2vrJZH6W4cshGMZxzs9A4sKrVI0S1EdlemkrTuiXSdPqzxfkLtLsSAjLSk9y
         K2CQFaLjsLjWfNQMb3iqx6NHB+p4HxSMJizfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LOZQ1HY16EpqyMOP1Im3F3IHhIXKO7d2BcVYerLGGwm0IQK8TLdGRkYsllXOCYsoHl
         sqC7p/UoNFnxXB/hnjauY+78MdwpH0GYStHNnz+1CR7ZIuiqMnwcFA6E886Y4HGahRNj
         xUdCJSoRXMK2NH7SdNYOPXdsc8i4PWSOouS3I=
Received: by 10.231.139.21 with SMTP id c21mr9242343ibu.160.1277335275287; 
	Wed, 23 Jun 2010 16:21:15 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 23 Jun 2010 16:21:15 -0700 (PDT)
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149556>

On Wed, Jun 23, 2010 at 22:09, Junio C Hamano <gitster@pobox.com> wrote=
:

> * ab/i18n (2010-06-15) 3 commits
> =C2=A0. Add initial C, Shell and Perl gettext translations
> =C2=A0. fixup! Add infrastructure
> =C2=A0. Add infrastructure for translating Git with gettext
>
> The parts that touch other topics in flight probably need to be split=
 into
> separate patches; otherwise it is unmanageable.

I've just submitted "[PATCH v5] Add infrastructure for translating Git
with gettext" (<1277332338-8486-1-git-send-email-avarab@gmail.com>)
that omits the "Add initial C, Shell and Perl gettext translations"
patch. This'll greatly ease merging it with other topics.

I can split it up further if you want, perhaps you'd like the changes
to the Makefile to be in one seperate patch? Although I don't see how
that makes it easier to merge since you'd have to solve that conflict
anyway, but perhaps your workflow is different from mine.

Tell me if I can do anything else to make it easier to merge it.

> * ab/tap (2010-06-15) 5 commits
> =C2=A0. TAP: Make sure there's a newline before "ok" under harness
> =C2=A0. TAP: Say "pass" rather than "ok" on an empty line
> =C2=A0. We use TAP so the Perl test can run without scaffolding
> =C2=A0. Skip tests in a way that makes sense under TAP
> =C2=A0. Make test-lib.sh emit valid TAP format
>
> Updated with a newer round but it seems to break "make -j8 test" when
> merged to 'pu', hence ejected.

How does it break under pu? I can't see any suspicious behavior when
running it. I've run it with -j1 and -j8 in both next and pu and I get
the same test test-results/ every time.

> I was not sure why TAP is worth the trouble, and I still am not
> sure.

Covered in comments to a previous "What's cooking" post.
