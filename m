From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 11:53:28 -0600
Message-ID: <20101114175328.GG26459@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
 <20101114172331.GA26459@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgmG-0003Kx-1C
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab0KNRyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:54:03 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42221 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487Ab0KNRyB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:54:01 -0500
Received: by gwj17 with SMTP id 17so676670gwj.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MOAuqP7Q6+4fBg5AKyduesQPf6sVkNavWfKZGi0DQzo=;
        b=qUTyvJKN4LSa/sWW6D5u2/XGEwB2qa/bFJOerNcY0uvDCY0UhNrViMOZmpD+cpZSQP
         lXBYR5EEgagN/qiZS2JtEyyJxnj7WZgsB/vK4HQ4Olt1txX/PzrwcbC/nPHUXWTGVVZs
         SICT2Dis6N45bclKVltIkii50LzVOiiaTGGW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=t28FjxiZbCXZPKP+EInNEl9a+zYx+p7X05nTw2mHnzit6o11ODG6kJaY32XrRwH6EE
         X42G1q1H9tFwnCRbelN83DcaIYbUznuT2XSFFQuF53QrMbPQskKmgU9FkOo2fApiOSUq
         ZTsUhRZkR4BN3bK7tnytR44tdfojtIk/QgGSg=
Received: by 10.90.88.20 with SMTP id l20mr6551777agb.57.1289757240818;
        Sun, 14 Nov 2010 09:54:00 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v2sm3939748yhg.28.2010.11.14.09.53.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:53:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101114172331.GA26459@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161428>

Jonathan Nieder wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>> In the ab/i18n series I only want to build gettext.o (by adding it t=
o
>> LIB_OBJS) if NO_GETTEXT is unset. It's not possible to do that witho=
ut
>> an ugly hack if we haven't applied our platform specific tweaks befo=
re
>> LIB_{H,OBJS} gets assigned to.
>>=20
>> See <201008140002.40587.j6t@kdbg.org> (subject: "[PATCH] Do not buil=
d
>> i18n on Windows.") for Johannes's original report, and my follow-up =
in
>> <AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com> where=
 I
>> suggested that the problem be solved in the manner of this patch.
>
> This doesn't motivate the patch all all to me.

Erm, sorry for the gibberish.  For "all all", please read "at all"
or "clearly enough".

Jonathan
who ought to slow down his replies; please feel free to point
out when I send nonsense like this so I can see when the rate-limiting
is working :)
