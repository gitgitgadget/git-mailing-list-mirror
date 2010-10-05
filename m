From: Stephan Hugel <urschrei@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 5 Oct 2010 01:17:39 +0100
Message-ID: <AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
	<201010041851.46838.ComputerDruid@gmail.com>
	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
	<201010041959.48336.ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 02:17:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2vE2-0003sJ-W6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 02:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab0JEARl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 20:17:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39758 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0JEARk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 20:17:40 -0400
Received: by wwj40 with SMTP id 40so4900169wwj.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xY76wXHOEgKI9I67TtvEwbaHVQ63u2HyUl36lSyWfgs=;
        b=vldvheuuqXBVFbjBd3tqxuiMDsChOJ2G80mKkar5mC5sdmxjyz/s+bf7dmXrI8SALE
         0FFxlwAd+2++E3TCAI6k1UW+Ch3BVkisrkH6IbjKxVIIYUlmIOwkNMHSgkqEbyKFr7Ms
         7K6bWUNfpT+qk9mKPnN0ItsJWrF/ydM72ywQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MM7vrsnkqi62zE3RZhsApyQGqUjK+j0iSXc4yl4h26HCQG4XMyY83Hyj8OqwzoVQ5H
         ajKPpYji7MYet+yXPhsvzzlJCSqjuTgBkQe0X9+SiTUuA9JfE/5RIAgw5CnzBDtgasPq
         ghgqAnzuuq76/6FuzQzPXQKp63lN+JZr/cu+Y=
Received: by 10.216.10.11 with SMTP id 11mr305934weu.64.1286237859127; Mon, 04
 Oct 2010 17:17:39 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Mon, 4 Oct 2010 17:17:39 -0700 (PDT)
In-Reply-To: <201010041959.48336.ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158146>

On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com> wrote=
:
> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>> Daniel,
>> Those are the exact steps I'm using.
>>
>> When I run tag -v on existing tags, I don't see the
>>
>> -----BEGIN PGP MESSAGE-----
>> Version: GnuPG v1.4.9 (Darwin)
>>
>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
>> yZeXw/EddYrfdad/VvOrL1o=3D
>> =3D/0PJ
>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>
>> block. It's only present on tags created using the current version.
>> I've also just upgraded to GnuPG 1.4.10, but the result is the same.
>> I'm not sure how else I can determine where the problem arises; I'm
>> using the git and GnuPG versions for OS X built by homebrew, and Gnu=
PG
>> is happy to use the same key for en/decryption and signing. I've als=
o
>> verified that none of the subkeys are expired, and that the trust db
>> is OK.
>
> If you have the tests available, can you try running t7004 to see if =
it fails
> there too?
>
I rebuilt and installed from source
Passed all 105 tests in t7004-tag.sh
Problem remains with tags I create

This would seem to imply a problem with my key, even though nothing
else is complaining about it.
--=20

steph
