From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Tue, 1 Mar 2011 11:31:12 -0700
Message-ID: <AANLkTimFuU1QduAfwred0zu6LdWN2eHo9X+T4=_qfh_C@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
 <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
 <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
 <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuUMF-00061P-Oo
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 19:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab1CASbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 13:31:35 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39493 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756671Ab1CASbd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 13:31:33 -0500
Received: by fxm17 with SMTP id 17so5090915fxm.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=8LRaFi8tVLuuv3FTC/Y1+Uiw81xyBWHvcDNPOuuPMJs=;
        b=NnxobArwVvH9fDK8GOBmP4yOsVLyRc6y6uj37knR7VLM0wvfLYKHBh9q4tJTIv3K0a
         fp7L4wZ1TxMHPJyJO8h1oCq1Ut/B80zbp+TkmVbg2XgiWa6xWbsIy+qhOu4vlQpqAB4L
         g/Mr694oV0imIO1SNar2v0WLSD+efHxyHHo0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VfgBpRYgIv9KJ+DRUEmESQcvQ2Ha7I4SRlaNnrau3CXdW4SwAa7sJP850MLfJOd8hE
         DwIcOFWAsk5Ivj4Topsi9j+qgtRtGMIDVCHM8Y8PRlqK7IYb5PH9VcC29O1/MoriKYBv
         EoEFIdOpC+fg4+uCYD2nahSvaCm93+lwEn1w0=
Received: by 10.223.144.81 with SMTP id y17mr4526511fau.69.1299004292084; Tue,
 01 Mar 2011 10:31:32 -0800 (PST)
Received: by 10.223.109.16 with HTTP; Tue, 1 Mar 2011 10:31:12 -0800 (PST)
In-Reply-To: <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168235>

Junio C Hamano <gitster@pobox.com> wrote:
> On the other hand, it is natural to expect that
>
> =C2=A0 =C2=A0$ git grep -e frotz ".../*.txt"
>
> should find *.txt files _only_ at the root level, so it is not as use=
ful as
> the --full-tree (or --root).

I've often wished Git supported the zsh '**' wildcard to match anything=
,
including slashes.  Here's another case where it would be useful - to
match *.txt everywhere, you'd use ".../**.txt", and it leaves you the
option of using ".../*.txt" if you really want to find *.txt only at th=
e
root level.  Of course, it may be very difficult to implement...

James
