From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 02:26:20 +0200
Message-ID: <86zlzfwno3.fsf@lola.quinscape.zz>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<86abrfy377.fsf@lola.quinscape.zz>
	<7vvea3h7sn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 02:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsqG-0008JR-IQ
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbXIVA0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXIVA0j
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:26:39 -0400
Received: from main.gmane.org ([80.91.229.2]:46777 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbXIVA0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:26:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IYspI-0006Dg-5E
	for git@vger.kernel.org; Sat, 22 Sep 2007 00:26:28 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 00:26:28 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 00:26:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:FyRD/iw67SDP2UXDZdCQryKjsRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58902>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> But doing a break inside of the while _condition_ rather than the body
>> just feels wrong to me.
>
> Sorry, but that is not the issue on the thread is about.

It is still relevant:

> BSD shell is failing the whole case statement when there is no
> matching case arm.

Sure, that is a bug.  But in my opinion the idiom as such is ugly
enough not be worth keeping anyhow.  The proposal of the patch
submitter was making an already ugly idiom even uglier for the sake of
his shell.  I agree that this is not the way to go.

I was proposing replacing the idiom by something which I find cleaner.
That it will most likely work with the original poster's shell is more
or less a side effect.  At least it is a side effect that might
motivate somebody else rather than me to do the cleanup work (and have
a buggy test shell to see whether he got everything indeed).

-- 
David Kastrup
