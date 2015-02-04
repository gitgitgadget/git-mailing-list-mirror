From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Invalid responses to 8bit encoding and In-Reply-To questions
Date: Wed, 4 Feb 2015 10:07:15 +0100
Message-ID: <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIvvg-0006Dx-H2
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 10:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbbBDJHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 04:07:19 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:40129 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605AbbBDJHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 04:07:15 -0500
Received: by mail-oi0-f45.google.com with SMTP id g201so334712oib.4
        for <git@vger.kernel.org>; Wed, 04 Feb 2015 01:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=Ni8UXlzr0LfCTbx7XPnaK2JdOcjkJQuxKhQOD42FFz0=;
        b=bGGEp3ZUDqRzJUfs3IrRMDKgzkQtDWbMNosnU1MkSZid0ph+y7w8/nAUjZmyWuEf3p
         e9YyS+T3zYt25y49fZf+CAXA0WL8Me43PzCzPy2EUYrwnoHUq4hHQjKXL69IzQslCvpE
         MsB7H+xeN/9/Mv1yc5AdzOQkP+MVLHF9jwTh6WcV3M9EGUB+qJ652tcXSDjUGojDhGlO
         4CSsTE9xWU505LNHq8p6+KTDO1FA8PpcG3G0n9zav3bsP4bqgeJfERILzAEk5KcwCaY4
         ivcNIeZdbB17IEU+5M8F0qK8Cy9XtMrUL/DfKs1FLst06n33ESS/PI74/o37cNbOETx/
         ycDw==
X-Received: by 10.182.191.6 with SMTP id gu6mr18376246obc.36.1423040835055;
 Wed, 04 Feb 2015 01:07:15 -0800 (PST)
Received: by 10.60.103.210 with HTTP; Wed, 4 Feb 2015 01:07:15 -0800 (PST)
X-Google-Sender-Auth: 70NmbB-A7Nc1Mc1xxRlWhTXzamU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263349>

>From a thread on another mailing list:
| > Content-Type: text/plain; charset=y
| > Content-Transfer-Encoding: 8bit
| >
| > When I try to apply it git am says:
| >
| > $ git am --signoff geert1.patch
| > fatal: cannot convert from y to UTF-8
| >
| > Wut? I never heard of an encoding named "y", and SMTP is
| > not my strongest subject anyway.
|
| Oops, I'm afraid automatic-I replied "y" to the git-send-email question
| "Which 8bit encoding should I declare [UTF-8]?"
| (happened before with the In-Reply-To questions ;-(

Would it be possible to reject obviously wrong replies ("y", "yes", "n", "no")
to the 8bit encoding and In-Reply-To questions?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
