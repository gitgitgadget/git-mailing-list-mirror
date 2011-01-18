From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Tue, 18 Jan 2011 10:05:33 +0100
Message-ID: <AANLkTimQm02VQw19dV8BvZEm=643hbSh2qkvOCEwUOPr@mail.gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
	<AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
	<20110117115133.GA29207@burratino>
	<20110117133843.GA23625@neumann>
	<20110117205542.GA21507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	"Aaron S. Meurer" <asmeurer@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 10:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf7VW-0000nm-Kt
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 10:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1ARJFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 04:05:36 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52559 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab1ARJFf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jan 2011 04:05:35 -0500
Received: by wwa36 with SMTP id 36so6238718wwa.1
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ld+V6bqn6UneUIuJA/CcqLfzzo5w8pKYQEUtFayzXh0=;
        b=aMRK6L/BvE49aptTySlreOH6N5P4HHKp3XmM9EWSaIjL5vtRt1VvmpdSKwV5jzba2e
         fRovxG/9lHMgu91/8SnkddoR0WDOpgQoUXGEekMnTcwYNE8fu6aPE4JJr+8ozCXGX/sK
         eIk0QySHsN+VAHI45Q2qKkWs1j7OMWbxDVfNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s+ITQisxMp4Cz5n65w0HFYP487dMwA4PFXoXpc6g2MCiGxqlamMWELbL2V6UiajPWi
         sb2EUY2GgM27elSHZjRD22ofgzL5D2kFZH4/mpOBr/wtFHIsTCloMMDRjyIHy84rh4vI
         nvA2wXid3bq+WFCO16Xw07u+OJmeg1WHyLCEQ=
Received: by 10.216.48.211 with SMTP id v61mr4352901web.35.1295341533481; Tue,
 18 Jan 2011 01:05:33 -0800 (PST)
Received: by 10.216.50.129 with HTTP; Tue, 18 Jan 2011 01:05:33 -0800 (PST)
In-Reply-To: <20110117205542.GA21507@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165195>

2011/1/17 Jonathan Nieder <jrnieder@gmail.com>:
> SZEDER G=E1bor wrote:
>> On Mon, Jan 17, 2011 at 05:51:33AM -0600, Jonathan Nieder wrote:
>>> Christian Couder wrote:
>
>>>> Yeah, many people find it difficult to reverse the meaning of "bad=
"
>>>> and "good" when looking for a fix. There were some suggestions at =
some
>>>> points to do something about it. Some of the suggestions were to u=
se
>>>> some aliases for "good" and "bad", but there was no agreement. Oth=
er
>>>> suggestions had a patch attached but the patch was not good enough=
 or
>>>> something.
>>>
>>> Any pointers to such a discussion or patch? =A0Maybe whatever small
>>> detail caused it to be forgotten could be fixed...
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/86063

Thanks for the link.

> A better link for those who are thinking of picking up the topic migh=
t
> be [1].
>
> The problems were:
>
> =A0- error messages refer to "good" and "bad" with the original,
> =A0 unreversed meaning, which could be confusing (but see later in th=
e
> =A0 thread!).
> =A0- "git bisect visualize" doesn't get the memo about the new worldv=
iew.
> =A0- it seems that some people lost interest after a while.
>
> None of these seems totally fatal --- as a new feature, it would not
> be breaking anyone's workflow, especially if the potentially confusin=
g
> bits are clearly documented.

Yeah, some things have changed since that time, so it may be more
involved now, but otherwise I think it would be good to have.

Thanks,
Christian.
