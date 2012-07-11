From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 2/4] Allow reading svn dumps from files via file:// urls.
Date: Wed, 11 Jul 2012 14:29:08 +0000 (UTC)
Message-ID: <loom.20120711T162346-654@post.gmane.org>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1342013933-14381-2-git-send-email-florian.achleitner.2.6.31@gmail.com> <1342013933-14381-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 16:29:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Soxv0-0003Bq-0x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 16:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab2GKO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 10:29:22 -0400
Received: from plane.gmane.org ([80.91.229.3]:51531 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968Ab2GKO3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 10:29:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Soxuq-00032y-Cd
	for git@vger.kernel.org; Wed, 11 Jul 2012 16:29:20 +0200
Received: from 87.250.248.20 ([87.250.248.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 16:29:20 +0200
Received: from divanorama by 87.250.248.20 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 16:29:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.250.248.20 (Opera/9.80 (X11; Linux x86_64; U; en) Presto/2.10.289 Version/12.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201303>

Florian Achleitner <florian.achleitner.2.6.31 <at> gmail.com> writes:

> 
> Especially for testing and development it's useful
> to bypass svnrdump and replay the svndump from a file
> without connecting to an svn server.
> 
> Add support for file:// urls in the remote url.
> e.g. svn::file:///path/to/dump
> When the remote helper finds an url starting with
> file:// it tries to open that file instead of invoking svnrdump.
file:// is a bad choice because file:// style repo urls are valid for svn and 
it's for local repos rather than dumpfiles. Maybe something like dumpfile:// 
instead?

[patch skipped]
