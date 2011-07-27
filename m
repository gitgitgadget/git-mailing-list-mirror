From: Reuben Thomas <rrt@sc3d.org>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 11:00:51 +0100
Message-ID: <CAOnWdog-FqOJJ7nFFW-Sj9U5obVWgVdww5yFUy5uWJW8fw4svA@mail.gmail.com>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
	<19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net>
	<7v8vrmrxok.fsf@alter.siamese.dyndns.org>
	<4E2FCAC4.7020408@drmicha.warpmail.net>
	<CAOnWdojgxZNs4qyEG55URScqOGb6k5e6Mh_B3By6Lj6SpN9L9g@mail.gmail.com>
	<4E2FE024.2030204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 12:00:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm0vD-0001KZ-6c
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 12:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab1G0KAy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 06:00:54 -0400
Received: from exprod7og114.obsmtp.com ([64.18.2.215]:37825 "HELO
	exprod7og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752252Ab1G0KAx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 06:00:53 -0400
Received: from mail-yi0-f45.google.com ([209.85.218.45]) (using TLSv1) by exprod7ob114.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTi/h1PJE4SXRSnVoJThVecDfSzHLekBL@postini.com; Wed, 27 Jul 2011 03:00:53 PDT
Received: by yia25 with SMTP id 25so1095726yia.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 03:00:52 -0700 (PDT)
Received: by 10.142.144.12 with SMTP id r12mr3486183wfd.74.1311760851843; Wed,
 27 Jul 2011 03:00:51 -0700 (PDT)
Received: by 10.142.164.13 with HTTP; Wed, 27 Jul 2011 03:00:51 -0700 (PDT)
In-Reply-To: <4E2FE024.2030204@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177959>

On 27 July 2011 10:53, Michael J Gruber <git@drmicha.warpmail.net> wrot=
e:
> Reuben Thomas venit, vidit, dixit 27.07.2011 11:45:
>>
>> $ cat ~/reportbug-git
>> $ git rm -f ../INSTALL
>> rm 'INSTALL'
>> $ git ci -m "INSTALL is now provided by gnulib." ../INSTALL
>> error: pathspec 'ALL' did not match any file(s) known to git.
>> $ cd ..
>> $ git ci -m "INSTALL is now provided by gnulib." INSTALL
>> [master 0895314] INSTALL is now provided by gnulib.
>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>> =A0delete mode 120000 INSTALL
>>
>> The thing I didn't understand is that I tried to check in ../INSTALL=
,
>> but git complained about pathspec 'ALL'.
>
> Well, you didn't say so, did you?
>
> Also, we don't know what subdir you were doing this in, but I bet it =
has
> a 7-character name...

Its name was "src".

> I can't reproduce that name truncation with a current git, btw.

Thanks for testing that.

> In any case, I still think git should allow partial commits with stag=
ed
> deletions from within a subdir, which is what my patch is about.

Absolutely, this looks useful.

--=20
http://rrt.sc3d.org
