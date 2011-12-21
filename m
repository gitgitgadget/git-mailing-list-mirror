From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Use Python's "print" as a function, not as a keyword
Date: Wed, 21 Dec 2011 10:12:28 -0600
Message-ID: <CAGdFq_jCdybZfw3d9o8+aVxQ043LQaqpSkdXEHib3vYX6N0hbw@mail.gmail.com>
References: <20111221021930.GA31364@thinkpad> <CACBZZX7PVyCFfHTJN_QZfyt5wAcr4UAiJSmo54PSi=8pgv3sYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Morr <sebastian@morr.cc>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 17:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdOn6-0002Az-UE
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 17:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab1LUQNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 11:13:11 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:64129 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1LUQNK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 11:13:10 -0500
Received: by werm1 with SMTP id m1so2770156wer.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6iA2Df0iWDGKZwpr/yxjov8uDQIbyS0/6dgigkVSK10=;
        b=GCw3JudYM5dsEnV3BFV659c/F62+LeaWKs/BYp5MWj+avXk/XKoQVjUp+/uDQp9I+b
         JieJZs6lQPRCNFv7Gv6tYdNjSL5oc55QMH/GJqyYiJlN5UOlDAHavcasXzkZLVW8TP8X
         fS7KoInUCfqcXu1eAFPDgc6x5uSYb0QNjLRes=
Received: by 10.216.131.141 with SMTP id m13mr9356305wei.30.1324483989296;
 Wed, 21 Dec 2011 08:13:09 -0800 (PST)
Received: by 10.223.123.134 with HTTP; Wed, 21 Dec 2011 08:12:28 -0800 (PST)
In-Reply-To: <CACBZZX7PVyCFfHTJN_QZfyt5wAcr4UAiJSmo54PSi=8pgv3sYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187570>

On Tue, Dec 20, 2011 at 20:48, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> I'm running Debian unstable and it has Python 2.7. Most people are
> still using Python 2.x as their default system Python since 3.x break=
s
> backwards compatibility for common constructs like print.
>
> Does this only break Python 2.6, or all 2.x versions of Python?
>
> What's our currently supported Python version for the Python code in
> Git? It's 5.8.0 for Perl, do we have any particular aim for a
> supported Python version?

Python 2.4.

--=20
Cheers,

Sverre Rabbelier
