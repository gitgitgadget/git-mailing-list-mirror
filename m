From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: warning: no common commits - slow pull
Date: Mon, 11 Feb 2008 16:54:42 +0100
Message-ID: <877ihbcwu5.fsf@mid.deneb.enyo.de>
References: <200802102007.38838.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 16:55:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOb07-0001DB-2J
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 16:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbYBKPys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 10:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbYBKPyr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 10:54:47 -0500
Received: from mail.enyo.de ([212.9.189.167]:2443 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754815AbYBKPyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 10:54:47 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1JOazV-0001VP-21
	for git@vger.kernel.org; Mon, 11 Feb 2008 16:54:45 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1JOazS-0003Jq-Jd
	for git@vger.kernel.org; Mon, 11 Feb 2008 16:54:42 +0100
In-Reply-To: <200802102007.38838.lenb@kernel.org> (Len Brown's message of
	"Sun, 10 Feb 2008 20:07:38 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73543>

* Len Brown:

> But this second pull seems to have re-downloaded 172MB,
> when it should have only needed the last few commits.

I've got a linux-2.6 tree which is reasonable up to date, but which has
been created by some acient GIT version.  I see the same behavior from
time to time.  The second pull, after I've canceled the first one,
usually downloads just the expected data.
