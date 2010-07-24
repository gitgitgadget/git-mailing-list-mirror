From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/6] Makefile: Add coverage-report-cover-db target
Date: Sat, 24 Jul 2010 23:28:57 +0000
Message-ID: <AANLkTincK7b3gLVUfD5cfvU6OOeTwyLcd0o2U5LSYp-L@mail.gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
	<1280004663-4887-5-git-send-email-avarab@gmail.com>
	<201007250101.26577.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:29:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oco9P-0007Nl-Dh
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab0GXX27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:28:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38642 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab0GXX26 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 19:28:58 -0400
Received: by iwn7 with SMTP id 7so1530177iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DlUxMDe+j9ovI0bK5xBQESagjmk/Wiu0cuPMGFDQxwo=;
        b=Wf7+hkE7mcWB6/x0E8X5LLGp47dSy60Yv3Brs2nio/2SRdUgngxdoH7qKNjAjfH55e
         hPBUa4KQe/exI+qi6kXwUJDcIgjgfysMSmr9UnnzPJK1YHYssve6JAauscgtUYZq+ykq
         1SvTxgGUa2Hj53hBzjM3g0lg7vKaSxLCasXu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SPf7libuvg8tdLgqF2P6FPQoiP+Xm+Nb5+StTW6q/1jPdjsXCXfLXRPIfpDQ8uNy0z
         aY1iU0lchB5rlNPl/y+Bpv5c3InthLRWm38NzUw6z9is2dSxSPU+cmH/7dh9r/qB9pNO
         gl5C1SatdKoQbN8P+1C9yf1WKdGZcA1y2ZqdM=
Received: by 10.231.191.74 with SMTP id dl10mr6090514ibb.157.1280014137876; 
	Sat, 24 Jul 2010 16:28:57 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 24 Jul 2010 16:28:57 -0700 (PDT)
In-Reply-To: <201007250101.26577.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151687>

On Sat, Jul 24, 2010 at 23:01, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> +
>> +coverage-report-cover-db:
>> + =C2=A0 =C2=A0 gcov2perl -db cover_db *.gcov
>
> I think this either needs a dependency or .PHONY.

Will fix, thanks.
