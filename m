From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn in 1.5.4~rc2 somewhat broken?
Date: Sun, 30 Dec 2007 17:33:20 +0100
Message-ID: <87bq88ywfj.fsf@mid.deneb.enyo.de>
References: <87wsqw49dj.fsf@mid.deneb.enyo.de>
	<20071230160758.GA7520@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 17:33:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J916k-0001WG-GV
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 17:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbXL3QdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 11:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756948AbXL3QdZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 11:33:25 -0500
Received: from mail.enyo.de ([212.9.189.167]:1152 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbXL3QdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 11:33:24 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1J916H-0008VS-PH; Sun, 30 Dec 2007 17:33:21 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1J916G-0003Qm-7T; Sun, 30 Dec 2007 17:33:20 +0100
In-Reply-To: <20071230160758.GA7520@dervierte> (Steven Walter's message of
	"Sun, 30 Dec 2007 11:07:58 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69372>

* Steven Walter:

>> Last fetched revision of refs/remotes/git-svn was r45313, but we are
>> about to fetch: r851!
>
> Messages like these usually mean you've changed refs/remotes/trunk,
> which will confuse git-svn unless you know what you're doing.

Uhm, I don't recall doing such a thing.

> Fortunately, you can usually "rm -rf .git/svn" and git-svn will sort
> itself out on the next fetch.

Yeah, this has fixed it for me.  Thanks.
