From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Sat, 06 Dec 2014 00:45:57 +0000
Message-ID: <1417826757.30899.16.camel@segulix>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	<1417798622.23238.6.camel@segulix>
	 <xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
	 <12536C063959480083CC2D4CBA0BA38E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 01:46:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx3W3-0000py-S1
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 01:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbaLFAqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 19:46:01 -0500
Received: from host1.easyho.st ([62.210.60.225]:40120 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbaLFAqB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 19:46:01 -0500
Received: from [188.250.193.97] (port=57719 helo=[192.168.1.67])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1Xx3VV-000qnb-Hq; Sat, 06 Dec 2014 00:45:59 +0000
In-Reply-To: <12536C063959480083CC2D4CBA0BA38E@PhilipOakley>
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260919>

On Sex, 2014-12-05 at 20:48 +0000, Philip Oakley wrote:
> The problem here is that there is no guidance on what those actions
> are
> that may make git 'notice'. The man page git-update-index isn't as
> clear
> as it could be. Using --really-refresh being one option that would
> make
> git notice, but I wouldn't know when that is used.
>=20
> Part of the implied question is why "git commit ." would notice when
> when "git commit -a" didn't appear to. So it's unclear as to what the=
=20
> user should have expected.
>=20
I agree with this sentence, this is a bug because:

git commit -a ( and -a means all ) is incoherent with "git commit ."
This is stupid because when I want commit part of the tree, commit
includes one file that is not included when I say to commit all .=20
So maybe you should fix, git commit -a to be coherent .=20

> (Note, I don't use assume-unchanged myself so this is more about=20
> supporting the user/manual clarification. It is mentioned moderately=20
> often on stackoverflow etc.)

yeap =20

Sorry I don't have time to read all messages in thread ,=20
but I'm going to test git with the patch suggest in this thread , at
least, I solve "my" problem for some time ...=20

Thanks, =20
--=20
S=E9rgio M. B.
