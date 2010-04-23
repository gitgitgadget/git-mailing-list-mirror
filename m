From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:15:45 +0200
Message-ID: <87iq7ittq6.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
	<20100422222723.GB12000@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Brewster <adambrewster@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:15:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5EzI-0007Uu-7k
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab0DWJPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 05:15:47 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:55963 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0DWJPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:15:46 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id EDC8314E1692E;
	Fri, 23 Apr 2010 11:15:45 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5EzB-0003OO-00; Fri, 23 Apr 2010 11:15:45 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5EzB-0003Tl-EE; Fri, 23 Apr 2010 11:15:45 +0200
In-Reply-To: <20100422222723.GB12000@progeny.tock> (Jonathan Nieder's message
	of "Thu, 22 Apr 2010 17:27:23 -0500")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1+gJ7T0rYN3Zfk0x4nd2DGL73PXELYLMs8jcJt2
	Dd0B3AtwaY+LzT9WKpXq+X9+tfDLN88KoZw9kflIwZMsLxxKgL
	aAWB8RXNU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145599>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Adam Brewster wrote:
>
>> Consider
>>=20
>> $ echo -e '#!/bin/bash\nif git diff-tree --quiet HEAD; then git comm=
it
>> -a; else git commit; fi' > `git --exec-path`/git-ci
>> $ chmod 555 `git --exec-path`/git-ci
>
> Or just put it in your $PATH. :)
>
> By the way, all this talk of =E2=80=9Cif there is an index=E2=80=9D s=
ounds funny to
> my brainwashed ears.  Every version control system I have tried uses
> an index to ensure consistency during a commit; it=E2=80=99s just tha=
t most
> of them hide it from the user.
>
> This may sound pedantic, I realize.
>
> Have fun,
> Jonathan

Other RCS use an index of files they track. Git uses an index of patch
chunks to commit. Same name, totaly different concept.

Or am I understanding that wrong?

MfG
        Goswin
