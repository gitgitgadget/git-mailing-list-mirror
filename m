From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 15:22:29 -0500
Message-ID: <AANLkTim2AYWqb4Q13Lk6BDC=TQtzFX9+595b2SsDpsnu@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
 <7v8vx4aqun.fsf@alter.siamese.dyndns.org> <AANLkTinzhd_nL265e7DZA4xEnXqDn-5m=9GPS7JsFY-S@mail.gmail.com>
 <7vei6vao0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt4Bx-0006tP-UH
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab1BYUXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 15:23:01 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59905 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab1BYUW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 15:22:59 -0500
Received: by iyb26 with SMTP id 26so1203557iyb.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 12:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=pMnmBaCQgc7WoHdaiIEsBmCiIQsDgdlZZY2JxZCm8bY=;
        b=fyWNw8c7g+0AmSaOrbLck1XOrj/5t1tqQm3v74hM2Dsk3snec2ELP5WGgraRyWOa+R
         D5QSCtOaeOwDqBgUcnt///EqZw9y34v+WrX70KRkIDH31D3V0HhxnyJTbTvo2G7bC4uX
         I6fsoD2IrBqm59sS55+edyCEJUYeII556kqZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=otwecQKB1XiRSXMAvJegUjF/c1FGxodojuy8HikljrFSa8VZ27Ylgzr6VLmRfP1kcX
         axsQTdFZ6hDbdJOg01HF2KyFDcNftp9Ors9FLWEeawZuFrp/1e7BJAn/x2VQC4A/ooe+
         e1bubRxBW5CClunTczBEg5Lq0KFRXlwis/lNQ=
Received: by 10.231.12.67 with SMTP id w3mr3155147ibw.119.1298665379172; Fri,
 25 Feb 2011 12:22:59 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Fri, 25 Feb 2011 12:22:29 -0800 (PST)
In-Reply-To: <7vei6vao0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167937>

On Fri, Feb 25, 2011 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> On the similar line of thought, it might be a good idea to update the
> commit template we give slightly perhaps like...
>
> =C2=A0 =C2=A0 Revert "some commit"

<bikeshed>
Maybe:

      Partially revert "some commit"

to make it easier to notice in summaries.
</bikeshed>

j.
