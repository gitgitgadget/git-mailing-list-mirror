From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.3
Date: Thu, 7 May 2009 17:39:54 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh0677a.at.sitaramc@sitaramc.homelinux.net>
References: <7vmy9ps820.fsf@alter.siamese.dyndns.org>
 <bbd12f0f0905070758q697f11fck259db4a0207d0aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 19:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27aJ-0000ca-2t
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbZEGRkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752469AbZEGRkN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:40:13 -0400
Received: from main.gmane.org ([80.91.229.2]:57935 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbZEGRkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 13:40:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M27Zr-0006NW-Af
	for git@vger.kernel.org; Thu, 07 May 2009 17:40:11 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 May 2009 17:40:11 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 May 2009 17:40:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118498>

On 2009-05-07, Jeff Brown <jeff@jeffandbetsy.net> wrote:
> On Thu, May 7, 2009 at 2:09 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>> With the next major release, "git push" into a branch that is
>> currently checked out will be refused by default. =A0You can choose
>> what should happen upon such a push by setting the configuration
>> variable receive.denyCurrentBranch in the receiving repository.
>>
>
> I want to make sure I understand how this will work.  Could you
> describe the simplest set of steps necessary to get into this
> situation where the push would be refused?

Most common scenario, happens often on irc, is you clone
repo A to repo B, make some changes, and push.  If all the
defaults (simplest case) are used repo A has "master"
checked out, and repo B then tries to push to that same
(checked out) branch.

So:
    mkdir A; cd A; git init; make-some-commits
    cd ..;git clone A B;cd B; make-some-other-commits
    # and then
    git push    # from master on B to master on A
