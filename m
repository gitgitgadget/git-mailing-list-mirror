From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Make author and committer available to pre-commit hook
Date: Mon, 5 Jul 2010 21:31:13 +0000
Message-ID: <AANLkTim-TXX4uVyUN9loOI276wnKp22m4F7g5c-js61U@mail.gmail.com>
References: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
	<20100705114619.GA21146@sigill.intra.peff.net>
	<AANLkTinlGBt3nBa7Ge5ytjisTeDu3As4wCkF8M1iz5JV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Gisle Aas <gisle@aas.no>
X-From: git-owner@vger.kernel.org Mon Jul 05 23:31:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVtG3-0002N0-Hx
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 23:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab0GEVbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 17:31:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53775 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab0GEVbO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 17:31:14 -0400
Received: by iwn7 with SMTP id 7so5905085iwn.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=et0FOsdK/6eQcMnjeHzT0M/Q0evD08joBqkyBO9F4Ks=;
        b=t9FDKVx0oSGxhjMv+GGZxAaqkcABFBlCtXqiu5qBTqZDItm4Pyc0Uo4NEkBfgxe2NN
         rq0ZYDkkJS66jecUKz9Ak8MyeuEKBodnqqmffweYr1/xrKHYPfI/G7RXBQ4vqncHmLen
         MzvXk3q/gmpTExEdCuaKOwfQHiffhGEOfJC3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mIKDgBOs4Kn7FTdi1JV8mYnExmXgNUGPqtvLWLOXyNEY5ge4JYN6ki4Bq6JB1uIjIh
         064rOczx81kyfjS5gbuMmEixbW5oTxQh+knJ1IOe5SN39SoDJds67u87AQJpGX2lWF7s
         feQJD5H3ChzjCpmKcDZDz4XokQjYlUrMAXRsw=
Received: by 10.231.59.82 with SMTP id k18mr3479129ibh.106.1278365473694; Mon, 
	05 Jul 2010 14:31:13 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 5 Jul 2010 14:31:13 -0700 (PDT)
In-Reply-To: <AANLkTinlGBt3nBa7Ge5ytjisTeDu3As4wCkF8M1iz5JV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150297>

On Mon, Jul 5, 2010 at 18:04, Gisle Aas <gisle@aas.no> wrote:
> I agree that would be a more natural interface. =C2=A0Attached is a p=
atch
> that sets these environment variables before the hooks are invoked.
> The patch also updates the documentation and adds some tests.

Hi, just a note that patches submitted for inclusion in Git should
have [PATCH] in the subject, be submitted inline and you should CC
Junio. See Documentation/SubmittingPatches for the instructions.
