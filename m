From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Commiting automatically (2)
Date: Mon, 20 Dec 2010 05:12:57 +0000 (UTC)
Message-ID: <loom.20101220T060758-200@post.gmane.org>
References: <loom.20101219T090500-396@post.gmane.org> <20101219150850.GC12136@foodlogiq3-xp-d620.thebe.ath.cx> <20101219183619.GB11955@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 06:13:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUY3n-0004sG-Uk
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 06:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab0LTFNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 00:13:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:60033 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572Ab0LTFNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 00:13:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUY3Y-0004lY-58
	for git@vger.kernel.org; Mon, 20 Dec 2010 06:13:08 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 06:13:08 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 06:13:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163982>

Jonathan Nieder <jrnieder <at> gmail.com> writes:
> Hmm, the "git add" manual suggests it is the other way around:
> 
>  -A, --all
> 	Like -u, but match <filepattern> against files in the working
> 	tree in addition to the index. That means that it will find new
> 	files as well as staging modified content and removing files
> 	that are no longer in the working tree.
> 
> So I would expect "git add -A" to do the same thing as "git add -u",
> plus handling added files.
> 
> Maaartin, could you give an example showing where add -A goes wrong?

I can't, since I was wrong. These commits have two parents (I'm not sure if this 
is a good idea), and that's why I saw no changes in the log. Actually, "git add -
A" does everything I need, and with "/bin/cp .git/index $GIT_INDEX_FILE" 
everything seems to work. Sorry for the noise.
