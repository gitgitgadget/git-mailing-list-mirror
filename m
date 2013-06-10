From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: git diff bug?
Date: Mon, 10 Jun 2013 14:44:27 +0200
Message-ID: <51B5CA2B.101@ensimag.fr>
References: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com> <51B10236.2030009@ensimag.fr> <7v4ndayjdt.fsf@alter.siamese.dyndns.org> <CANd8ic+6AtWgbK3S7DMkaOz7K9WJYdq8ozP9mesc-vJRhxLjqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>,
	git <git@vger.kernel.org>
To: Sarma Tangirala <vtangira@buffalo.edu>
X-From: git-owner@vger.kernel.org Mon Jun 10 14:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um1Sk-0007ns-RU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 14:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab3FJMof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 08:44:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36634 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab3FJMoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 08:44:34 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5ACiRIf027439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 14:44:27 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5ACiSHm014317;
	Mon, 10 Jun 2013 14:44:28 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5ACiQ8t019544;
	Mon, 10 Jun 2013 14:44:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CANd8ic+6AtWgbK3S7DMkaOz7K9WJYdq8ozP9mesc-vJRhxLjqg@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 14:44:28 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227278>

Le 07/06/2013 18:01, Sarma Tangirala a =C3=A9crit :
> On Thu, Jun 6, 2013 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>>
>=20
>> But for a two-endpoint diff Porcelain (not the plumbing diff-files,
>> diff-index and diff-tree), I do not think it is particularly a bad
>> idea to add such a "typo-detection" feature.
>=20
> I was wondering if this feature is going to be added and if I could
> try implementing it.

Since nobody answered you (publicly at least), I will try doing it myse=
lf:
I think the best thing to do if you want a feature to be added is to
come with a patch and request for comments on it. Then, people will
discuss it and decide whether it's worth adding it to git. So yes, you
can try implementing it - all work is welcome :)

--=20
C=C3=A9lestin Matte
