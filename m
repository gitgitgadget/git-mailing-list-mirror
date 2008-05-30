From: david@lang.hm
Subject: post-receive hook
Date: Fri, 30 May 2008 01:10:49 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805300108140.4014@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 10:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1zi6-0000wX-LF
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 10:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbYE3IKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 04:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbYE3IKn
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 04:10:43 -0400
Received: from mail.lang.hm ([64.81.33.126]:38842 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbYE3IKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 04:10:42 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m4U8AfK8019984
	for <git@vger.kernel.org>; Fri, 30 May 2008 01:10:41 -0700
X-X-Sender: dlang@asgard.lang.hm
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83274>

I'm trying to setup a post-receive hook to do a checkout -f when I push to 
a public repo (it's a web based tool and I want the executables to be 
updated with a push)

unfortunantly if I just add git checkout -f to the post-receive hooks it 
checks the files out in the .git directory.

if I do a cd .. ; git checkout -f I get an error message complaining that 
it's not in a git repository, but if I manually cd to that directory and 
do a checkout it works.

what am I missing here?

David Lang
