From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] doc: git-foo was obsoleted several years ago
Date: Thu, 17 Oct 2013 13:13:29 +0200
Message-ID: <525FC659.8020608@gmail.com>
References: <1379763429-3443-1-git-send-email-felipe.contreras@gmail.com> <xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 17 13:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWlWm-0003VF-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 13:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab3JQLNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Oct 2013 07:13:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:46360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3JQLNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 07:13:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VWlWQ-0003Ki-Ui
	for git@vger.kernel.org; Thu, 17 Oct 2013 13:13:42 +0200
Received: from 158.75.2.83 ([158.75.2.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 13:13:42 +0200
Received: from jnareb by 158.75.2.83 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 13:13:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 158.75.2.83
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <xmqq7gdc7v70.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236293>

W dniu 2013-10-16 23:38, Junio C Hamano pisze:
> Felipe Contreras<felipe.contreras@gmail.com>  writes:
[...]
> I recall that I wanted to see this change happen myself long time
> ago, and suspect that there may have been some reason that prevented
> us from doing so.  I might have found that AsciiDoc back then did
> not like the input if the headline name "git-checkout(1)" did not
> match the filename "git-checkout.txt" and the command in the NAME
> section "git-checkout", or links "linkgit:git-checkout[1]" from
> other pages couldn't have SP there, or something silly like that.
>
> Also doesn't our build infrastructure slurp the one-line description
> "git-checkout - Checkout a branch ..." from these files and expect a
> dash to be there?
>
> In short, I personally do prefer to see dashless form at the top of
> the manpage, if it does not break other things, and there may need
> changes necessary to avoid breaking other things may to files other
> than these documentation-proper source files.
>
>> diff --git a/Documentation/git-checkout.txt b/Documentation/git-chec=
kout.txt
>> index ca118ac..8d98383 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -1,9 +1,9 @@
>> -git-checkout(1)
>> +git checkout(1)
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I wonder if it wouldn't be better to leave as is, in dashed form,
as the manpage file name is git-checkout.1, and this manpage is
invoked as "man git-checkout", not "man git checkout"
or "man 'git checkout'".

>>   NAME
>>   ----
>> -git-checkout - Checkout a branch or paths to the working tree
>> +git checkout - Checkout a branch or paths to the working tree
>>
>>   SYNOPSIS
>>   --------
>> ...

But change this, as we use this command as "git checkout", not
as "git-checkout".

--=20
Jakub Nar=C4=99bski
