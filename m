From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Thu, 3 Mar 2011 12:12:39 +0100
Message-ID: <AANLkTikzgGY8Fryfc7n2MYiL8ZvY1Vr0cj4QStAypwBf@mail.gmail.com>
References: <20110225133056.GA1026@sigill.intra.peff.net> <201102251658.22678.johan@herland.net>
 <20110301215907.GA23945@sigill.intra.peff.net> <201103020121.54690.johan@herland.net>
 <AANLkTino7fGnLutJ3cAxcvx8O-JbcDPJDrYHznjoN-TC@mail.gmail.com> <7v39n4ammh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 12:13:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv6TK-0007ql-S4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 12:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab1CCLNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 06:13:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37421 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab1CCLNU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 06:13:20 -0500
Received: by yxs7 with SMTP id 7so322917yxs.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=nEOI8vKWA3cxvpZQMIh3ERaiL9F2KNsefy1hou2H4Cs=;
        b=RbrHwRWKFP4etmkIUtaVVikOoIZDgXrJNkq0aG5RKYuSca9HWaVKHJ8tp27XP3Wdmp
         WBY1Wj/fB2H+IyF7CQltli6Z2Z6a2lLMCRnrVVo/OfMzFlJpcGcoMUxdOiyhrIUdBa/9
         GDpxnBbBK69rzOzsZeMaaLQGOrTnzXE6Bjx2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AQhpt5IZsJAXDB3zPQfUCJAgC725OhmErgO12dxBd4HJ0Afainz44H10g+lgMdOcoe
         Hejl5cwsjXKx5xaT/rvnYru8WO/vhvbj6I1N/RiJGO6Si71qjx1kE3dbiI0X/nnOBdtw
         azAWiI7m6rimnte17P50S3pqdFj24UcdgGi7I=
Received: by 10.150.227.2 with SMTP id z2mr1635407ybg.178.1299150799206; Thu,
 03 Mar 2011 03:13:19 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Thu, 3 Mar 2011 03:12:39 -0800 (PST)
In-Reply-To: <7v39n4ammh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168385>

Heya,

On Thu, Mar 3, 2011 at 04:50, Junio C Hamano <gitster@pobox.com> wrote:
> Good question. =C2=A0There was no reason other than "that is just a h=
istorical
> accident".
>
> The intention has always been "allow people to review the change for =
the
> last time while writing a log message"; there was never a feature req=
uest
> to allow the diff to be included---it would always have been an unwel=
come
> accident it that ever happened.

In that case, can we change it to be that way now if it makes this case=
 easier?

--=20
Cheers,

Sverre Rabbelier
