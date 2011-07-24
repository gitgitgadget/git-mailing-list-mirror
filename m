From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/2] Add a test to check that git ls-tree sets non-zero
 exit code on error.
Date: Sun, 24 Jul 2011 19:12:18 +1000
Message-ID: <CAH3AnrrH3YcvzxPo=gdXavUh-yMsXcZ6UND4j=uvvC7Cbnmqng@mail.gmail.com>
References: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
	<1311469670-15392-2-git-send-email-jon.seymour@gmail.com>
	<7vipqsw29v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 11:16:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkunA-0005RL-UK
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 11:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1GXJMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jul 2011 05:12:20 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54190 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab1GXJMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 05:12:19 -0400
Received: by vxh35 with SMTP id 35so2344312vxh.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7ZY0M8wfItddKNZ535S71d1jGNgrKNA1f4Cz5vJwzfg=;
        b=nDpw2xZwbeHAlvM5AS7FyNfSLoeTuMTl9W+IxYGat6njHegOfQ18sjr60dgaCc4a/Y
         ga7GU2ee+d/hLD1NaXBWrm7+rZ5teIfI97bu2cTELUySUOiPo1/lQ2c/QWcVbiVmHefy
         ptC8g90Mn8gjAq9sIesqKoRIgfn9e93OVSmKQ=
Received: by 10.52.24.77 with SMTP id s13mr3188049vdf.508.1311498738497; Sun,
 24 Jul 2011 02:12:18 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 24 Jul 2011 02:12:18 -0700 (PDT)
In-Reply-To: <7vipqsw29v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177735>

On Sun, Jul 24, 2011 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> =C2=A0t/t3103-ls-tree-missing-tree.sh | =C2=A0 19 ++++++++++++++++++=
+
>> =C2=A01 files changed, 19 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100755 t/t3103-ls-tree-missing-tree.sh
>
> I'd rather not waste a new test number for something trivial like thi=
s.
> Don't we already have a script that tests ls-tree?
>

Happy to take suggestions about which other test I should modify to
include this one and how that should be renamed (if at all).

The other tests t3100 -> t3102 are all currently quite coherent and foc=
used.

Perhaps a rename &/or merge of existing tests is required?

=46YI: t31xx has quite a lot of head room (e.g. there are still 96 name=
s
available in that space)

jon.
