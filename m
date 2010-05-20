From: Andy Parkins <andyparkins@gmail.com>
Subject: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 11:01:02 +0100
Message-ID: <ht3194$1vc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:01:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2ZA-0005uJ-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab0ETKBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:01:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:38690 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755377Ab0ETKBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:01:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OF2Z2-0005hn-4o
	for git@vger.kernel.org; Thu, 20 May 2010 12:01:16 +0200
Received: from 194.70.53.228 ([194.70.53.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 12:01:16 +0200
Received: from andyparkins by 194.70.53.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 12:01:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.228
User-Agent: KNode/4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147372>

Hello,

I've just upgraded from 1.6.something to 1.7.1.  All very nice.

The new submodule reporting is nice too; but I'd like to be able to turn it 
off :-)

The problem is that I have a (relatively) small project as the supermodule, 
and a linux kernel clone as a submodule and an ffmpeg clone as a submodule.  
Now I used to be able to do git-status or git-diff and it would be instant, 
it now takes a number of seconds to report.  I guess (but don't know), that 
it is the detection of "dirty" status in the submodule's that is slowing 
down the supermodule processing.

I wouldn't like to see the feature go, because in almost all circumstances 
it is exactly right; however, I'd like to be able to turn off dirty 
detection in submodules.  Is this already possible, and I've just missed the 
configuration option?

One additional small point: why do untracked files in a submodule make the 
module dirty?  I've often got a few "temp.ps" or "debug.log" or 
"backtrace.log" files lying around -- inappropriate to add to an ignore 
file, but they don't make my working directory dirty.  "Dirty" in a working 
directory means uncommitted changes to tracked files, why does it mean 
something different in a submodule?



Andy
-- 
Dr Andy Parkins
andyparkins@gmail.com
