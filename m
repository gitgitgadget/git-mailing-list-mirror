From: Dimitar Dobrev <dpldobrev@yahoo.com>
Subject: Bug: dcommit fails when a file with '@' in the name is renamed
Date: Wed, 28 Oct 2015 19:34:36 +0000 (UTC)
Message-ID: <loom.20151028T203335-110@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 20:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrWa3-0007Oz-0W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 20:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbbJ1TkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 15:40:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:42997 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbbJ1TkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 15:40:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZrWZn-0007C0-D3
	for git@vger.kernel.org; Wed, 28 Oct 2015 20:40:03 +0100
Received: from 84-238-128-84.btc-net.bg ([84-238-128-84.btc-net.bg])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 20:40:03 +0100
Received: from dpldobrev by 84-238-128-84.btc-net.bg with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 20:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.238.128.84 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:41.0) Gecko/20100101 Firefox/41.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280393>

    When a file with '@' in the name is renamed - for example moved -
dcommit fails with:


    Assertion failed: (svn_uri_is_canonical(child_uri, NULL)), function
uri_skip_ancestor, file subversion/libsvn_subr/dirent_uri.c, line 1520.

     error: git-svn died of signal 6


    I have sent a fix at https://github.com/git/git/pull/184.
