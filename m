From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: Re: [PATCH] Documentation: Reworded example text in git-bisect.txt.
Date: Sun, 22 Mar 2009 14:39:05 -0700
Message-ID: <49C6AFF9.6090204@whistlingcat.com>
References: <1237520134-18044-1-git-send-email-dmellor@whistlingcat.com> <200903210528.32392.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 22:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVPN-00055z-LI
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 22:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbZCVVjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 17:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbZCVVjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:39:09 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:46838 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbZCVVjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 17:39:08 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 26390488006;
	Sun, 22 Mar 2009 14:39:06 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id E775838E7514;
	Sun, 22 Mar 2009 14:39:05 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200903210528.32392.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114172>

On 03/20/2009 09:28 PM, Christian Couder wrote:
> Le vendredi 20 mars 2009, David J. Mellor a =C3=A9crit :
>=20
> [...]
>=20
>> @@ -94,14 +95,14 @@ the bisection state).
>>  Bisect visualize
>>  ~~~~~~~~~~~~~~~~
>>
>> -During the bisection process, you issue the command:
>> +To see the currently remaining suspects in 'gitk', the following co=
mmand
>> +is issued during the bisection process:
>=20
> I think it's better to avoid the passive tone, for example like this:
>=20
> "To see the currently remaining suspects in 'gitk', you issue the fol=
lowing=20
> command during the bisection process:"
>=20
>>  ------------
>>  $ git bisect visualize
>>  ------------
>=20
> [...]
>=20
>> @@ -173,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. F=
or
>> example: $ git bisect skip v2.5..v2.6
>>  ------------
>>
>> -would mean that no commit between `v2.5` excluded and `v2.6` includ=
ed
>> -can be tested.
>> +The effect of this would be that no commit between `v2.5` excluded =
and
>> +`v2.6` included could be tested.
>=20
> I'd prefer something like:
>=20
> "This tells the bisect process that no commit between `v2.5` excluded=
 and=20
> `v2.6` included can be tested."
>=20
> Otherwise it looks good to me.
>=20
> Thanks,
> Christian.
>=20
>=20

I will send a patch correcting this in my next cycle of documentation=20
patches. I should send them some time later today.
