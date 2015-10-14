From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] Broken links in Git Documentation/user-manual.txt
Date: Wed, 14 Oct 2015 16:29:01 +0200
Message-ID: <vpqbnc1bk2a.fsf@grenoble-inp.fr>
References: <CAAF+z6F3Yej0ByAL1bGnG7qGRLz_HnpwVRqFVVHiMOebNRmSmA@mail.gmail.com>
	<vpqk2qp52am.fsf@grenoble-inp.fr>
	<20151014134042.GD19802@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xue Fuqiao <xfq.free@gmail.com>, Git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:29:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmN3j-0002yD-DP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 16:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbbJNO3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 10:29:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52929 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbbJNO3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 10:29:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EET0As024344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 16:29:00 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EET17h030213;
	Wed, 14 Oct 2015 16:29:01 +0200
In-Reply-To: <20151014134042.GD19802@serenity.lan> (John Keeping's message of
	"Wed, 14 Oct 2015 14:40:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Oct 2015 16:29:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EET0As024344
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445437742.80197@+LWqeA1oU22x1cw5KIboew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279575>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Oct 14, 2015 at 09:37:05AM +0200, Matthieu Moy wrote:
>> Xue Fuqiao <xfq.free@gmail.com> writes:
>> 
>> > Hi list,
>> >
>> > In https://git-scm.com/docs/user-manual.html , all links to the
>> > glossary[1] are broken.
>> 
>> Actually, the links themselves are fine, but the destimation is broken.
>> 
>> The doc is supposed to look like this :
>> 
>>   https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#def_head
>> 
>> with the glossary at the end. On
>> https://git-scm.com/docs/user-manual.html, the glossary is displayed as
>> verbatim text.
>> 
>> This does not seem to be a bug in our user-manual.txt, but in the way
>> it's processed by git-scm.com.
>
> I think it was an issue in the source, but was fixed by be510e0
> (Documentation: fix section header mark-up, 2015-09-25).  I'm not sure
> when/how git-scm.com rebulds its documentation, but I'm pretty sure that
> fix hasn't made it into a release yet so I doubt the site has picked it
> up.

Ah, OK. I can't reproduce the issue even with versions earlier than
be510e0, but this is because my local build uses asciidoc, and the
commit message says "Asciidoctor is stricter than AsciiDoc", and
git-scm.com seems to use asciidoctor.

The fix isn't in any release (not even in master), so it can't be in
git-scm.com.

Thanks for the pointer, I'll update the GitHub bug.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
