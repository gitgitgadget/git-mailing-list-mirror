From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 15/17] po/is.po: add Icelandic translation
Date: Tue, 31 Aug 2010 10:29:59 -0500
Message-ID: <20100831152959.GH2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-16-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSoa-00078Z-Rn
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab0HaPbw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:31:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33910 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab0HaPbv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:31:51 -0400
Received: by fxm13 with SMTP id 13so3990180fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CSnLryr6g0buI+XcLjUUVAzuHnVfKmCxsJS317kI51A=;
        b=Xte9U1JNb+eHfCWMz6Kn5Ijmp79brilkH3UbClO8OgbILT0YybzaABtUQmkuDRhBW9
         3p8e4fgzXlIiR5HgN5DbolWu1bpEU2JtmzdnUzXcbTAnqizEH/L/MRZWB0UNcRm66Qy1
         UbMlgecn74h9aV0xqmW9FemUPhbhlUEg7HKt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ebaqkyiUKllHVZ/HvlCeivOB4efJvMglroSng06lxQV0d2tUWDFc6v6P7K5jGEVa6A
         ZaFDq3G+pu+mUtDYAVIv2SWAX9oSUqyTpAx65XkFiTzYaGDKNOWCQenPvcbBu/KP3tTd
         oaSjMujUJh7jwJAUzCOQ5G0JMV1o5bPo4Pv3w=
Received: by 10.223.119.198 with SMTP id a6mr5565031far.66.1283268710587;
        Tue, 31 Aug 2010 08:31:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r4sm4020689faa.43.2010.08.31.08.31.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:31:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283203703-26923-16-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154912>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/po/is.po
> +++ b/po/is.po
> @@ -11,35 +11,154 @@ msgstr ""
>  "Content-Type: text/plain; charset=3DUTF-8\n"
>  "Content-Transfer-Encoding: 8bit\n"
> =20
> -#: t/t0200/test.c:4
> +#: builtin/init-db.c:34

Is there a diff driver that will ignore these --add-location lines?

Alternatively, would it be possible to get msgmerge and xgettext to
provide the filenames without the line numbers?  My experience is
that most translation diffs are very hard to read because about 80%
noise. :(

Aside from that, this looks good and sane (well, the English part
I can read does).
