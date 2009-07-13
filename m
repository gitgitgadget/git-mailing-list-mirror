From: Peter Voss <info@petervoss.org>
Subject: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 11:57:24 +0200
Message-ID: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 11:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQIHy-0006AD-EY
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 11:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbZGMJ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 05:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbZGMJ51
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 05:57:27 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:19773 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbZGMJ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 05:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1247479044; l=867;
	s=domk; d=petervoss.org;
	h=Date:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:To:
	From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=rGl+gegXtoPHcOxbp7TA40u2K5g=;
	b=tMbE1RLu9f/HRWm5bpUH5cDoqCtwsrubfkL9nRYTothx6KjDZofPsBs4zpX52reN2/5
	oqxMdy3TQ/mk8+1PQNOj8IzdaiOIXslAZ+S44swHpEX0K6I3RXf/q678uuUt1TNT55Nx/
	LuhVN5DCq5qTXBzQSgKSW0pL0wBLklE7iwo=
X-RZG-AUTH: :JWICemC4fusRF4tAhweiuU4SRqyWF3gXMlHyMhzObhKwDIReNIDrirxOEFeT
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.108]
	(ip-62-143-242-232.unitymediagroup.de [62.143.242.232])
	by post.strato.de (klopstock mo22) (RZmta 18.49)
	with ESMTP id R0032al6D9kVZS for <git@vger.kernel.org>;
	Mon, 13 Jul 2009 11:57:24 +0200 (MEST)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123181>

Hi,

I want to use the git submodule feature to move part of my code to a  
different repository at github.

The issue is that developers should use different repository URLs for  
the submodule depending on whether they have commit rights or not.

At the beginning I was using the public URL to set-up the submodule:
git submodule add git://github.com/x/mymodule.git mymodule

The issue is that some developers are working behind a firewall that  
blocks the git protocol. These could only use the git@github.com:x/ 
mymodule.git URL to get access.
But other developers can only go through the public URL git:// 
github.com/x/mymodule.git. So whatever I use it won't work for  
everybody.

What's the best way to deal with that? Could I set-up different  
repository URLs for one and the same submodule and use which one is  
appropriate?

Thanks,
--Peter
