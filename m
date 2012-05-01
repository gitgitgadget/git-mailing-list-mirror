From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 1/4] test: modernize style of t4006
Date: Tue, 01 May 2012 21:55:07 +0200
Message-ID: <4FA03F9B.1020402@in.waw.pl>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl> <1335892215-21331-2-git-send-email-zbyszek@in.waw.pl> <7vzk9r93ym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mj@ucw.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:55:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJAR-0006Y9-7L
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400Ab2EATzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 15:55:17 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35808 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756450Ab2EATzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 15:55:17 -0400
Received: from ip-78-30-103-51.free.aero2.net.pl ([78.30.103.51])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPJAI-0004hv-HH; Tue, 01 May 2012 21:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vzk9r93ym.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196735>

On 05/01/2012 08:00 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
>> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
>> ---
>>  t/t4006-diff-mode.sh |   32 +++++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 17 deletions(-)
>=20
> Style update is welcome, but shouldn't the assignment to sed_script
> be done in the second test if it is the only user?  If you are going =
to
> add more tests at the end, then it should be away from the second tes=
t to
> make it clear that it is not part of it.

Hi,
$sed_script is indeed only used in that one test. But moving the
assignment inside would complicate the quoting rules (the script is now
quoted with ', but this would have to change inside the test case which
is quoted with ' too). I actually think it's simpler this way.

Thanks,
Zbyszek

>> -sed -e 's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /' <current >=
check
>> -echo ":100644 100755 X X M	rezrov" >expected
>> +# $_x40 is defined in test-lib.sh
>> +sed_script=3D's/\(:100644 100755\) \('"$_x40"'\) \2 /\1 X X /'
