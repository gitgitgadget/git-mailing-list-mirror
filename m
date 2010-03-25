From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCHv2 2/2] tests for git alternate command
Date: Thu, 25 Mar 2010 11:51:15 -0700
Message-ID: <a038bef51003251151h5ede3ab8jc22a61cc35706240@mail.gmail.com>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
	 <1269497251-13103-3-git-send-email-judge.packham@gmail.com>
	 <4BAB12E1.8070602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	bebarino@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 25 19:51:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nus9M-0005RF-6k
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 19:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab0CYSvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 14:51:17 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:59850 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab0CYSvR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 14:51:17 -0400
Received: by qyk26 with SMTP id 26so5793594qyk.19
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DSha5f617YlBLDkvSoHWMPPmeyZTcIrhXNPwX5i6N/E=;
        b=Pmb8FEQzNQNcVBiRRVIAtQZsiIFZ9wxY2gW5tM4MlMR7uUgMfQgv8fus1U4izhvq+R
         lLVHHuStlHWq7UsHUW7ymd/UQsxsVPuleE5faQA+6GKDQpGw5GbIyQsQeq7UcrzDpFIc
         Msxu17By2F67j2Dmy1hgesrd8Q8G0rUb4acfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ULckRSSPfq13tiXvyJwo9KYVBEGyoNE8z5AptX3Rm5bv5cMnvPRfXq64KGtEuOY6uK
         yarwoM++1xcbY1Jc0vEvq+TdaCqsVh/w4wFOP8fo3wgviNGcHEBKD2LEgulP8JxzGVry
         CA87Fxcl0FCaCmSMqv1FlfDxuajMKLIxPBMws=
Received: by 10.229.112.2 with SMTP id u2mr1436414qcp.0.1269543075485; Thu, 25 
	Mar 2010 11:51:15 -0700 (PDT)
In-Reply-To: <4BAB12E1.8070602@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143190>

On Thu, Mar 25, 2010 at 12:38 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Am 3/25/2010 7:07, schrieb Chris Packham:
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
>
> Your patches violate whitespace rules. Use 'git show --check' to see =
the
> questionable lines.
>

Will do. BTW theres no mention of --check in git show --help, but one
itch at a time.

>> ---
>> I wasn't sure about the test numbering so I just grabbed the highest=
 one. Still
>> need to add tests for the deletion use case.
>
> According to t/README, t1* would be a suitable category, perhaps t143=
0.
>
>> =C2=A0t/t9800-git-alternate.sh | =C2=A0 95 +++++++++++++++++++++++++=
+++++++++++++++++++++
>
> "git" in the name is redundant
>

Is t1430-alternate-cmd.sh OK with everyone?

>> +test_expect_success \
>> + =C2=A0 =C2=A0 'Setup for rest of the test' '
>
> The modern style for test headers is
>

[snip]

Will incorporate in next update

>> +#rm -rf A B C D base
>> \ No newline at end of file
>
> test_done
>

Ah, I knew it would be something simple like that. I guess I should
have started by reading t/README.
