From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2] test-lib: TAP compliance for skipping tests on request
Date: Mon, 12 Jul 2010 11:07:05 +0000
Message-ID: <AANLkTimAu6H4hK-WEhjrGDr5CICWzB_wxrD-GgrBtdKe@mail.gmail.com>
References: <AANLkTiml1lQlSBDGgUg9scsvsaffDT2n405USmsSIm1n@mail.gmail.com>
	<82aab66bffd86b562c76a13a4666d3cf22a64cca.1278930335.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 12 13:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYGr2-0000Vm-2e
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 13:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab0GLLHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 07:07:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50445 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0GLLHH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 07:07:07 -0400
Received: by iwn7 with SMTP id 7so4517066iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cmbCGFC0Vo79S3j8Z60mAQpNqpQR8wOMEa5Q+1QuQZ8=;
        b=MFvWQu4xWI43qYxfzgnYSYFLoxAsdRylZyVobRC+eVosxhtqgRGILTs8aJaznCbbtj
         9WeIhJhO/Q1ZOk4oUsVFQv6OpwQ/dNHgdIWXVAdh6F1oe3dU81rEpZSVZk8L+WO50hr4
         Mb7zTfctr3TxCDGV4HdkcAeLH3HIJarGMyTzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FzfnP5ghQ9kQ7ubathSN4MXL650UWMzmfVrqA3/l/mQVbguP41V0cS8m8Gm+mFgUkv
         WfY/3e4o+oR+2JbvkUnm3kOxjmMZPKGnrjf4juYQYqUQo56+e7ETDPhISrmbc/LXGoUP
         d8DwNprAkkfnsT4P8vvMBGl18JOlHa6c6xtcQ=
Received: by 10.231.176.16 with SMTP id bc16mr15015241ibb.4.1278932825238; 
	Mon, 12 Jul 2010 04:07:05 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 12 Jul 2010 04:07:05 -0700 (PDT)
In-Reply-To: <82aab66bffd86b562c76a13a4666d3cf22a64cca.1278930335.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150811>

On Mon, Jul 12, 2010 at 10:33, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Make the output TAP compliant for tests skipped on request (GIT_SKIP_=
TESTS).
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> v2 has a typo fix in the commit message and the spelling of "skip"
> as suggested by AAB.
>
> I think I've read it differently in the RFC, but then I was also conf=
used about
> the "#" in the RFC, and following the "reference" implementation (as =
per AAB)
> should be the best approach.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
