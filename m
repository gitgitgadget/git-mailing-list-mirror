From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Replace git --paginate by git --pager[=PAGER_CMD].
Date: Tue, 21 Aug 2007 11:19:16 +0200
Message-ID: <868x85gs8b.fsf@lola.quinscape.zz>
References: <fadhkv$amj$2@sea.gmane.org>
	<11876854283229-git-send-email-Matthieu.Moy@imag.fr>
	<Pine.LNX.4.64.0708211041170.16728@wbgn129.biozentrum.uni-wuerzburg.de>
	<vpqtzqte0dp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 11:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INPtm-0006iq-CZ
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 11:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXHUJTj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 05:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbXHUJTi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 05:19:38 -0400
Received: from main.gmane.org ([80.91.229.2]:58042 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbXHUJTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 05:19:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INPta-0003PB-Ds
	for git@vger.kernel.org; Tue, 21 Aug 2007 11:19:30 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 11:19:30 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 11:19:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:+ouO1tWqx5hT8nq+kwg0O5y62As=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56287>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Personally, I like to read "git --paginate log" better than to read "git 
>> --pager log".  So I would not unnecessarily deprecate --paginate.  It's 
>> not like it hurts or something.
>
> It doesn't "hurt", but having several options to do the same thing is
> useless and confusing (someone reading here about --paginate and there
> about --pager may not immediately notice that one is an alias for the
> other).
>
> Anyway, how often do you type or read "git --paginate log"?

Since it is the default anyway...

Maybe one should have a way to tell git "don't use a pager by default,
but _if_ someone says --pager, _then_ use the following pager".

If one has to set the pager to "cat" to disable paging, using --pager
will not exactly be impressive.

So maybe --no-pager/--pager (or an equivalent config file setting)
should not tamper with the setting of GIT_PAGER, but rather set/reset
an independent flag.

-- 
David Kastrup
