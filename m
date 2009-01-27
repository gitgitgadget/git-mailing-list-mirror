From: David Abrahams <dave@boostpro.com>
Subject: "malloc failed"
Date: Tue, 27 Jan 2009 10:04:42 -0500
Message-ID: <878wow7pth.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 16:12:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRpbF-0000Xf-1M
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 16:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZA0PKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 10:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZA0PKI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 10:10:08 -0500
Received: from main.gmane.org ([80.91.229.2]:56963 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbZA0PKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 10:10:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LRpZi-0000Bg-Se
	for git@vger.kernel.org; Tue, 27 Jan 2009 15:10:02 +0000
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:10:02 +0000
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:oR+3laptRg8GEcpZsUhIIDuwl8s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107349>


I've been abusing Git for a purpose it wasn't intended to serve:
archiving a large number of files with many duplicates and
near-duplicates.  Every once in a while, when trying to do something
really big, it tells me "malloc failed" and bails out (I think it's
during "git add" but because of the way I issued the commands I can't
tell: it could have been a commit or a gc).  This is on a 64-bit linux
machine with 8G of ram and plenty of swap space, so I'm surprised.

Git is doing an amazing job at archiving and compressing all this stuff
I'm putting in it, but I have to do it a wee bit at a time or it craps
out.  Bug?

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
