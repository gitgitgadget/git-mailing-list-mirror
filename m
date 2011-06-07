From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Tue, 7 Jun 2011 19:20:04 +0200
Message-ID: <BANLkTi=bR5mk--N=TiU7gfVa0okG=p=LtA@mail.gmail.com>
References: <20110603050901.GA883@sigill.intra.peff.net> <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com> <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org> <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
 <20110606161143.GC11485@sigill.intra.peff.net> <BANLkTikLZSrsy0D0Gs-tNKgbqJOG7qJNsA@mail.gmail.com>
 <20110607171052.GA21674@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzxY-0000zD-ER
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559Ab1FGRUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:20:46 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37282 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab1FGRUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:20:45 -0400
Received: by qwk3 with SMTP id 3so2249144qwk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=cggstXmZCy9KOIPpJbX1HVrySLrflihpfAcF7NlgvSU=;
        b=wPp0cto4MeveEIuKXciCj9JD8k168WR9sCT9j38+yWGvZinYvJr4bnebok4R/R9SfZ
         506TM/P5H5oOVEyAAFAEE5nZCK+zHmNw/5e+aKs4tZwEjPowpJgXYRPnoqm5F+2GfXh7
         R2Ex1Ym3M1Es3DT3ZTxbDJ7Bv8p3L1v2Y179A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ghr7Vkm7kLTL30qDfLv42AzFOAasCV6NGmcIOpVXwoODv5JXgsDMlDbGKvt2yJ0fZm
         rCPZBVgb2G9PnkSoVgrruBw5DUgSvv7NI1xyh+1HQFwxN2cJ+VusWT3zoNBwTH1pJRUj
         S6zdu9aq1oTW142AAjJCZFYkqJdshCKLhyHxU=
Received: by 10.229.127.105 with SMTP id f41mr4821757qcs.15.1307467244147;
 Tue, 07 Jun 2011 10:20:44 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:20:04 -0700 (PDT)
In-Reply-To: <20110607171052.GA21674@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175222>

Heya,

On Tue, Jun 7, 2011 at 19:10, Jeff King <peff@peff.net> wrote:
> So there really is no room for further communication.

Thanks for checking. In that case it's just a matter of me not having
implemented this particular feature properly.

-- 
Cheers,

Sverre Rabbelier
