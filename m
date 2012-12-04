From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Tue, 4 Dec 2012 14:20:20 +0700
Message-ID: <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com>
References: <201212021417.25525.tboegi@web.de> <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 08:21:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfmoV-0003XA-5V
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 08:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472Ab2LDHUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2012 02:20:51 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61106 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab2LDHUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2012 02:20:50 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so3445362obb.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 23:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+CVS5uK+OtiaiMstNHNTHhJ8yS8mbZf6AYN4IwCW8JM=;
        b=udycnAkzMJ6eHYHPWJkiX2E3UfjbUlY46qnTPqOtgnOAHclReX1T/B+SuzonBjdkCh
         /g1RNCBJoYR/rxjUT1k3ktBsuzDejPGDfvTcUy8GKuljIty8Qm+FGd6r9nmEwhoxbs8Z
         9mAh0y2Hn0nU4UNGOtZSDIE4ezzjRr6wledS3S4GPIAYKM+sUbT99Vy1TLqCuXl/HdcG
         ghzXNb03DJymP3uQn/8IkgLAYWpyMG8f/hlBNLOGuRKMZ4vMxb1xjDam87fLdA5ZACf5
         L1WNy87OTXfSdf9GMQ2uEIWeCLSxocmTpuBK2bE9jY+jBNUBSoAkjhYdmWrAOr7IXfgt
         WL4A==
Received: by 10.60.172.178 with SMTP id bd18mr10894655oec.133.1354605650190;
 Mon, 03 Dec 2012 23:20:50 -0800 (PST)
Received: by 10.182.237.70 with HTTP; Mon, 3 Dec 2012 23:20:20 -0800 (PST)
In-Reply-To: <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211069>

On Mon, Dec 3, 2012 at 11:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> The test suite needs to be run on different platforms.
>> As it may be difficult for contributors to catch syntax
>> which work on GNU/linux, but is unportable, make a quick check
>> for the most common problems.
>> "sed -i", "echo -n" or "array in shell scripts"
>> This list is not complete, and may need to be extended
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>> We add 1 second test execution time
>> Is this a useful idea at all?
>
> Please do not name it after t/t[0-9]*.sh pattern, which are about
> testing git.
>
> This (once it gets cleaned up to reduce false positives) belongs to
> "cd t && make test-lint".

Or a project commit hook? We can see how it goes and whether we can
improve anything for projects that rely on hooks.
--=20
Duy
