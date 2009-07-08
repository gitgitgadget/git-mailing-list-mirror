From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: 'git svn fetch' keeps giving a error after freezing
Date: Wed, 08 Jul 2009 13:21:24 +0200
Message-ID: <h31vg6$b38$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 13:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOVEM-0002uC-41
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 13:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbZGHLWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 07:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbZGHLWD
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 07:22:03 -0400
Received: from main.gmane.org ([80.91.229.2]:58573 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755549AbZGHLWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 07:22:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MOVDn-0007Wh-IP
	for git@vger.kernel.org; Wed, 08 Jul 2009 11:21:55 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 11:21:55 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 11:21:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122895>

Hi,

I'm using git-1.6.3.3 under Ubuntu Linux 8.04.2

I'm trying to convert (clone) a SubVersion repository to Git, so I can 
host the mirror on GitHub, but for the last 4 days I don't get very far. 
It seems to be getting a few files, then freezes and then gives the 
error shown below. I'm now stuck around r2665 out of about 14,000 
revisions. :-(

I have done such a clone before using a different SVN repository and 
pulling in around 13,000 revisions, so my 'git svn' commands should work.

==============================
$ git svn fetch
.....
         A       fixes_2_0/fv/gadgets.pas
         A       fixes_2_0/fv/colortxt.pas
         A       fixes_2_0/fv/outline.pas
RA layer request failed: REPORT of '/svn/fpc/!svn/vcc/default': Could 
not read response body: connection was closed by server 
(http://svn2.freepascal.org) at /usr/local/libexec/git-core/git-svn line 
4505
==============================

.git/config file contains the following (showing the SubVersion repository)

======================
...snip...
[svn-remote "svn"]
	url = http://svn2.freepascal.org/svn/fpc
	fetch = trunk:refs/remotes/trunk
	branches = branches/*:refs/remotes/*
	tags = tags/*:refs/remotes/tags/*
...snip...
======================


Any thoughts on why I am getting this error?


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
