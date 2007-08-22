From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 15:00:12 +0200
Message-ID: <86absjenc3.fsf@lola.quinscape.zz>
References: <46CC3090.7080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 15:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INpqw-0007YQ-Ni
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 15:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbXHVNCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 09:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbXHVNCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 09:02:09 -0400
Received: from main.gmane.org ([80.91.229.2]:40111 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756800AbXHVNCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 09:02:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INppw-0002AQ-F7
	for git@vger.kernel.org; Wed, 22 Aug 2007 15:01:28 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 15:01:28 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 15:01:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:MIIrByR+cy+BIxLmpGCr/rJQCA8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56377>

Carlos Rica <jasampler@gmail.com> writes:

> This is the first version of the program "builtin-reset.c",
> intended for replacing the script "git-reset.sh".
>
> The --mixed option with -- paths is not implemented yet.
>
> The tests I made for it are not finished so they are not included,
> but it seems to pass the rest of the test suite.

Could you be so kind as to give a one-sentence summary what the
benefits over using a shell script would be?  I think this work has
started before I joined the list, and I'd be interested in the
motivation for it.  In general, I find shell scripts more pleasant for
hacking on than C code, and there is no long-term plan to replace all
of them, is there?  So unless there is some issue that can't be
addressed reliably or efficiently by reverting to other commands for
everything involving bulk processing, I am not really happy to see
shell scripts replaced.

Thanks,

-- 
David Kastrup
