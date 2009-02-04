From: Adam Thorsen <adam.thorsen@gmail.com>
Subject: segfault during clone via http
Date: Wed, 4 Feb 2009 16:10:00 +0000 (UTC)
Message-ID: <loom.20090204T160827-822@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 17:16:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkQT-0003mw-H6
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbZBDQPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbZBDQPG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:15:06 -0500
Received: from main.gmane.org ([80.91.229.2]:56479 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbZBDQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:15:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LUkP0-0000Vv-Pm
	for git@vger.kernel.org; Wed, 04 Feb 2009 16:15:03 +0000
Received: from adsl-69-104-3-111.dsl.pltn13.pacbell.net ([69.104.3.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:15:02 +0000
Received: from adam.thorsen by adsl-69-104-3-111.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.104.3.111 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.6) Gecko/2009011912 Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108390>

Git is segfaulting when downloading from a repo via http.  Here's what the
output looks like: http://gist.github.com/58167.  Anybody seen this before or
know how I can debug it?  I've made sure my git (1.6.1) is compiled with libcurl.
