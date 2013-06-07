From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 21:16:43 +0200
Message-ID: <20130607191643.GA31625@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
 <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul29b-0004ZV-H3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab3FGTQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 15:16:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58541 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3FGTQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:16:46 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M7lyK-1UPDwJ41aq-00vPUw; Fri, 07 Jun 2013 21:16:44 +0200
Content-Disposition: inline
In-Reply-To: <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:jB6AQ8NOsut0iP6aC1q1Y/+hrGIjbKuvDESxAOyWVC0
 MjZI6lXxtmN2YKpndT2ZhsYVZRXPb6sJNUaynIhOMBuQ+kJbnr
 4mMB2tL+Uj0hXvf+7qHd+KWjTB4yn568gFJlvQOsMGcu+THQly
 7kSLE8R7ctCid9URx3OVsoYYHh3uNrQqtrkyYqUWHDxxSlk64s
 sTOGBxOxo3BXR/WfkdYewCC2Ik8YWdzsLHv2012wbpV0DT+8ze
 9f0V7YO2rLkhJ0WZsi4c0R6y1DFB3cojG+cqIY6JyEQ1DcGd8s
 WZCvx/HLK6sB5zvA0pOcaZPFn78gcIcbZrEAw3kuLliwiJqXqo
 +jRMMFZy0wvtcHi73+rOnS+YutEDbSlIyvldmPxPp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226678>

On Fri, Jun 07, 2013 at 11:41:07AM -0700, Junio C Hamano wrote:
> "git log -Gcomplete_file -p contrib/completion" found this one:
>=20
> commit 1d66ec587e7d903afdf12a81718772a9eadc15a1
> Author: SZEDER G=E1bor <szeder@ira.uka.de>
> Date:   Thu Mar 10 19:12:29 2011 +0100
>=20
>     bash: complete 'git diff ...branc<TAB>'

(snip)

>     Suggested-by: Junio C Hamano <gitster@pobox.com>
>     Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> Now I do not recall suggesting it, and you (and I today after 2
> years) may disagree with the rationale, but at least we can read
> what was the "intended" meaning, I think.

See

  http://thread.gmane.org/gmane.comp.version-control.git/167728/focus=3D=
168838

I still agree with the rationale, considering that the new
__git_complete_revlist_file() function for completing ref1...ref2:path
is a nearly straight copy-paste from the then __git_complete_revlist()
and __git_complete_file() including that 12 line long sed script.


G=E1bor
