From: Gelonida <gelonida@gmail.com>
Subject: Re: export one commit id from a repository
Date: Sun, 23 May 2010 12:08:50 +0200
Message-ID: <htauri$17m$1@dough.gmane.org>
References: <ht8mu6$hjo$1@dough.gmane.org> <20100522135047.GA10999@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 23 12:09:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG87M-00075w-4v
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 12:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab0EWKJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 06:09:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:59658 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab0EWKJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 06:09:02 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OG879-000725-6b
	for git@vger.kernel.org; Sun, 23 May 2010 12:08:59 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 May 2010 12:08:59 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 23 May 2010 12:08:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <20100522135047.GA10999@toroid.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147569>

Thanks a lot for your answer.

That's what I was looking for :-)

Abhijit Menon-Sen wrote:
> At 2010-05-22 15:41:26 +0200, gelonida@gmail.com wrote:
>> I'd like to be able to concurrently (multiuser) create tar files from
>> certain commmit ids.
> 
> git archive --prefix=foo/ $sha1 | gzip > foo.tar.gz
> 
> See git-archive(1).
> 
> -- ams
