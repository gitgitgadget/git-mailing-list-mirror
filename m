From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.3.0-rc0
Date: Wed, 14 Jan 2015 14:11:52 +0100
Message-ID: <87egqxfqw7.fsf@gmail.com>
References: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 14:12:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBNk4-0005LT-Ow
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 14:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbbANNMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 08:12:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:54322 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbANNMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 08:12:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YBNjv-0005HY-1H
	for git@vger.kernel.org; Wed, 14 Jan 2015 14:12:03 +0100
Received: from host57-2.natpool.mwn.de ([138.246.2.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 14:12:03 +0100
Received: from chneukirchen by host57-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 14:12:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: host57-2.natpool.mwn.de
In-Reply-To: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 12 Jan 2015 15:57:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262386>

Junio C Hamano <gitster@pobox.com> writes:

>  * "git push" into a repository with a working tree normally refuses
>    to modify the branch that is checked out.  The command learned to
>    optionally do an equivalent of "git reset --hard" only when there
>    is no change to the working tree and the index instead, which would
>    be useful to "deploy" by pushing into a repository.

Perhaps this can mention "receive.denyCurrentBranch=updateInstead" so
interested users won't have to grep the tree for 10min to find it. :)

Thanks,
-- 
Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
