From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: file names
Date: Thu, 9 Dec 2010 16:00:19 -0200
Message-ID: <AANLkTin=H5HMKhXAyPwZu+jJinRxAhiirhWSSUCWNhWY@mail.gmail.com>
References: <AANLkTikeAFj68Rr35gcf4dxXXHU+au9wA7wd+-WB3BSS@mail.gmail.com>
	<7v39q6hm14.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 19:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQkou-0008Gc-Gp
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 19:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab0LISCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 13:02:16 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:51043 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab0LISCP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 13:02:15 -0500
Received: by bwz16 with SMTP id 16so2964222bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 10:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5J/HkDf8NFxdJoPO3vrS5fddchg2aK8V2Tm8Elw554c=;
        b=cgBfcBcQ/TuJ+sQnkbn/FdmBLSTW0h4fs7h5CQYi6KkT9glavodoCigUGf1i3g09QF
         l4hPTzkoQsFAhtiSVjSfsnFyp3lov+pYXHPmab46jJ9fHHxGNUN0h+hWuSAMxXtFeh6n
         NI7pBw9OjEmlGsw2RDSw5qNAitO76XnhLrboI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jNJDPMkNyErNGQ3yWPLIvUu72qmtD6w3TnM4glA2iXABe0mVaizzwYdX9/TgNy2jTD
         SG51uqKXlx9xgGCvfXUeqem0dTyT+ct7EAWatY/gybn+pdbgQ754TpaEMJlVWNLQt7cF
         6rAKQulq/wk3c2HOUmkhNZjqramTxzXfYLcP8=
Received: by 10.204.76.137 with SMTP id c9mr3707901bkk.40.1291917619263; Thu,
 09 Dec 2010 10:00:19 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Thu, 9 Dec 2010 10:00:19 -0800 (PST)
In-Reply-To: <7v39q6hm14.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163300>

On Thu, Dec 9, 2010 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> So it seems from this data, there is a preference for naming files
>> using dash over underline.
>
> Yes.
>
>> So the question is, should the files using underline be converted to
>> use dash instead?
>
> If this were before v1.0.0, it might have made some sense, but not at=
 this
> moment. =C2=A0So the answer to "should?" (or "could?") is a firm "no"=
, which is
> always different from the answer to "wouldn't it have been nicer if t=
hey
> were named differently?"
>
Right.

What about documenting it? Is it worth, but only on version 1.8.0?
