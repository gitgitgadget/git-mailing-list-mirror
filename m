From: Kevin Ballard <kevin@sb.org>
Subject: git-svn pulling down duplicate revisions
Date: Mon, 19 May 2008 17:26:58 -0700
Message-ID: <1AD7D1A1-EC3B-450D-A648-04ADB8180E46@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 02:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyFhs-0001VM-B9
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 02:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294AbYETA1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 20:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757546AbYETA1B
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 20:27:01 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:53296 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756854AbYETA1A (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 20:27:00 -0400
Received: from [10.100.18.156] (dsl092-049-214.sfo4.dsl.speakeasy.net [66.92.49.214])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id DCE25EF3CC;
	Mon, 19 May 2008 17:26:59 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82458>

I started a git-svn clone on a large svn repository, and I noticed  
that for various branches, it kept pulling down the exact same  
revisions (starting at r1). In other words, if I had 4 branches that  
shared common history, their common history all got pulled down 4  
times. I double-checked, and the created commit objects were identical.

Why was git-svn pulling down the same revisions over and over, when it  
already knows it has a commit object for those revisions?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
