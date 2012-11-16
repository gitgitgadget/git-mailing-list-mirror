From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/6] completion: add comment for test_completion()
Date: Fri, 16 Nov 2012 22:06:53 +0100
Message-ID: <CAMP44s333124DkyG5VX+n=p_eHRmPYCu27rsLgLQG8mOVcRBPg@mail.gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
	<1352644558-9410-2-git-send-email-felipe.contreras@gmail.com>
	<20121116205457.GY12052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZT81-0002y0-Kb
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 22:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab2KPVGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 16:06:55 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59989 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab2KPVGy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 16:06:54 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3220600oag.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gU5XxMHkgyWKsVGSCVBbRBdbVg/2vLfX9VTkugaFwvU=;
        b=hYWTmRnVzyc7gDKOFbQ9yXWc/hvUFL6AjOcSipNi8DOVjPScxK8qZQ5YkncVvHrBOc
         9SLFSmQ/BlsZoCLXLrJWP2hPvvtnUY9EvbJ5mVIKSEK8x/rGQkp5ZEIHb67UzWkgGnuo
         U4NnVygZLSd51+HLR5/ajO6X86Dmw0eDoN1QUpns8p7XGw9haV73OOoEj36dH9E7QNjp
         HrOWjbLYnWhVsijg6rGOKFdxsjLTFXp/08thIrG6vyDMqzRxEne727Wro6okbe/cGqpi
         6deVqTneouNSLmI8OeDhnlTpvIh+95piKPoME8u2EhBn8QjCe/TLGv0M+pKj0/BxV9xg
         xtfQ==
Received: by 10.60.1.163 with SMTP id 3mr4916447oen.30.1353100014048; Fri, 16
 Nov 2012 13:06:54 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Fri, 16 Nov 2012 13:06:53 -0800 (PST)
In-Reply-To: <20121116205457.GY12052@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209911>

On Fri, Nov 16, 2012 at 9:54 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Sun, Nov 11, 2012 at 03:35:53PM +0100, Felipe Contreras wrote:
>> So that it's easier to understand what it does.
>>
>> Also, make sure we pass only the first argument for completion.
>> Shouldn't cause any functional changes because run_completion only
>> checks $1.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t9902-completion.sh | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index cbd0fb6..5c06709 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -54,10 +54,14 @@ run_completion ()
>>       __git_wrap__git_main && print_comp
>>  }
>>
>> +# Test high-level completion
>> +# Arguments are:
>> +# 1: typed text so far (cur)
>
> Bash manuals calls this the current command line or words in the
> current command line.  I'm not sure what you mean with '(cur)' here.

The current _word_ text typed so far.

> The variable $cur in the completion script (or in bash-completion in
> general) is something completely different.

I believe bash's completion, this test, and the whole git completion
stuff uses the same definition of 'cur'.

Cheers.

--=20
=46elipe Contreras
