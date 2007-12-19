From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 18:14:31 +0100
Message-ID: <87tzmek3ns.fsf@lysator.liu.se>
References: <20071214105238.18066.23281.stgit@krank>
	<200712191144.59747.jnareb@gmail.com>
	<20071219114021.GB5565@diana.vm.bytemark.co.uk>
	<200712191723.29591.jnareb@gmail.com>
	<b0943d9e0712190902r2000c1ebob2303b32d1b948b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Karl =?utf-8?Q?Has?= =?utf-8?Q?selstr=C3=B6m?= 
	<kha@treskal.com>
To: Jakub Narebski <jnareb@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 18:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J52VA-0005Dd-MI
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 18:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbXLSRON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 12:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbXLSROM
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 12:14:12 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:43291 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbXLSROL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 12:14:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 71230200A22F;
	Wed, 19 Dec 2007 18:14:10 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 04607-01-57; Wed, 19 Dec 2007 18:14:10 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id ECCA4200A22E;
	Wed, 19 Dec 2007 18:14:09 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 21FDB7B4077; Wed, 19 Dec 2007 18:14:31 +0100 (CET)
In-Reply-To: <b0943d9e0712190902r2000c1ebob2303b32d1b948b8@mail.gmail.com> (Catalin Marinas's message of "Wed\, 19 Dec 2007 17\:02\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68921>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

>> I always forget which stage is which. It would be nice if
>> git-checkout-index implemented human-friendly names, just like
>> git-diff-files has --base, --ours, --theirs, i.e. if it would be
>> possible to write
>>
>>   git checkout-index --stage=3Dbase|ours|theirs <filename>
>
> This gets even more confusing with StGIT. For plain git, after a git
> merge or pull conflict, 'theirs' is stage 3. With StGIT, we first
> advance the base of the stack and merge the patches onto it, in which
> case the 'patched' (which I would normally call 'ours' rather than
> 'theirs') is 3.

True. And the same problem obviously exists for "git rebase".

--=20
David K=C3=A5gedal
