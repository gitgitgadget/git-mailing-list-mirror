From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 8 Oct 2009 20:15:58 +0200
Message-ID: <40aa078e0910081115q1bf924e8s22f3ee11dbe7c8b7@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
	 <4ACD8D8E.3060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:22:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvxdZ-0000lw-GP
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 20:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbZJHSQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2009 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759169AbZJHSQg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 14:16:36 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:36955 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759159AbZJHSQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 14:16:35 -0400
Received: by bwz6 with SMTP id 6so1029210bwz.37
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sMO8IraN5Kgb/Y9NUn4AwoRUfaL//7QFFyTYyY9V+Tg=;
        b=gki9L5Q0cXG+PmnAG3IuBdQEm2i6sEwrH8NM0kNSHnnaLMgU9JSmhIkiTKFGHMkb8n
         RQKBPlp05V4UXhL5/GOZUGOnno35SolrloxQ1KOB877MuYXoMw/gYFdERKbluvMM69my
         IDP2uUEEztle4ltFuM29o5YHQKZnJ1P5lkhLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=al4h7OW5eNSfUHmdcK2m/Tmzq6FtyPwpCYn50RTyVTRwZiy5AMaHqTXheW7k4fz09s
         ygGboxRtImcvYyEnFx2gD1iAVlPTifgDV0fC3aYayLtSppp+/0+lnAFQnKgkaBGhpudR
         ntKdp8XJkb9mCBKSkU1Wn1ffLbOmrja/rPvQs=
Received: by 10.204.26.134 with SMTP id e6mr1320422bkc.87.1255025758418; Thu, 
	08 Oct 2009 11:15:58 -0700 (PDT)
In-Reply-To: <4ACD8D8E.3060606@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129710>

On Thu, Oct 8, 2009 at 8:58 AM, Marius Storm-Olsen <mstormo@gmail.com> =
wrote:
> Junio C Hamano said the following on 08.10.2009 08:33:
>>
>> * ef/msys-imap (2009-10-03) 7 commits
>> =A0- mingw: enable OpenSSL
>> =A0- mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
>> =A0- imap-send: provide fall-back random-source
>> =A0- imap-send: build imap-send on Windows
>> =A0- imap-send: fix compilation-error on Windows
>> =A0- imap-send: use run-command API for tunneling
>> =A0- imap-send: use separate read and write fds
>
> Don't forget about the MSVC patch ontop of this series:
> Message-ID: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.=
com>
> Subject: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto

I will include it in the next round I send out (unless someone objects)

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
