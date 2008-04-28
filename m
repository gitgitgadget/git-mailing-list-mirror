From: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
Subject: Simple problem
Date: Mon, 28 Apr 2008 16:31:05 +0000 (UTC)
Message-ID: <fv4u49$oks$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 18:32:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWGq-0003Z3-VR
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934848AbYD1QbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934101AbYD1QbQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:31:16 -0400
Received: from main.gmane.org ([80.91.229.2]:57891 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934566AbYD1QbP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:31:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JqWG1-0002T3-2n
	for git@vger.kernel.org; Mon, 28 Apr 2008 16:31:13 +0000
Received: from pool-71-161-56-12.clppva.east.verizon.net ([71.161.56.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 16:31:13 +0000
Received: from kt-usenet by pool-71-161-56-12.clppva.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 16:31:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-161-56-12.clppva.east.verizon.net
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80555>

I ran into an issue earlier today that I didn't know how to easily solve 
in git.  I'm sure it is easy to handle, but I wasn't sure how.  

I removed a file and then realized I'd hit the wrong one.  So all I 
wanted to do was to get the file back the way it was in the last commit.  

Basically I wanted something similar to:

svn update myfile

in subversion.  

I got it back by using a diff and just deleting all the minus signs at 
the beginning of the lines, but I'm sure this isn't the way to handle 
this.  Strangely this simple case wasn't covered by any of the tutorials 
I looked at. 

Thanks.

-- 
Kenneth P. Turvey <kt-usenet@squeakydolphin.com>
