From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Thu, 12 Aug 2010 22:46:13 +0000
Message-ID: <AANLkTikZY8-QaBZbZauoTKDnMxp6D9bS+Av4uSVTwOT5@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
	<20100812224044.GK2029@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjgXT-0007YX-BL
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934000Ab0HLWqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:46:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65289 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab0HLWqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 18:46:13 -0400
Received: by ywh1 with SMTP id 1so621544ywh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kOlfJ5e//NznieXV5ndjBMMYRxrg/3SRovjCa7YeUnw=;
        b=uIwYHPV7rx1HxuT9SuEWLIzAIU31pTUnsrIvqZWcVWgeRa97aYHh48d7iNvbBruSND
         g/kSLwnVRD0YXUomG07Fhz28X068xjq/FxfWFwCes2qOPLBsujrnAwYEQ0INhBkNlIVs
         gAY6+DyDFSzRfuuphYtCaEbzxe+el5FRxxwwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cI47zdPavcjHJ6xMabq3zgfb1gIoqY8/SN0gygDVQQMl3WlNle2R3EA873bILsUm/l
         1sVl6i/e9sKflqUBwAPj5O7XE76ZX29DDd48mAPDyswHRm+dPzVQAbYvbk6WDodbGQ/q
         ev2k2fjhAWEB0nxedoa6C7fDKA7KNaiXjN1Gk=
Received: by 10.231.149.207 with SMTP id u15mr942416ibv.13.1281653173227; Thu,
 12 Aug 2010 15:46:13 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Thu, 12 Aug 2010 15:46:13 -0700 (PDT)
In-Reply-To: <20100812224044.GK2029@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153438>

On Thu, Aug 12, 2010 at 22:40, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Johannes Sixt wrote:
>> Am 8/12/2010 1:35, schrieb Junio C Hamano:
>
>>> * jn/apply-filename-with-sp (2010-07-23) 4 commits
>>> =C2=A0- apply: Handle traditional patches with space in filename
>>> =C2=A0- t4135 (apply): use expand instead of pr for portability
>>> =C2=A0- tests: Test how well "git apply" copes with weird filenames
>>> =C2=A0- apply: Split quoted filename handling into new function
>>>
>>> Looked Ok. =C2=A0Will merge to 'next'.
>>
>> The test cases that work with files with tabs must have a prerequisi=
te;
>> see t3600-rm.sh.
>
> Would this work?

This is nice, but incomplete. I just recently added a bunch of
TABS_IN_FILENAMES prereqs to pu, moving that prereq setup to
test-lib.sh + making the rm test use it would be better, we might want
more specific name restrictions than just "funny".

Please also add docs for the new prereq to t/README. There's a new
section for those now too.

Thanks.
