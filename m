From: David Kastrup <dak@gnu.org>
Subject: Re: [user] git-svn and svn cp
Date: Mon, 19 Nov 2007 13:50:22 +0100
Message-ID: <86k5oez9f5.fsf@lola.quinscape.zz>
References: <47416F68.9070908@ogersoft.at> <vpq3av25sg0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 13:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu65r-0006ER-MG
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 13:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbXKSMuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 07:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbXKSMuu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 07:50:50 -0500
Received: from main.gmane.org ([80.91.229.2]:51122 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbXKSMut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 07:50:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu65J-0006wJ-Nh
	for git@vger.kernel.org; Mon, 19 Nov 2007 12:50:41 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 12:50:41 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 12:50:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:jSLzcdF9/fdopPTZv0Bw78GtFn4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65433>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> gerhard.oettl.ml@ogersoft.at writes:
>
>> I hope this is the correct mailing list. If not please point me in the
>> right direction.
>>
>>
>> I played a little with git (1.5.3.4 / debian) and had the following
>> observation:
>> Doing a "svn cp" (for example for a tag) results in a large traffic
>> when doing a "git-svn fetch" afterwards.
>>
>> To verify I did:
>> git-svn clone -s svn://www.ogersoft.at/ogerlit
>
> I guess the --tags=... and --branches=... options of git-svn can help.

You are aware of what the "-s" option does?

-- 
David Kastrup
