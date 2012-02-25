From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-objects: Fix compilation with NO_PTHREDS
Date: Sat, 25 Feb 2012 16:24:42 +0700
Message-ID: <CACsJy8CrVEQ+vCXyXhGry5tRwYoyc7NHeOJg7UXCTPF+50sexA@mail.gmail.com>
References: <1330157769-7884-1-git-send-email-michal.kiedrowicz@gmail.com> <7vty2fffpp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 10:25:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1DsX-00083S-P4
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650Ab2BYJZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 04:25:15 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41948 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab2BYJZN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2012 04:25:13 -0500
Received: by wibhm11 with SMTP id hm11so409945wib.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 01:25:12 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.14.73 as permitted sender) client-ip=10.180.14.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.14.73 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.14.73])
        by 10.180.14.73 with SMTP id n9mr12063438wic.16.1330161912311 (num_hops = 1);
        Sat, 25 Feb 2012 01:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bs/DAcacFyV2ZPDXeb+BcM5am+p8rWWTm5XENkWvPp8=;
        b=kUwj3gOTxOymrSSq5a9O/uPR0qLFA6SRfFq7cGUYKnpd5DSsCBc/fx+G031HTwRW8S
         ed2y3ACqhsnHZrBOpX+XjGayEWG66AJERGJRDE0R6HriGpO+izF7t+t0/4J60ai8gLVJ
         5bShYZtu+QIqf9kKtC6c9+jTLi+4pu3RziQUM=
Received: by 10.180.14.73 with SMTP id n9mr9644266wic.16.1330161912269; Sat,
 25 Feb 2012 01:25:12 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sat, 25 Feb 2012 01:24:42 -0800 (PST)
In-Reply-To: <7vty2fffpp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191512>

2012/2/25 Junio C Hamano <gitster@pobox.com>:
> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>
>> It looks like commit 99fb6e04 (pack-objects: convert to use
>> parse_options(), 2012-02-01) moved the #ifdef NO_PTHREDS around but
>> hasn't noticed that the 'arg' variable no longer is available.
>>
>> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
>
> Thanks. =C2=A0Nguy=E1=BB=85n, a quick double-check and an Ack?

Tested and acked.
--=20
Duy
