From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 16:39:07 +0100
Message-ID: <87y7bqk82s.fsf@lysator.liu.se>
References: <20071214105238.18066.23281.stgit@krank>
	<b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	<20071217224812.GA6342@diana.vm.bytemark.co.uk>
	<20071218052115.GA13422@diana.vm.bytemark.co.uk>
	<b0943d9e0712190659p6c4cb557jae5b21aa68de029d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:39:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J510r-0003Xn-I8
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 16:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbXLSPis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 10:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756059AbXLSPis
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 10:38:48 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:42552 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbXLSPir convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 10:38:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id ABBA8200A22F;
	Wed, 19 Dec 2007 16:38:46 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17919-01-37; Wed, 19 Dec 2007 16:38:46 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 09785200A220;
	Wed, 19 Dec 2007 16:38:46 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 19BE97B4077; Wed, 19 Dec 2007 16:39:07 +0100 (CET)
In-Reply-To: <b0943d9e0712190659p6c4cb557jae5b21aa68de029d@mail.gmail.com> (Catalin Marinas's message of "Wed\, 19 Dec 2007 14\:59\:20 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68916>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 18/12/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>>   git://repo.or.cz/stgit/kha.git safe
> [...]
>>       Ask git about unmerged files
>
> This patch wrongly assumes that there is a stage 2 entry in the index=
=2E
> Test t1202-push-undo.sh fails because a file is added, differently, i=
n
> both master and patch but it doesn't exist in ancestor (no stage 2).
> Using stage 3 doesn't fix it either because a patch might remove a
> file.
>
> I fixed it by using a set to get the unique names.

That sounds reasonable.

--=20
David K=C3=A5gedal
