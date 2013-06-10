From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 09:52:25 +0200
Message-ID: <19969d9996306bf0e7ac6351d4ad435d@ensibm.imag.fr>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <1370680434-2709-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <CALkWK0==9aN1wVoSXENvTJHOT8bd2SYrEFxrmTdhzMxB3mHPCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwuD-00014W-EI
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab3FJHwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 03:52:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45581 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab3FJHwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:52:37 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5A7qOY2007272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 09:52:25 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5A7qPrw010129;
	Mon, 10 Jun 2013 09:52:25 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5A7qPNw022744;
	Mon, 10 Jun 2013 09:52:25 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5A7qPkI022742;
	Mon, 10 Jun 2013 09:52:25 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CALkWK0==9aN1wVoSXENvTJHOT8bd2SYrEFxrmTdhzMxB3mHPCQ@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 09:52:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227253>

Le 2013-06-08 16:01, Ramkumar Ramachandra a =C3=A9crit=C2=A0:
> Mathieu Lienard--Mayor wrote:
>> As an example, the message:
>>         error: 'foo.txt' has changes staged in the index
>>         (use --cached to keep the file, or -f to force removal)
>>
>> would look like, with advice.rmHints=3Dtrue:
>>         error: 'foo.txt' has changes staged in the index
>
> Um, have you switched the true with false?  advice.* variables are
> true by default, and I turn off all of them.
Whoops, my bad, I obviously meant false.
>
> Also, I think you can extend this to also remove add-advice.  Why
> would someone want to turn off advice from rm, but not add?  (Unsure
> about this)
I'm not so sure i understand. Do you mean rmHints should deactivate=20
addHints aswell, or do you mean that since we're introducing rmHints it=
=20
would be natural to introduce addHints ?
>
>> Similarly to advice.*, advice.rmHints has been added
>> to the config variables. By default, it is set to false, in order to
>> keep the messages the same as before. When set to true,  advice
>> are no longer included in the error messages.
>
> Ugh, why this roundabout-passive-past tone?  Use imperative tone like=
=20
> this:
Sorry about that, we'll work on it.
>
> Introduce advice.rmHints to control the whether to display advice=20
> when
> using 'git rm'.  Defaults to true, preserving current behavior.
--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
