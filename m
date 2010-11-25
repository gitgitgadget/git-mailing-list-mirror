From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v8 1/5] Introduce bulk-move detection in diffcore.
Date: Thu, 25 Nov 2010 11:08:07 +0100
Message-ID: <AANLkTi=Ekoe+RSrRFj63S___Vsa5kTsDKJVPamFsz0c2@mail.gmail.com>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
	<1288303712-14662-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Nov 25 11:08:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLYki-00043A-G9
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 11:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab0KYKIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 05:08:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47502 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab0KYKII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 05:08:08 -0500
Received: by fxm13 with SMTP id 13so609318fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GEuW/DrEjDr+ynzjCcZzIVve0GHUBKzfvROoqwTWIrw=;
        b=bNzYP9LOlg674rzSg2Y4/qn2/cUoM0X8WlyJwo/8FdzBX3ljQhts29BuO4jtUYwCjM
         NnKryUCP8oMD8oWEqpyz29cilzQQ3Zyksk204KYHw6M5vrbpHWfl7D8+xg21emAewoOE
         PgRbXmam7eh+MlI1WwTAVI061O187d6B1LzuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lXC7fVpzS9xdkjB7W5TIlYzzDIbmP3gJN+4JY4ASpLIpUsPgmP9k6FheJfmXLoDJez
         L2BXFwDi92VLwo0EQQzdjGCMz/YE5uZBdEpA1HM3m0KrhnDEZSI0eQeMN5qZncmDNw5s
         QU2JP9iDWm2JhgSbDI2jgwV1Re8dhahbszXVs=
Received: by 10.223.74.11 with SMTP id s11mr513058faj.11.1290679687541; Thu,
 25 Nov 2010 02:08:07 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Thu, 25 Nov 2010 02:08:07 -0800 (PST)
In-Reply-To: <1288303712-14662-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162121>

On Fri, Oct 29, 2010 at 00:08, Yann Dirson <ydirson@altern.org> wrote:

> + =C2=A0 =C2=A0 =C2=A0 slash =3D memrchr(src, '/', len);

I can't compile pu now on Solaris due to this bit. Are you planning on
picking up the patch / configure / Makefile detection discussed in the
"[PATCH] compat: add memrchr()" thread? Just wondering what the
progress was on that.

Thanks.
