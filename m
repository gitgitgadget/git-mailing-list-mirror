From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: add option to show whole function as context
Date: Sun, 31 Jul 2011 19:34:12 +0200
Message-ID: <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com>
References: <4E357BE2.8030409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jul 31 19:35:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnZum-0005Ko-A3
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 19:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab1GaRey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 13:34:54 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55357 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1GaRex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 13:34:53 -0400
Received: by pzk37 with SMTP id 37so9948783pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AQElfDaXZyyZamZy14XxXRG8o6TcdU3z+l4qGxyf9xo=;
        b=wpsr21tt9qFbcLBviYF6ngR+5QcMhYWDI2gnDHqzinovIhzCBAQagU2yAm+F5cyOrs
         FvLEO4vemtrHc6oXDQoK42S4hmyzOahG0lxBVPEOaAzcbvRiTDKZasXSTRC1FdLhLnYq
         RX4qVAPny1CthG87Rz8eCGKBaihAAGZ6MKyFY=
Received: by 10.68.10.202 with SMTP id k10mr6058534pbb.511.1312133692058; Sun,
 31 Jul 2011 10:34:52 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Sun, 31 Jul 2011 10:34:12 -0700 (PDT)
In-Reply-To: <4E357BE2.8030409@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178267>

Heya,

On Sun, Jul 31, 2011 at 17:59, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.=
ath.cx> wrote:
> Add a new option, -S, to show the whole surrounding function of a mat=
ch.

Perhaps a different option name so as not to conflict with the -S from
'git log'? It would be nice to have this available in 'git log -p'.

--=20
Cheers,

Sverre Rabbelier
