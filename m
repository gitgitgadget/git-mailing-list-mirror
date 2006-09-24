From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig 0.5
Date: Mon, 25 Sep 2006 01:31:12 +0200
Message-ID: <20060924233112.GB695@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 01:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRdRS-0003bj-SV
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWIXXbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWIXXbT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:31:19 -0400
Received: from [130.225.96.91] ([130.225.96.91]:60859 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751360AbWIXXbS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:31:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 829CE770072
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:31:15 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18754-14 for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:31:12 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id E920977006C
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:31:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 4749B6DF84F
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 01:29:16 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id CDD9162A3D; Mon, 25 Sep 2006 01:31:12 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27717>

Hello,

After a long break a few changes have started to accumulate so here is
version 0.5 of tig. It adds some basic features like searching and
support for keybindings (see tigrc(5)). Additionally, It fixes most of
the things I would have hoped to include in this release. I tried to fix
the problems reported with terminal encoding by using iconv, but earlier
tonight I found that it needs some more work.

Looking forward, better input support is much desired, plus I'd like to
review the drawing code to see if it can be optimized to do fewer
updates. Also, a blame view is in the pipeline and I have a proof of
concept implementation of revision graph rendering (it is available in
the new/rev-graph branch).

A list of tig resources:

 - Homepage: http://jonas.nitro.dk/tig/
 - Releases: http://jonas.nitro.dk/tig/releases/
 - Git URL:  http://jonas.nitro.dk/tig/tig.git or
             git://repo.or.cz/tig.git
 - Gitweb:   http://repo.or.cz/?p=tig.git;a=summary

Tarballs contain all the generated documentation, as do the #release
branch of the git repository.

-- 
Jonas Fonseca
