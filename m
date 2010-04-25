From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 19:32:00 +0000
Message-ID: <m2h51dd1af81004251232ue621ca42r7168429f45d20461@mail.gmail.com>
References: <20100425130607.2c92740f@pennie-farthing>
	 <v2m8c9a061004251110paf7ba4e5r1997bc6262afcb1d@mail.gmail.com>
	 <y2g51dd1af81004251124zc4da759dka2ceebe1d9735fd7@mail.gmail.com>
	 <20100425192207.GA14736@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Jack Desert <jackdesert556@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 25 21:32:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O67Ys-0004lj-BI
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 21:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867Ab0DYTcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 15:32:07 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41783 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0DYTcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 15:32:06 -0400
Received: by bwz19 with SMTP id 19so46844bwz.21
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l/IBnb6Ktne187jjuX3NFclqhHJBKU9MzXQjBjjBbBk=;
        b=DwBCdwvEdabFFhHHebXwGCe4oWNEVtpRGP1ocIpijc1qmBtw6PtR/MREh38nufsVAy
         M0FG8WVhg1mev0jnufIBJg5p7WxBth9j2bDfmnHbX7+aw5IFh+oIbduYD3WpH+RnlPm9
         s8aA5tayFznqmE7+O/YpwehVwUP0OmeC/CpJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tr/41TXQKGK1heN13u9keBB5SF2B1L9ArxFdpr5vHgImPa0TKeom+lFuTW6tt+eP5k
         jTmrcBu1rIweBn8689oj4c6BiGr1ryhlc0/cV1GPx/LZDx5OWTg5vv+Q1fgkIZ0FGb9g
         Rc0xlZeoJoPKpW3WlI9eHCVpjx+kYajPLXKeE=
Received: by 10.204.134.151 with SMTP id j23mr1945200bkt.17.1272223920700; 
	Sun, 25 Apr 2010 12:32:00 -0700 (PDT)
Received: by 10.204.121.195 with HTTP; Sun, 25 Apr 2010 12:32:00 -0700 (PDT)
In-Reply-To: <20100425192207.GA14736@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145761>

On Sun, Apr 25, 2010 at 19:22, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 25, 2010 at 06:24:43PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> On Sun, Apr 25, 2010 at 18:10, Jacob Helwig <jacob.helwig@gmail.com>=
 wrote:
>> > I can't really say if it's actually a bug, or not, but as to your
>> > question about where to file a bug report: You just did. =C2=A0Thi=
s mailing
>> > list is the correct place.
>>
>> I've had some issues scripting `git fetch` because on error it'll
>> print to stdout and not stderr.
>
> Errors should go to stderr, so I imagine patches would be welcome. Wh=
ich
> messages went to stdout?

I can't recall exactly now. Looking at fetch.c I can't see anything
obvious, I'll report anything if I spot it in the future.
