From: Dan Savilonis <djs@n-cube.org>
Subject: Re: git format-patch from date never set
Date: Sat, 25 Jul 2009 20:06:11 -0400
Message-ID: <325c62f60907251706i4d9bf656n8e094a22a8736924@mail.gmail.com>
References: <325c62f60907251439n6f3f661dhf0e76a74ce1eaec8@mail.gmail.com>
	 <81b0412b0907251531u7566813fr10bdd70187e9aca6@mail.gmail.com>
	 <325c62f60907251549o27ebc8f2gcd1d728adb662ffd@mail.gmail.com>
	 <7v7hxwtlf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 02:06:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUrGR-00050L-Em
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 02:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbZGZAGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 20:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbZGZAGN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 20:06:13 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:32983 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbZGZAGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 20:06:12 -0400
Received: by yxe36 with SMTP id 36so1376338yxe.33
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Zo7hhy5jHbKxa1uijeIzrfPuiRRAyuHW+LQPUUyqxRI=;
        b=MlMaWLBQERoTBH37oLqt8yJUBe8GVDwPf0rkrphHtgTOsnY+r2TWaw/RMCr940swd8
         6ZOlsnGu410a9HMPzMTJmqwWQkS2kw4M7n1Uwfg1id65Uf/v/Y/WAthAN3CnHWmpAKLW
         FiaW0KTgeW5i64JzNnJqOLsRYksNr7h+gRFMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FzIJCh0FnVAxGpxlYCIefE7GupvMwJDmUPdaQ7xIjn9KIEWt+8S8i6QXiTqTkApZYb
         ypvV+Sp5rZK36RDHcKCHKtT5ovRCVumbICJiFtE3814VofurCckf0hziZGmCQ+AAcdRl
         9YKhBktF70ZCk+fYwNNVJXj0NvtmHXakcKgoU=
Received: by 10.231.14.67 with SMTP id f3mr1692603iba.36.1248566771974; Sat, 
	25 Jul 2009 17:06:11 -0700 (PDT)
In-Reply-To: <7v7hxwtlf7.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ed91e91a6b928c37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124100>

Okay, I can see that. I suppose I don't really have an argument in
favor of using the real date, other than aesthetics.

--
Dan

On Sat, Jul 25, 2009 at 7:03 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Dan Savilonis <djs@n-cube.org> writes:
>
>> On Sat, Jul 25, 2009 at 6:31 PM, Alex Riesen<raa.lkml@gmail.com> wro=
te:
>>> Neither. This is not a date, but a part of "loosely defined" mbox f=
ormat.
>>>
>>
>> In the examples of mbox format I have found, the date in the From:
>> line is generally the same as in the Date: line, albeit in a more
>> ambiguous format. Further, the the git code treats it as a date and
>> attempts to set it. It remains at the default date only because
>> git_committer_info() is called without GIT_COMMITTER_DATE set.
>>
>> So is the code misleading? Was it designed to just meet the minimal
>> requirement of having a date-like string to comform to the mbox
>> format? What's the disadvantage to using the real commit date?
>
> Having it as a fixed date-looking string was to help /etc/magic entry
> people may want to invent to detect format-patch output.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
