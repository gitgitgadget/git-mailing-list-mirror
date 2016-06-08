From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Wed, 08 Jun 2016 20:31:12 +0200
Message-ID: <874m93y1lb.fsf@free.fr>
References: <87a8iy6s4e.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 20:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAiKS-0003M9-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423779AbcFHScM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2016 14:32:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:47224 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423295AbcFHScG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:32:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bAiGX-0008B8-7j
	for git@vger.kernel.org; Wed, 08 Jun 2016 20:31:45 +0200
Received: from arennes-651-1-298-135.w2-12.abo.wanadoo.fr ([2.12.1.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 20:31:45 +0200
Received: from pmlists by arennes-651-1-298-135.w2-12.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 20:31:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-651-1-298-135.w2-12.abo.wanadoo.fr
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:P0OwJpu8gI4xh0nHjrNrjCtMRj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296829>

On Mon, Jun 06 2016, Peter M=C3=BCnster wrote:

> It would be nice, if timestamps could be preserved when rewriting the
> git-log.
>
> Use case: I often make a dcommit after several days of development
> (20 or 30 commits), because
> - the users of the svn-server don't need it more often;
> - and for the dcommit I need a VPN-connection to a server, that is no=
t
>   always available.
>
> Today, after a dcommit, it's no more possible to match a special comm=
it
> by time and date (for example the time of some email exchange).
>
> TIA for your attention and perhaps the implementation of such a featu=
re.

Hi,

Or could someone please show me, where the timestamp is rewritten in th=
e
code, so that I could change it and compile a local copy of git, that
fits my needs? Perhaps I could even create a patch, that implements
"--preserve-timestamps" and send it back.

I've already searched in git-svn.perl but without success... :(

TIA for any hints,
--=20
           Peter
