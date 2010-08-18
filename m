From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an ignored directory
Date: Wed, 18 Aug 2010 15:47:55 +0200
Message-ID: <vpqk4noc9ro.fsf@bauges.imag.fr>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
	<AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, Jens.Lehmann@web.de, jrnieder@gmail.com
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 15:48:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj0Y-0004ke-5q
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab0HRNsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 09:48:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54872 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907Ab0HRNsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:48:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7IDj4k5025220
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Aug 2010 15:45:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Olizj-00067g-FY; Wed, 18 Aug 2010 15:47:55 +0200
In-Reply-To: <AANLkTi=UJmXx0-fV6OqDTOzuTdQQWioUb=3vrVx01qi6@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Wed\, 18
 Aug 2010 13\:43\:00 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Aug 2010 15:45:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7IDj4k5025220
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282743906.2183@H05wuXrys6nFYUHcQ0T5Nw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153849>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Aug 18, 2010 at 09:29, Greg Brockman <gdb@mit.edu> wrote:
>
>> +cat >expect <<EOF
>> +The following paths are ignored by one of your .gitignore files:
>> +ignored-dir
>> +Use -f if you really want to add them.
>> +fatal: no files added
>> +EOF
>
> Please make this a test, per this bit in t/README:
>
>  - Put all code inside test_expect_success and other assertions.
>
>    Even code that isn't a test per se, but merely some setup code
>    should be inside a test assertion.

Not sure what is the gain by doing so, and the vast majority of tests
already there use the style of Greg's patch ...

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
