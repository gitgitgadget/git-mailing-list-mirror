From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git  log --grep=foo".
Date: Tue, 27 Jul 2010 15:26:52 +0200
Message-ID: <vpqmxtd3vj7.fsf@bauges.imag.fr>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTim1S_IYbPArQqX91OOPtoh2-rIWmTRon50_j2p3@mail.gmail.com>
	<vpqsk355ea6.fsf@bauges.imag.fr>
	<AANLkTikcKd4nEZuot5fyZyiLqwAWl4gQyqtNg2512SKM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 15:28:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdkD8-00023Z-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 15:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab0G0N04 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 09:26:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36547 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab0G0N0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 09:26:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6RDP9hX007891
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 15:25:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OdkBI-0005R3-K4; Tue, 27 Jul 2010 15:26:52 +0200
In-Reply-To: <AANLkTikcKd4nEZuot5fyZyiLqwAWl4gQyqtNg2512SKM@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\, 27
 Jul 2010 12\:21\:47 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Jul 2010 15:25:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RDP9hX007891
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280841910.89231@yI7YcGmdcztqHqvv3nmsTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151941>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 27, 2010 at 11:56, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>> Sure, that's why the patch is just an RFC. I wanted to start the
>> discussion before diving into the repetitive task or migration to
>> parse-option for others, and I picked --grep and -S because they're
>> the ones which annoys me the most.
>
> Ah, there was nothing to indicate that,

Except if you read carefully ;-)

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This small patch serie is a very early RFC: it implements the feature
> for just two options.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
