From: Steve <shrotty@gmx.ch>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 10:50:48 +0000 (UTC)
Message-ID: <loom.20090320T104949-52@post.gmane.org>
References: <loom.20090320T094550-421@post.gmane.org> <49C3721E.7000005@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkcLP-0000aU-EC
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbZCTKvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZCTKvH
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:51:07 -0400
Received: from main.gmane.org ([80.91.229.2]:56145 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbZCTKvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:51:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LkcJY-0008Ac-81
	for git@vger.kernel.org; Fri, 20 Mar 2009 10:51:00 +0000
Received: from 172.120.221.87.dynamic.jazztel.es ([87.221.120.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 10:51:00 +0000
Received: from shrotty by 172.120.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 10:51:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.120.172 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.7) Gecko/2009021906 Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113939>

> I had this happen once after having upgraded git on the server in question and
> then running "git gc" against a repo. I didn't remove the old (not packed-refs
> knowing) git though, and when I later tried to push to it, it couldn't find
> any refs since the old receive-pack was being used, and it didn't know about
> packed refs.

Which file/contents do I have to look for or remove in order to kick the old not
packed refs?
