From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] topgit tg push feature
Date: Tue, 12 May 2009 10:55:50 +0200
Message-ID: <36ca99e90905120155x1954bdf2n2cd015dd0c28af3c@mail.gmail.com>
References: <20090507045904.GA2068@gmx.de>
	 <20090507084355.GA11680@pengutronix.de>
	 <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com>
	 <20090509103625.GC13344@lapse.rw.madduck.net>
	 <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de>
	 <20090511195532.GA28340@pengutronix.de> <20090511210614.GA6118@gmx.de>
	 <20090512051334.GA22757@pengutronix.de> <20090512075413.GA7764@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 10:55:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3nmJ-000328-28
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 10:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbZELIzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 04:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZELIzw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 04:55:52 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55492 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZELIzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 04:55:51 -0400
Received: by fxm2 with SMTP id 2so3179656fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=1ubbWdeDfhRbSCjh3Xd7EX1ujpydewiI5WT9UBGaOF4=;
        b=mESqNAHM8dPh6ZbVUYBz/CxlsXA356KNuFKf4PR05ntJR0SQPMwlEWHuiDO7H6v2x3
         PG8bxn5J/B+Ipe0NTCpTmFlv4Y20TIwDL0eSp2kZDzswoLkpe8coFftwUM57QhIAeTne
         ZndBOqyMBDHmhbN0/0cF0hrvDFPOKTuxWMpb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=VYkcCwDomBxwzigJZuGPZw0ZoSXBynSZ4U+DjJQicmFom+5hTcSf8Sx3iyv8HQSbx6
         6H84dPTJLZzwm3U1QBIwOtbY8pspIrgMCur5ec7ajogyrBf7xRxfBsrvaNZV/HUHQc9w
         /PfB7JE71N7nbbtmFJ8xgobKxao2l5/XYlLiI=
Received: by 10.223.122.141 with SMTP id l13mr3113521far.99.1242118550795; 
	Tue, 12 May 2009 01:55:50 -0700 (PDT)
In-Reply-To: <20090512075413.GA7764@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118882>

On Tue, May 12, 2009 at 09:54, Marc Weber <marco-oweber@gmx.de> wrote:
>>That was my intention my asking for the -r option. The -r option is t=
o
>>'tg' not a tg-command. And it's still not addressed.
> Bert: You're wrong:
>
> tg.sh contains:
>
> =C2=A0base_remote=3D"$(git config topgit.remote 2>/dev/null)" || :
>
> =C2=A0[...]
>
> =C2=A0if [ "$1" =3D "-r" ]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shift
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z "$1" ]; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "O=
ption -r requires an argument." >&2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base_remote=3D"$1"; shift
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tg=3D"$tg -r $base_remote"
> =C2=A0fi
>
> So base_remote is set by config first and then overwritten by the fir=
st
> -r flag. my remotes is initialised with that -r flag.
Ahh, thanks for the pointer, I haven't seen this line.

Unfortunately I haven't tested it yet. But I'm looking forward to use i=
t.

Bert

>
> Marc Weber
