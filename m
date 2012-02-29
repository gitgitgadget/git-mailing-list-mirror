From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Tilde spec - befuzzled
Date: Wed, 29 Feb 2012 12:18:07 +1100
Message-ID: <CAH5451m=6XhRj1osN_Dw7zKvAW-jtru+EbCkRvo8aNRMbJS6bA@mail.gmail.com>
References: <4F4C995D.9000504@diamand.org> <4F4CA354.2070503@op5.se>
 <87zkc38a3v.fsf@thomas.inf.ethz.ch> <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, Andreas Ericsson <ae@op5.se>,
	Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 02:18:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2YBe-0007nO-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 02:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642Ab2B2BS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 20:18:29 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53358 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab2B2BS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 20:18:28 -0500
Received: by wibhm11 with SMTP id hm11so2369167wib.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 17:18:27 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.84.36 as permitted sender) client-ip=10.180.84.36;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.84.36 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.84.36])
        by 10.180.84.36 with SMTP id v4mr13424009wiy.0.1330478307447 (num_hops = 1);
        Tue, 28 Feb 2012 17:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SYSpqHeIcyaQwzMNhYTWXcYglt2+BUq0n49UCJEnIlM=;
        b=S1wXQc/08MQMP8MlQEORefcKUXEdNA/CqPCoxWFUj1K18sc6d9HZAnQTwFpn/OSLWG
         aayEIgyLGdpaWiArzP49iunKAff9AYVbe5ziil0Fq7R1wF9nlrsCU/heiAEyUNw5JRvy
         JZUk/hpdcSCkUmjOuCSGkDzyLIlwkedyMRWM8=
Received: by 10.180.84.36 with SMTP id v4mr10714283wiy.0.1330478307398; Tue,
 28 Feb 2012 17:18:27 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Tue, 28 Feb 2012 17:18:07 -0800 (PST)
In-Reply-To: <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191799>

On 29 February 2012 06:20, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
>
>>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
>>>> A suffix '{tilde}<n>' to a revision parameter means the commit
>>>> object that is the <n>th generation grand-parent of the named
>>>> commit object, following only the first parents.
>>>>
>>>> Hang on, *grand*-parents?
>>>> ...
>>
>> Perhaps we should reword it as "n-th first-parent ancestor"? =C2=A0B=
arring
>> confusion about the position of the dashes, that leaves little room =
for
>> error.
>
> I think we could either go "easier to read but not precise"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... that is the <n>th generation (grand-)p=
arent of ...
>
> or "may sound scary but correct"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the ancestor reached by walking the first-=
parent chain <n> times
>
> I am not sure which bucket "n-th first-parent ancestor" falls into.

The terms might be too technical, however my understanding was that
HEAD^n takes <n> steps along a breadth-first traversal of the commit
tree rooted at HEAD, while HEAD~n uses a depth-first traversal.

A better form for the description might come from that formulation of
the process, rather than the 'generational' formulation.

Regards,

Andrew Ardill
