From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/3 v2] tests: factor HOME=$(pwd) in test-lib.sh
Date: Wed, 1 Sep 2010 07:56:47 +0000
Message-ID: <AANLkTim6Cb4vegGYG0ZtJxXvAwBxHYGOY7bQFbGSAcXV@mail.gmail.com>
References: <vpqhbibbthi.fsf@bauges.imag.fr>
	<1283210123-19752-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTik7d9Rhx5NudeKvVMFAYvVhGxoYzK2y+g3CP=Zj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 01 09:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqiC0-0001Z3-0g
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 09:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab0IAH4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 03:56:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57504 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab0IAH4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 03:56:48 -0400
Received: by iwn5 with SMTP id 5so6589855iwn.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ratytwe0NNxfOlgi6IfuheoyGbtBFeXVKCTGvAuYeCU=;
        b=afWPur2/eCU/lbO0ePhGAD77rqnssPCkgr63SawmKVbEiNWNeapwd+fiGFgOJIo5pR
         b+oOdb87ryMkbBPDEFnwxctLWwhE0XJWUiIKkiqwDpgrktGmPUfUAVXI+XbRBpfTWUbq
         njdl1tMmS2zyUWCW4Owk15LayTdT52oo8UimY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kpHivWFvmF4/Yj2AfxQvONFZMh4T1VxctNdkwgBzf5rlOuDxOzbsrzRGa8/L8vMQ9N
         JkiQ03NPVr0El2t8c71S/MPaLCy9w2mCcrtvXpYn2x9V09ccJjjjOcl8XCyxp49uSCvV
         wtAQ0n73VHq6SdQ8F4dD+XbhL2Z2pBG80sTxw=
Received: by 10.231.39.196 with SMTP id h4mr8308478ibe.64.1283327807193; Wed,
 01 Sep 2010 00:56:47 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 1 Sep 2010 00:56:47 -0700 (PDT)
In-Reply-To: <AANLkTik7d9Rhx5NudeKvVMFAYvVhGxoYzK2y+g3CP=Zj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155022>

On Tue, Aug 31, 2010 at 07:42, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 23:15, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
>> The same pattern is used in many tests, and makes it easy for new on=
es to
>> rely on $HOME being a trashable, clean, directory.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Just re-ordered the patch to make this one the first.
>>
>> I took =C3=86var's suggestion of using $TRASH_DIRECTORY instead of $=
(pwd).
>
> Thanks,
>
> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Junio: FYI you picked up v1 of this for next/pu, not this v2.
