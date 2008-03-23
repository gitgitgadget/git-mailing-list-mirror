From: "H. Peter Anvin" <hpa@zytor.com>
Subject: What I miss from Cogito...
Date: Sun, 23 Mar 2008 10:15:48 -0700
Message-ID: <47E69044.3000207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdTo8-0002Ft-SJ
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbYCWRPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYCWRPv
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:15:51 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51290 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbYCWRPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 13:15:50 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m2NHFnLc026546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 10:15:50 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m2NHFn6l031468;
	Sun, 23 Mar 2008 10:15:49 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m2NHFmYg005507;
	Sun, 23 Mar 2008 10:15:49 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
X-Virus-Scanned: ClamAV 0.92.1/6005/Tue Feb 26 14:01:21 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77926>

This much later, there are a few minor things I still miss from Cogito. 
  I believe fixing either would be quite trivial, so I thought I'd post 
a note.

1. The ability to clone into the current directory

    cg-clone had a -c option, which allowed cloning into the current
    directory.  This is particularly useful, since I keep my common
    dot files in a git repository, so all I need to do to set up a new
    machine is to clone that git repository over my empty home directory.

    Native git doesn't have any equivalent, other than:

    git clone -n .... tmp
    mv tmp/.git .
    rm -rf tmp
    git checkout HEAD


2. cg-restore

    Cogito separated "reset" and "restore".  This is a syntactic sugar
    issue, but having to type "git reset --hard -- path" makes me
    nervous, especially since hitting Enter at the wrong time could have
    serious and irrevocable consequences.

    I also note that this particular use of "git reset" is actually
    undocumented, but it seems to work.


Those are pretty much the only Cogito command I have found myself either 
missing or using since I made a mental note to track this stuff, a few 
months ago.

	-hpa
