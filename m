From: Alejandro Riveira <ariveira@gmail.com>
Subject: [BUG] git bisect visualize crash
Date: Wed, 3 Dec 2008 11:20:29 +0000 (UTC)
Message-ID: <gh5q1t$qjn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 12:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7pnp-0000pv-2t
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYLCLUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbYLCLUl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:20:41 -0500
Received: from main.gmane.org ([80.91.229.2]:44621 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYLCLUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 06:20:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L7pmX-0000X2-Go
	for git@vger.kernel.org; Wed, 03 Dec 2008 11:20:37 +0000
Received: from 197.red-83-53-124.dynamicip.rima-tde.net ([83.53.124.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 11:20:37 +0000
Received: from ariveira by 197.red-83-53-124.dynamicip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 11:20:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 197.red-83-53-124.dynamicip.rima-tde.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102242>

i'm using ubuntu 8.10 and git bisect visualize is crashing.
Noticed when bisecting the kernel but it is easily reproducible

in git repository as of today

$ git bisect bad
$ git bisect good HEAD~20

$ git bisect visualize                                                                  (03-12 12:16)
Error in startup script: can't read "notflag": no such variable
    while executing
"expr {!$notflag}"
    ("--not" arm line 2)
    invoked from within
"switch -glob -- $arg {
            "-d" -
            "--date-order" {
                set vdatemode($n) 1
                # remove from origargs in case we hit an unknown option
                set origarg..."
    (procedure "parseviewargs" line 21)
    invoked from within
"parseviewargs $view $args"
    (procedure "start_rev_list" line 27)
    invoked from within
"start_rev_list $curview"
    (procedure "getcommits" line 5)
    invoked from within
"getcommits {}"
    (file "/usr/local/bin/gitk" line 10897)

$ git --version
git version 1.6.1.rc1
$
