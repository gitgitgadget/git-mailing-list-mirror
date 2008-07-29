From: Eric Raible <raible@gmail.com>
Subject: Re: git-attic
Date: Tue, 29 Jul 2008 16:51:30 +0000 (UTC)
Message-ID: <loom.20080729T164914-281@post.gmane.org>
References: <488F05B2.6060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 18:52:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNsRN-00053J-Fm
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 18:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYG2Qvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbYG2Qvt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 12:51:49 -0400
Received: from main.gmane.org ([80.91.229.2]:49990 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbYG2Qvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 12:51:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNsQJ-0006BN-7W
	for git@vger.kernel.org; Tue, 29 Jul 2008 16:51:43 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 16:51:43 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 16:51:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90657>

Paul Gideon Dann <pdgiddie <at> googlemail.com> writes:

>       OBJECT_SHA1=`git show-ref -h HEAD | awk '{print $1}'`

OBJECT_SHA1=`git show-ref --hash --head HEAD`
