From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3] parse-remote: handle detached HEAD
Date: Mon, 6 Dec 2010 18:14:47 +0100
Message-ID: <AANLkTi=jf5ZB8Lz3jRN-HJ8mquFt4frhFk0mZ4sCHwZk@mail.gmail.com>
References: <7vfwubtw1g.fsf@alter.siamese.dyndns.org> <1291630811-16584-1-git-send-email-santi@agolina.net>
 <7vr5dusxb1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 18:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPeei-0002TZ-4U
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab0LFRPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 12:15:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40062 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab0LFRPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 12:15:08 -0500
Received: by yxt3 with SMTP id 3so5610549yxt.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PgJaBKZDpwb46IwJOYtlv/l2wuHX8P6gwMYmpK3ybMI=;
        b=reroSXzHG/SO6bLoCGcnEPoYjqXYkaz5b/JEH01FTtrRZgEMGWG7FyQU0/lc387v38
         I0nuVwzL5OsaRIinF2Liscz3Mag2w3SA8FNfRb4cm8ygHySxWcyxODGB2BDfl5FCqC3k
         b0iHyASSBSZx4CkIlJ6VqOlPW3BJPd+DvmFbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WXqIjSkRKdraasWARfRaX2IFH9jRJuk5OrkclPvyV2IjPCFW1Sx4kAQ6BbiF27/DCB
         HCWpt7R+b+MnSfLHdiQQRbHP36U+vIrtfI1K1XCEpaKo1BXvqshf4tyDcBYdxMXep5mz
         WNTIoKf8T7g0lb89HvGzswzBnBfqDFffPlRko=
Received: by 10.150.196.17 with SMTP id t17mr9671252ybf.302.1291655707206;
 Mon, 06 Dec 2010 09:15:07 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Mon, 6 Dec 2010 09:14:47 -0800 (PST)
In-Reply-To: <7vr5dusxb1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162999>

Heya,

On Mon, Dec 6, 2010 at 17:03, Junio C Hamano <gitster@pobox.com> wrote:
> So this should be Ok. =C2=A0Sverre, do you want to do another round o=
f testing
> just to be sure before I apply this?

Yup:

Tested-by: Sverre Rabbelier <srabbelier@gmail.com

--=20
Cheers,

Sverre Rabbelier
