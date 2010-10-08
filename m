From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepan.nemec@gmail.com>
Subject: Re: [PATCH 2/6] Fix odd markup in --diff-filter documentation
Date: Fri, 08 Oct 2010 19:57:15 +0200
Message-ID: <87bp74tvno.fsf@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
	<1286559080-27257-3-git-send-email-stepnem@gmail.com>
	<20101008173941.GA13738@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 19:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4HD7-00083c-ND
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759228Ab0JHR6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 13:58:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45374 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759177Ab0JHR6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 13:58:19 -0400
Received: by fxm14 with SMTP id 14so643199fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=sxomDlB+DDDneO9fyluKMC01Bm/r7J2TTTqjc9vpv1Q=;
        b=ibOMfAKJ8GB+Mw39/1GGEI6Bv1i2oUZ8Y3VoxUPcl8D6QcI1EbaW3Ptbs1amnFijPl
         3pkugz3M6J0a0QQ4NqTBUvHYxHFK6KBX5M4gDAIUR6jeUCL/mn2BuvcidXaC0yK9LlBf
         YIUglhdf2Q0ZrqHRZvL4bhnhz3WL5JebM8xaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=uTNb22JDLTUN2C5oOFqemEpHvOtrnMjkFk5QHVp9A2PFP1U3kgMmlVcwec1W4zW57b
         rO0mQHBqBlLcridLgA112ZbAsTh6VGEkPUxnm0lDrc36oiponqZUPZs+h0JCH1UqZTmf
         TR19CxMv/J6qnkM/nGQY/rcoKswwlYAouzCVo=
Received: by 10.223.1.133 with SMTP id 5mr3623144faf.18.1286560697737;
        Fri, 08 Oct 2010 10:58:17 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id p1sm939734faa.17.2010.10.08.10.58.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:58:16 -0700 (PDT)
In-Reply-To: <20101008173941.GA13738@burratino> (Jonathan Nieder's message of
	"Fri, 8 Oct 2010 12:39:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158517>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
>
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -248,13 +248,13 @@ endif::git-log[]
>>  	If `n` is specified, it has the same meaning as for `-M<n>`.
>> =20
>>  ifndef::git-format-patch[]
>> ---diff-filter=3D[ACDMRTUXB*]::
>> +--diff-filter=3D<spec>::
>
> Maybe something like
>
> --diff-filter=3D((A|C|D|M|R|T|U|X|B)...[*])
>
> to keep the overview while following the conventions you've set out?

Looks good to me as well, thanks.

> Strictly speaking, --diff-filter=3D (with empty argument) is allowed,=
 too,
> but I don't know if it's worth fitting that in.

If it provides some kind of useful behaviour (I don't know and you
didn't clarify that either), then it should be documented I guess?

=C5=A0t=C4=9Bp=C3=A1n
