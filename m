From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 16:22:37 +0000
Message-ID: <43d8ce650903030822t21517c6fxd003d4cbef6524f2@mail.gmail.com>
References: <49AD3E78.1050706@sneakemail.com>
	 <20090303152333.GB24593@coredump.intra.peff.net>
	 <20090303154041.GA31265@coredump.intra.peff.net>
	 <43d8ce650903030812n6fe857atb773f5068b6f0a17@mail.gmail.com>
	 <20090303161934.GD32079@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:24:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXPd-0003el-6Q
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbZCCQWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbZCCQWk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:22:40 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:24691 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbZCCQWj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:22:39 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3380296wfa.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 08:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r1KCbZNCh5qnxZ3J+FuSo91WFlP2kefVq3Fr7QTPtA4=;
        b=E7vulhSdnyy0eP8rkKaKDN8Xa1eAZ5mpb3D5rC2jBNgFTJpQvR5wIOSpDB9fVi3zHE
         NvoTHoUL1NkDFc+Pxl/LIO1Pj9e1YISR9TS9EjLq1HIryfFhL56WXtblSSRzxyXUl2tA
         2mO7Wxzce1hJaJOLXiM1q9oo3Eclatow3gJAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b9p8m9jzTVkPah+wX3GioXf0oYowy3mT9csXnEKc9b6e46GnwE1lH+CYkwfh9rIPJH
         VEqKfgNejlbx9c7nVCw+xSPr2AGZ0JMgwppl76OJZwOCvtF3pGcRu02OOQKKjYq/fSh9
         6/wxUn1XzTm8SxiEnndeDi9vLel6wZiMHaIXg=
Received: by 10.142.158.3 with SMTP id g3mr3675359wfe.221.1236097357902; Tue, 
	03 Mar 2009 08:22:37 -0800 (PST)
In-Reply-To: <20090303161934.GD32079@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112107>

2009/3/3 Jeff King <peff@peff.net>:
> On Tue, Mar 03, 2009 at 04:12:30PM +0000, John Tapsell wrote:
>
>> > To fix it we:
>> >
>> > =C2=A01. use "introduce or remove an instance of" instead of
>> > =C2=A0 =C2=A0 "contain"
>>
>> I would read this to mean that it doesn't include modifying a line
>> containing that string. =C2=A0But I also know that underneath the ho=
od, a
>> change is a remove then an addition, so I would be confused :)
>>
>> What about saying "modifies" rather than "contain" ?
>
> I'm confused. It _doesn't_ include modifying a line containing the
> string. In which case it has done its job. But your "but" after that
> is what leaves me confused. You thought it would mean that, but you
> don't due to some other knowledge, which is leading you down the wron=
g
> path?

Yes, it would seem that I was also confused as to what -S means.  It
doesn't mean what I thought it meant :-)

> I was trying to get away with a short and sweet description. But the
> behavior is basically (with a few optimizations):
>
> =C2=A0if count(a, string) !=3D count(b, string) then
> =C2=A0 =C2=A0it is interesting
>
> which is unambiguous, but it takes a second to realize the implicatio=
ns.
>
> -Peff
>
