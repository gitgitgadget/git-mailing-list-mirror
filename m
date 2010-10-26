From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Tue, 26 Oct 2010 05:11:08 +0200
Message-ID: <vpqr5fdmywj.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
	<9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 05:11:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAZwV-0001L5-Ky
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 05:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab0JZDLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 23:11:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59986 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034Ab0JZDLN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 23:11:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9Q34jgS008667
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Oct 2010 05:04:45 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PAZwK-0003sz-9s; Tue, 26 Oct 2010 05:11:08 +0200
In-Reply-To: <9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com> (Thore Husfeldt's message of "Sun\, 24 Oct 2010 16\:47\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 26 Oct 2010 05:04:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9Q34jgS008667
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288667086.78234@lDzorSAbKAtIzTNiU3TRcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159978>

Thore Husfeldt <thore.husfeldt@gmail.com> writes:


>>=20
>> diff --git a/Documentation/user-manual.txt
> b/Documentation/user-manual.txt
>> index d70f3e0..02126f1 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -359,6 +359,11 @@ $ git branch -r
>>   origin/todo
>> ------------------------------------------------
>>=20
>> +In this case, "origin" is called a remote repository, or "remote"
> for
>> +short. The branches of this repository are called "remote branches"
>> +from our point of view, and Git will maintain a copy of these
>> +branches, called "remote-tracking branches" in the local
> repository.
>
> No. Git does not =E2=80=9Cmaintain a copy of [the remote] branches=E2=
=80=9D.

Which part of the sentence is problematic to you ?

Remote-tracking branches _are_ a copy of the branches. The copy is
made at "git clone" time, and is periodically updated with "git fetch"
later. And it seems to me that "periodically update" is a way to
"maintain" the copy up-to-date.

In the latest version of the patch, I changed "maintain" to "keep",
following Jakub's remark. Is that better?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
