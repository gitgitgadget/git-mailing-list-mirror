From: garciagj <garciagj@ensibm.imag.fr>
Subject: Re: [PATCH 1/2] status: introduce status.short to enable --short by  default
Date: Mon, 10 Jun 2013 10:02:39 +0200
Message-ID: <9646ae430a3789ab2a7a968b337f0a8c@ensibm.imag.fr>
References: <1370683737-28823-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
 <CALkWK0kvKzFoZmz313hR-3Z71y-MDPT37BfUi7Qrgy7hz_sErQ@mail.gmail.com>
 <7v4nd7qflu.fsf@alter.siamese.dyndns.org> <vpqbo7frspc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>, <git@vger.kernel.org>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulx3z-0007ur-JK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab3FJICq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 04:02:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57221 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117Ab3FJICo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:02:44 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5A82cCO031104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 10:02:39 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5A82dRU010262;
	Mon, 10 Jun 2013 10:02:39 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5A82dcM026723;
	Mon, 10 Jun 2013 10:02:39 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5A82dMJ026722;
	Mon, 10 Jun 2013 10:02:39 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to garciagj@ensibm.imag.fr using -f
In-Reply-To: <vpqbo7frspc.fsf@anie.imag.fr>
X-Sender: garciagj@ensibm.imag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 10:02:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227257>

El 2013-06-09 21:26, Matthieu Moy escribi=C3=B3:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> Jorge Juan Garcia Garcia wrote:
>>>> Some people always run 'git status -s'.
>>>> The configuration variable status.short allows to set it by=20
>>>> default.
>>>
>>> Good feature.
>>
>> Is there a corresponding command line override added to help people
>> who need to defeat such a configured-in default?
>
> Yes: "git status --no-short".
>
> Perhaps the doc for status.short should explicitely mention that
> --no-short takes precedence over it.


Yes, I will include that in the Documentation.
