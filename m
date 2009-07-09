From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: 'git svn fetch' keeps giving a error after freezing
Date: Thu, 09 Jul 2009 10:51:21 +0200
Message-ID: <h34b32$6v8$1@ger.gmane.org>
References: <h31vg6$b38$1@ger.gmane.org> <20090708235900.GB20768@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 10:52:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpMN-0005j5-5h
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZGIIwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 04:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbZGIIwA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:52:00 -0400
Received: from main.gmane.org ([80.91.229.2]:36868 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbZGIIwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 04:52:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MOpME-0002ui-Gu
	for git@vger.kernel.org; Thu, 09 Jul 2009 08:51:58 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 08:51:58 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 08:51:58 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <20090708235900.GB20768@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122952>

Eric Wong wrote:
> 
> Does restarting "git svn fetch" work?  Can you checkout exactly that
> revision from SVN itself?  It could be an extremely large file that
> SVN has trouble serving, but as far as I can tell it's a problem
> with the server or your connection and not with git svn.

We have a 4MB ADSL connection to our office. Yes, "git svn fetch" does 
continue for a while, then bombs out again. This morning I saw for the 
first time in 2 days new revisions being pulled in, so clearly that one 
revision was a very large one. But still today, the "git svn fetch" 
bombs out at least every 30 minutes, so I have to constantly keep 
restarting it.

I have no idea what the remote server's internet connection is like. I 
just know pulling in 14,000 revisions by restarting every 30 minutes is 
going to take a damn long time. ;-)

[  I have SVN! Git is SO much faster!  ]


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
