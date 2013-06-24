From: Benoit Person <Benoit.Person@ensimag.fr>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Mon, 24 Jun 2013 19:05:29 +0200
Message-ID: <2b5734ad750f9ec566215f353b6bb0b5@ensibm.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
 <1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
 <vpqsj07vb3m.fsf@anie.imag.fr> <7vfvw7bh0u.fsf@alter.siamese.dyndns.org>
 <vpqy59zsb0u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <benoit.person@ensimag.fr>,
	<git@vger.kernel.org>, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:05:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrADA-00045l-Lk
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab3FXRFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 13:05:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56960 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab3FXRFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:05:48 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5OH5R7R000307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 19:05:27 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5OH5TCb014258;
	Mon, 24 Jun 2013 19:05:29 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5OH5TSK016046;
	Mon, 24 Jun 2013 19:05:29 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5OH5TaF016045;
	Mon, 24 Jun 2013 19:05:29 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to Benoit.Person@ensimag.fr using -f
In-Reply-To: <vpqy59zsb0u.fsf@anie.imag.fr>
X-Sender: Benoit.Person@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Jun 2013 19:05:27 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228876>

Le 2013-06-24 18:56, Matthieu Moy a =C3=A9crit=C2=A0:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> benoit.person@ensimag.fr writes:
>>>
>>>> diff --git a/contrib/mw-to-git/git-mw.perl=20
>>>> b/contrib/mw-to-git/git-mw.perl
>>>> new file mode 100644
>>>> index 0000000..a2f0aa1
>>>> --- /dev/null
>>>> +++ b/contrib/mw-to-git/git-mw.perl
>>>
>>> *.perl scripts are usually executable in Git's tree (although it's
>>> usually better to run the non-*.perl version).
>>
>> Good eyes.  But if we encourage people to run non-*.perl version,
>> perhaps we should drop the executable bit from the source, no?
>
> But by default, I'd say consistency is most important so if other=20
> *.perl
> are executable, we should do the same (otherwise my "ls" shows=20
> different
> colors and it's ugly ;-) ).
So it's really a *nice* catch then :) .

> But it may make sense to change the convention, i.e. run a "chmod -x
> *.perl" in Git's tree (in any case, people can still run "perl
> foo.perl").
=46or what I've seen so far of git.git, the best way would be to make i=
t
executable in this patch serie and send another patch applying that
'chmod -x'-thingy ?
