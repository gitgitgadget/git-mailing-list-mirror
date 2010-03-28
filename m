From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-export: don't segfault when marks file cannot be 
	opened
Date: Sat, 27 Mar 2010 23:45:18 -0600
Message-ID: <fabb9a1e1003272245gc1de70ar216997ca11bc2038@mail.gmail.com>
References: <1269754968-24961-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 28 07:45:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvlJh-0000XR-4Z
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 07:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0C1Fpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 01:45:40 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38339 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab0C1Fpk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Mar 2010 01:45:40 -0400
Received: by bwz1 with SMTP id 1so2774390bwz.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 22:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=XHZv2gLCTp6vYi+xWDH4JKUu2gYBtWPJE23y9kcCkCA=;
        b=Qb0Vf3ApP1OsiitIu6AlWEOC2CiG+zBGI0mUzVAh7e8J6exDkYGOPlRAGUHCyWV+6V
         jdz7gI6ADrCS4Hj41vU9p50DlAKivofAHsqdDWXquay0zvrSNTRaZeqouCKXKqkMRM1Z
         ffmHMl+f9UBacMlBR3WA9qtzNNrtqoUc1YODM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=KpSsPi9f4rqU/O4gqnQZ/6FNjoMZZQKRkCNK/i5hBPag924oAp8OMV1p/r+u5+8mZJ
         Qa0m+5+B7YSmyt3GCv0S8x21dU8IjP/AEDWr3CSdy6CRIVt5x4VNqjLsAqTAshdaEE3n
         KbzSq1RUDlHtZrCAuueZ5NBYZu7Fuf8ecbYGY=
Received: by 10.204.142.7 with HTTP; Sat, 27 Mar 2010 22:45:18 -0700 (PDT)
In-Reply-To: <1269754968-24961-1-git-send-email-srabbelier@gmail.com>
Received: by 10.204.134.70 with SMTP id i6mr4544248bkt.74.1269755138258; Sat, 
	27 Mar 2010 22:45:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143378>

Heya,

On Sat, Mar 27, 2010 at 23:42, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error("Unable to open marks file %s for=
 writing.", file);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("Unable to open marks file %s=
 for writing", file);

Heh, and of course I manage to mess up a 3-byte patch. The '.' removal
shouldn't be there of course.

--=20
Cheers,

Sverre Rabbelier
