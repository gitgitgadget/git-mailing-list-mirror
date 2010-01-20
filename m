From: Tim Michelsen <timmichelsen@gmx-topmail.de>
Subject: how to clone from github behindd a proxy?
Date: Wed, 20 Jan 2010 09:29:16 +0000 (UTC)
Message-ID: <loom.20100120T102323-689@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXY41-0004lm-6K
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab0ATKpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428Ab0ATKpN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:45:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:37556 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670Ab0ATKpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 05:45:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXY3d-0004c4-Jp
	for git@vger.kernel.org; Wed, 20 Jan 2010 11:45:05 +0100
Received: from zd007.lif.de ([149.233.100.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:45:05 +0100
Received: from timmichelsen by zd007.lif.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 11:45:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 149.233.100.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.7) Gecko/20091221 Firefox/3.5.7 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137540>

Hello,
I tried to clone from behind a proxy firewall.

It doesn't work.

How shall I improve?

set GIT_CURL_VERBOSE=1

git config --global http.proxy proxy.example.com:8000

git clone http://github.com/rwl/traitsbackendpyjamas
Initialized empty Git repository in D:\sourcecode/traitsbackendpyjamas/.git/
* Couldn't find host github.com in the _netrc file; using defaults
* About to connect() to proxy proxy.example.com on port 8000 (#0)
*   Trying 149.233.100.7... * Connected to proxy.example.com (149.233.100.7)
port 8000 (#0)
 GET http://github.com/rwl/traitsbackendpyjamas/info/refs HTTP/1.1
User-Agent: git/1.6.5.1.1366.g8ed9
Host: github.com
Accept: */*
Proxy-Connection: Keep-Alive
Pragma: no-cache

* The requested URL returned error: 404
* Closing connection #0
fatal: http://github.com/rwl/traitsbackendpyjamas/info/refs not found: did you
run git update-server-info on the server?

Thanks in advance,
Timmie
