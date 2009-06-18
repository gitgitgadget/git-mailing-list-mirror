From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:59:32 +0200
Message-ID: <vpqws79c3yj.fsf@bauges.imag.fr>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	<vpqbpomey8c.fsf@bauges.imag.fr>
	<alpine.DEB.1.00.0906181042270.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 11:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDZU-0002qE-C5
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 11:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbZFRJGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbZFRJGA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 05:06:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48357 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305AbZFRJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 05:05:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n5I8sJPt027604
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 10:54:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MHDT2-0002Bk-Qr; Thu, 18 Jun 2009 10:59:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MHDT2-0003GF-PO; Thu, 18 Jun 2009 10:59:32 +0200
In-Reply-To: <alpine.DEB.1.00.0906181042270.4848@intel-tinevez-2-302> (Johannes Schindelin's message of "Thu\, 18 Jun 2009 10\:44\:36 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 18 Jun 2009 10:54:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121821>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 18 Jun 2009, Matthieu Moy wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > I'd really rather stay with "fixup".
>> 
>> I like fixup. I'd say "fixup: <message>" so that the thing actually
>> looks like a program directive rather than natural language.

[...]

> edited edit list:
>
> 	pick b1ab1ab First commit
> 	fixup 0123456 This is a fixup for the first commit
> 	pick deafbee Second commit

Sorry, we were not talking about the same thing: I was still talking
about the dwimery in the commit message. So, yes, your "fixup" (that
could be abbreviated by "f") sounds good to me.

But some (optional) magic to get the edited list by default could be
nice in addition, and that could be triggered by "fixup: ..." in the
commit message.

I do often find myself commiting something knowing that the commit is
meant for rebase+squash-ing (i.e. I know that at commit time more
often than at rebase time).

(not yet 100% convinced myself, and I can sure do without)

-- 
Matthieu
