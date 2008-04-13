From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Remove broken branch creation subtest
Date: Sun, 13 Apr 2008 08:02:23 +0200
Message-ID: <20080413060223.GA27382@diana.vm.bytemark.co.uk>
References: <20080412124212.27748.21332.stgit@yoghurt> <7vabjzhrsa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 08:03:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkvJV-0003oR-Bl
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 08:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYDMGCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 02:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbYDMGCn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 02:02:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1539 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYDMGCm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 02:02:42 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JkvIF-00078m-00; Sun, 13 Apr 2008 07:02:23 +0100
Content-Disposition: inline
In-Reply-To: <7vabjzhrsa.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79390>

On 2008-04-12 11:06:13 -0700, Junio C Hamano wrote:

> You got me worried here.
>
>  * "git show-ref" issues "error: refs/heads/foo points nowhere!" in a=
ll
>    cases, which is not bad.
>
>  * broken foo does not prevent "git show-ref" (no patterns) from carr=
ying
>    out its primary task.  It goes on showing others.  There is no bad=
 here
>    either.
>
>  * "git show-ref refs/heads/foo" errors out with 1, which is Ok.
>
>  * "git show-ref master" shows all the ones ending with "master", exi=
ts
>    with 0, which is Ok.

Sorry for making you all worried, when I could have tested this
behavior myself and saved you the trouble ...

> It may be worth fixing the test than working it around, if only
> cleaning up is the issue.

Yes, that does seem more constructive. Will try to whip up a
replacement patch later today.

Thanks for the review.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
