From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git  log --grep=foo".
Date: Tue, 27 Jul 2010 13:56:33 +0200
Message-ID: <vpqsk355ea6.fsf@bauges.imag.fr>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTim1S_IYbPArQqX91OOPtoh2-rIWmTRon50_j2p3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 13:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odim6-00036J-SJ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 13:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab0G0L4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 07:56:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51798 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377Ab0G0L4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 07:56:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6RBkQFc003008
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 13:46:26 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Odilt-0004AL-Kq; Tue, 27 Jul 2010 13:56:33 +0200
In-Reply-To: <AANLkTim1S_IYbPArQqX91OOPtoh2-rIWmTRon50_j2p3@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\, 27
 Jul 2010 10\:18\:03 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Jul 2010 13:46:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RBkQFc003008
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280835991.34942@/n2PThlVdXQ9zShDllLilA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151933>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jul 26, 2010 at 18:14, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
>
>> + =A0 =A0 =A0 } else if (!strcmp(arg, "--grep")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_message_grep(revs, optarg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>
> This looks good. I've been bitten by git-log's non-standard option
> parsing. But there's still a lot of options that need the =3D, no?:

Sure, that's why the patch is just an RFC. I wanted to start the
discussion before diving into the repetitive task or migration to
parse-option for others, and I picked --grep and -S because they're
the ones which annoys me the most.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
