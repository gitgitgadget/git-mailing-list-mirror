From: Yann Dirson <dirson@bertin.fr>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 08:29:48 +0100
Organization: Bertin Technologies
Message-ID: <20101206082948.1403cc5a@chalon.bertin.fr>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 06 08:40:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPVgC-0008QN-F0
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 08:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424Ab0LFHkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 02:40:06 -0500
Received: from blois.bertin.fr ([195.68.26.9]:56331 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0LFHkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 02:40:06 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 69C5C543B1
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 08:40:04 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 4663554393
	for <git@vger.kernel.org>; Mon,  6 Dec 2010 08:40:04 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LCZ00HNNXASFW00@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 06 Dec 2010 08:40:04 +0100 (CET)
In-reply-to: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17810.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162980>

>> On Sat, Dec 04, 2010 at 10:30:21PM -0800, Junio C Hamano wrote:
>>> * kb/diff-C-M-synonym (2010-11-29) 1 commit
>>>  - diff: add --detect-copies-harder as a synonym for
>>> --find-copies-harder
>>>=20
>>> Will merge to 'next' soon.
>>
>> If we go this way, don't we want to deprecate --find-copies-harder a=
s
>> well ?
>
>Why?
>
>We are being nice to people who did not know --find-copies-harder but
>learned the --detect-renames long name before learning it, which by
>definition is are people because the long names have been there only f=
or
>the last few months; they may expect "detect" to work there.  That is
>the sole purpose of the additional synonym.

But then, why not simply use --find-renames (since --detect-renames has
luckily not been released ontl the masses yet), and avoid making simila=
r-usage
opts dissimilar and then adding a synonym just to make them similar the=
 other
way ?

IOW, we already have tons of options everywhere, let's not just add clu=
tter.
We'll end up here with those people used to using --detect-copies-harde=
r willing
shell completion; that will just add one more item to the list we get a=
fter
"--<TAB>", and it will eat precious screen space for pretty much nothin=
g.

Just my 0.02=E2=82=AC...
--=20
Yann Dirson - Bertin Technologies
