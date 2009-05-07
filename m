From: Jonathan Harker <jonathan@catalyst.net.nz>
Subject: git repack with a --reference
Date: Thu, 07 May 2009 16:21:44 +1200
Message-ID: <4A0261D8.8040105@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 06:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1vPe-0006Bj-5L
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 06:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbZEGEkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 00:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbZEGEkj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 00:40:39 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:43821 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZEGEkj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 00:40:39 -0400
X-Greylist: delayed 1128 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2009 00:40:38 EDT
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.90])
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <jonathan@catalyst.net.nz>)
	id 1M1v7B-0004dc-2X
	for git@vger.kernel.org; Thu, 07 May 2009 16:21:45 +1200
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118423>

Hi - hope this isn't too noobish but I'm trying to get an existing git
checkout to repack/prune/gc itself such that it would be like I had
cloned it with --reference /path/to/local/repo (i.e. I've added
/path/to/local/repo to .git/objects/info/alternatives, and I'd like it
to reduce its objects from 200 MB to 5 MB). Is this

a. possible,

b. desirable, and

c. not insane?

Cheers,
Jonathan Harker
http://catalyst.net.nz/
