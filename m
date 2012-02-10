From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 22:29:16 +0100
Message-ID: <20120210222916.2721e9e6@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<20120210202008.GA5874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:29:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvy22-0005CQ-MR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760227Ab2BJV3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 16:29:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36968 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab2BJV3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 16:29:21 -0500
Received: by eaah12 with SMTP id h12so1061972eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=f0ZqGZLxK0IOsvCRR2VjfEGATR2RWlpFQiIDeqEClPw=;
        b=NKBWnSZo5eq78fqoCHlsuCxFrBfnuCSvPtsDbjXRTQHY4eKu1z+FsqsRNNtNxucSNJ
         w0p0rT+muOcD6ZR6OdDPpDHm/5BcMMzYj2kzjxeF7eeBEiOTz/3fqIR5pVU9pKuxD4Iv
         SrxAl0pVKCG6YdLZ8sUAAMsYrMxruzvDIuSWY=
Received: by 10.14.125.195 with SMTP id z43mr2621474eeh.3.1328909360544;
        Fri, 10 Feb 2012 13:29:20 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id v51sm26720427eef.2.2012.02.10.13.29.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 13:29:20 -0800 (PST)
In-Reply-To: <20120210202008.GA5874@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190458>

Jeff King <peff@peff.net> wrote:

> On Fri, Feb 10, 2012 at 10:18:12AM +0100, Micha=C5=82 Kiedrowicz wrot=
e:
>=20
> > The code that comares lines is based on
> > contrib/diff-highlight/diff-highlight, except that it works with
> > multiline changes too.  It also won't highlight lines that are
> > completely different because that would only make the output unread=
able.
> > Combined diffs are not supported but a following commit will change=
 it.
>=20
> Have you considered contributing back the enhancements to
> contrib/diff-highlight?=20

Yeah, I did. In fact, at work I have a hacked version of your
diff-highlight that supports multiline changes and I use it every day.
But I just couldn't make myself fix your long README and send a
patch :).

Maybe I'll cook something in my spare time.

> I took a look at handling multi-line changes
> when I originally wrote it, but I was worried too much about failing =
to
> match up lines properly, and ending up with too much noise in the dif=
f.
> Maybe your "don't highlight lines that are completely different" rule
> helps that, though.

I must say that it works great for me. Most often it's very helping.
Like every heuristics it sometimes goes the wrong way, but it's so rare
that I don't find it disturbing.

>=20
> Do you have any examples handy? (I was hoping not to need to get a
> running gitweb installation in order to see the output).
>=20
> -Peff

Nope. Except for comparing diffs in various commits in gitweb-1.7.9 and
from my branch, I just created a dummy commit with different kinds of
changes to check if they are properly colorized.=20
