From: Dave Abrahams <dave@boostpro.com>
Subject: Bug with URL-decoding
Date: Thu, 6 May 2010 22:06:50 +0000 (UTC)
Message-ID: <loom.20100507T000406-241@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:07:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9Du-0004uH-JU
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab0EFWHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:07:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:39044 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab0EFWHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:07:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OA9Dj-0004nd-EG
	for git@vger.kernel.org; Fri, 07 May 2010 00:07:03 +0200
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 00:07:03 +0200
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 00:07:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.223.249 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146500>

$ cd /tmp
$ mkdir x+y
$ cd x+y
$ git init
$ cd ..
$ git clone file:///tmp/x%2By zz  # <==== ERROR
$ git clone file:///tmp/x+y zz # <====== OK

Funny characters do come up in names, especially in test suites
