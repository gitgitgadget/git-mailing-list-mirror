From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: git submodule status not describing modules
Date: Wed, 12 Mar 2008 19:15:00 +0000 (UTC)
Message-ID: <loom.20080312T191048-242@post.gmane.org>
References: <loom.20080312T151743-186@post.gmane.org> <loom.20080312T190414-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 20:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZWQd-00076G-Fl
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbYCLTPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYCLTPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:15:16 -0400
Received: from main.gmane.org ([80.91.229.2]:39455 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbYCLTPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:15:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZWPs-00014b-MQ
	for git@vger.kernel.org; Wed, 12 Mar 2008 19:15:08 +0000
Received: from host6-21-dynamic.58-82-r.retail.telecomitalia.it ([82.58.21.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 19:15:08 +0000
Received: from sergio.callegari by host6-21-dynamic.58-82-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 19:15:08 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.58.21.6 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76976>

... and it is because I have no url defined for the submodules.
Is there any particular reason for testing the url in cmd_status as in

if test -z "$url" || ! test -d "$path"/.git
                then
                        say "-$sha1 $path"
                        continue;
                fi

nothing in the following seems to depend on it.
