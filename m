From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>
Subject: Re: [PATCH v2] completion: fix issue with process substitution not
 working on Git for Windows
Date: Thu, 27 Oct 2011 08:26:37 +0200
Message-ID: <CAJzBP5TTR8VCidGmWT4a4Gk91=D5rgXMKoSpyuSFe8tOcLwRNA@mail.gmail.com>
References: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
	<1319656389-9515-1-git-send-email-stefan.naewe@gmail.com>
	<7vipnb1myv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: spearce@spearce.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 08:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJJQJ-0001RA-CL
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 08:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab1J0G0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 02:26:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43298 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1J0G0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 02:26:37 -0400
Received: by ywm3 with SMTP id 3so2328812ywm.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BvC9X4aujCks+LvofbNjmGEfXqdN6GyABT7zrz2II5E=;
        b=VBiPHjfTnGs43cfjibwojEtCwBlXVqXunGb+2es8W+HhMl+0wFOTxwu7krTIoI+K5k
         CnBi7GZ4gxOa2Ob1FRZWNmkvL//F2HKnX/RreB3f+AeYTyTe2R7aH6oO6pUFmeEyI+n4
         CnZ7utNszSa7yXJ+Ap75eTHHkBR+UNB+PyqFo=
Received: by 10.101.64.1 with SMTP id r1mr141295ank.72.1319696797121; Wed, 26
 Oct 2011 23:26:37 -0700 (PDT)
Received: by 10.101.164.10 with HTTP; Wed, 26 Oct 2011 23:26:37 -0700 (PDT)
In-Reply-To: <7vipnb1myv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184283>

Am 26. Oktober 2011 23:07 schrieb Junio C Hamano <gitster@pobox.com>:
> Stefan Naewe <stefan.naewe@gmail.com> writes:
>
>> $ export GIT_PS1_SHOWUPSTREAM=1
>> sh.exe": cannot make pipe for process substitution: Function not implemented
>> sh.exe": cannot make pipe for process substitution: Function not implemented
>> sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect
>
> Are these the exact strings you want to have in the commit log message? I
> am particularly wondering about the dq after (but not around) 'sh.exe'.

Yes. That's exactly what I get.

Stefan
-- 
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode('hex')"
