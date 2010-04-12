From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull suggestion
Date: Mon, 12 Apr 2010 16:18:23 -0400
Message-ID: <s2m3abd05a91004121318x22b1f712tdd5600ad656c6b13@mail.gmail.com>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> 
	<201004081754.24954.trast@student.ethz.ch> <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com> 
	<20100408231154.GB13704@vidovic> <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com> 
	<20100409034911.GA4020@coredump.intra.peff.net> <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com> 
	<20100410043535.GA22481@coredump.intra.peff.net> <m2v3abd05a91004102301i95bf7091ib2bd9da5e8a208c1@mail.gmail.com> 
	<7vaataphi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 22:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Q5t-0000SJ-R8
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 22:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab0DLUSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 16:18:46 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48202 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab0DLUSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 16:18:46 -0400
Received: by wwi17 with SMTP id 17so2448164wwi.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MHBVaRpoUwKfB/G2ID66J0XFGmCjX6tC2Gh0SOWI3hU=;
        b=Kigl5m8i1QX779kb1JnwI0nDOC2oYDp8aopccmFMI34W5eG0FsjM2oSXmOtm3yeqmt
         NZBigv+PtVoyP62kGP/A7tsgcAjIUpq3GbLPUmJlS1h8ZBzIWtHRp3BQGvVNZ8ffk242
         vluyxKzoA+LNy3XveteHtdijk0J0YuK5zqUg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wGskObZIFf5UdZjiPmyBEU4W0SVCJg+rSgD1h9WUUMRZqs5qABDjcT4omRtbXqNmGM
         1MSQQrWOxK6Yqj6RQroYjk2Jhgp1uG7zJxcw0cx1LcYzGn3FgI/HPxkJg2RPgtAQrHOU
         dxGzei2kZvQ/tNyt14dxwYyB/aB81b0yFxYPc=
Received: by 10.216.157.212 with HTTP; Mon, 12 Apr 2010 13:18:23 -0700 (PDT)
In-Reply-To: <7vaataphi7.fsf@alter.siamese.dyndns.org>
Received: by 10.216.188.14 with SMTP id z14mr2518608wem.38.1271103524589; Mon, 
	12 Apr 2010 13:18:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144766>

On Sun, Apr 11, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>
> The other answer would initially appear a bit sad, but after you thin=
k
> about it, it would turn into an enlightenment, especially for people =
whose
> brains have rotten from years and years of CVS/SVN use.

My brain was rotten even _before_ CVS/SVN use, so you can picture
the damage.

Now, thank you very much for taking the time to explain everything. I h=
ad
a vague understanding but now things are clearer.

I think that there was a document back in the day, that was giving a
relationship between CVS/SVN commands and git. A posteriori, that
document did more harm than good: it made you believe that you could
use git as CVS/SVN. In practice, that is very difficult and error prone=
=2E

> Now, the above inevitably solicits "then why doesn't 'pull' automatic=
ally
> stash and then unstash?" question. =A0I think the answer is obvious i=
f you
> think about it, and it is getting late, so I'll leave that as an exer=
cise
> to the readers but will leave a pictorial hint.

Before I start thinking I already have a question (which says a lot abo=
ut
my thinking capacity): can't git detect this  problematic case ? My fee=
ling
is that an automatic stash/unstash will  work in most cases and could b=
e
triggered by a --dirty flag.

  -- aghiles
