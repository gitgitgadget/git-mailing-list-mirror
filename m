From: Frans Pop <elendil@planet.nl>
Subject: Re: Conflicting "-n" short options for git-pull?
Date: Sun, 16 Sep 2007 13:17:11 +0200
Message-ID: <200709161317.12339.elendil@planet.nl>
References: <200709152114.54985.elendil@planet.nl> <7vfy1f8pmm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 13:17:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWs7s-0002ER-Na
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 13:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbXIPLRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 07:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbXIPLRQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 07:17:16 -0400
Received: from hpsmtp-eml15.kpnxchange.com ([213.75.38.115]:50321 "EHLO
	hpsmtp-eml15.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751508AbXIPLRP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 07:17:15 -0400
Received: from hpsmtp-eml05.kpnxchange.com ([213.75.38.105]) by hpsmtp-eml15.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 16 Sep 2007 13:17:13 +0200
Received: from faramir.fjphome.nl ([84.85.147.182]) by hpsmtp-eml05.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 16 Sep 2007 13:17:12 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <7vfy1f8pmm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-OriginalArrivalTime: 16 Sep 2007 11:17:12.0635 (UTC) FILETIME=[213390B0:01C7F853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58312>

On Sunday 16 September 2007, Junio C Hamano wrote:
> Frans Pop <elendil@planet.nl> writes:
> > According to the man page for git-pull from git-core 1.5.3.1 (Debian
> > package), two options are defined as having the short option "-n":
> >
> >      -n, --no-summary
> >          Do not show diffstat at the end of the merge.
> > [...]
> >      -n, --no-tags
> >          By default, git-fetch fetches tags that point at objects that
> > are downloaded from the remote repository and stores them locally. This
> > option disables this automatic tag following.
>
> The manpage option descriptions are shared between the
> commands.  Maybe we should drop mention of the shorthand form.

Not sure if that last is the correct solution. Wouldn't it mean that short 
options would not be documented at all anymore?

> When git-fetch is used -n means --no-tags because there is no
> other -n; when git-pull indirectly invokes git-fetch, you need
> to spell it --no-tags because --no-summary takes precedence.

That does explain, but it is not at all obvious from the documentation.
Guess this is a general "problem" in git then.


Another question.
Is it possible to set default options for commands somehow?
I'd like to run git-pull with '--no-summary' by default. I could of course 
define an alias, but that only covers 'git-pull' and not 'git pull'.
Does git itself have some mechanism for this?

Thanks,
Frans Pop
