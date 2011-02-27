From: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 00:33:07 +0200
Message-ID: <AANLkTik+MPPYOm+O5cmFur_2DKKy0bt9i0XeuKbHbaJU@mail.gmail.com>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
	<4D6A6291.8050206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 23:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtpAw-0001Zg-Vw
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 23:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab1B0WdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 17:33:10 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52962 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1B0WdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 17:33:08 -0500
Received: by qyg14 with SMTP id 14so2894914qyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=/LGAaUhMPVgWE8EQSnlCa45YimSnxScbNRolP7Ny43U=;
        b=aPbzBCeTyciqc3vxV6KGscZcUE2GYZPjE6XlJNFJqADOFFQ0kiPKf6Yq/92W75muin
         y5EXlKcFB1Jsw60s98cZMiReSr43cl+WuZZpN9R4Mf1+nX/rEjsAD13xQAR+Dzw9wE6X
         qsgUkNKY0ff4SEBV32Z4D8ip0KL+Rag5XGsMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=p6l0MBX4rZKVWXZjpB/M0RWmRhNZ3OibsKDV0NGuGNopJfn1OYsdQQnsQbC1d69M16
         DLx9Iq+ogQuamZ+vtATGOXfYlw7S3i4C5xOIVj+g93X18jF5bjMQB0pyNrlGkzLfgwAY
         QSYFPu4eHcLIPf1ig29S1SV2nNqFJUlnUgSSE=
Received: by 10.229.90.148 with SMTP id i20mr1791403qcm.280.1298845987596;
 Sun, 27 Feb 2011 14:33:07 -0800 (PST)
Received: by 10.229.192.14 with HTTP; Sun, 27 Feb 2011 14:33:07 -0800 (PST)
In-Reply-To: <4D6A6291.8050206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168057>

Junio, jokes aside, do you think this is useful?
Would you accept a patch that implements this?

Micheal, thanks for the indirect + :). Is it +0 or +1?

Best,
MS

On Sun, Feb 27, 2011 at 4:41 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 26.02.2011 21:11:
>> Mart S=F5mermaa <mrts.pydev@gmail.com> writes:
>>
>>> Paging through deletes adds a cognitive burden when reviewing code.
>>
>> Wasn't the ability to say '/^diff --git ' in your pager invented for
>> exactly for that?
>
> Wasn't the pager invented for sifting through output which has to be
> several pages, but not not for that which could be more concise? ;)
>
> In fact, -D would be quite analogous to -M and -C in that respect.
>
> Michael
>
