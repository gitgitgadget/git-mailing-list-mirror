From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 18:12:55 +0100
Organization: eudaptics software gmbh
Message-ID: <4602B917.5C2912F4@eudaptics.com>
References: <200702281036.30539.litvinov2004@gmail.com>
	 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
	 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
	 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------3FC416367613B7DE8E68016A"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 18:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUQs3-0001T6-Ki
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 18:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934123AbXCVROg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 13:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934136AbXCVROg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 13:14:36 -0400
Received: from main.gmane.org ([80.91.229.2]:37014 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934123AbXCVROf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 13:14:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HUQqw-0002Em-BT
	for git@vger.kernel.org; Thu, 22 Mar 2007 18:13:30 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 18:13:30 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 18:13:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42870>

This is a multi-part message in MIME format.
--------------3FC416367613B7DE8E68016A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> Yeehaa! I think I'm on the right trail.
> 
> Git people: do this:
> 
>         yum install ElectricFence
> 
> (or similar, apt-get, whatever), and then apply this patch, and do
> 
>         make test
> 
> and it will fail in "git-apply"! Which (having read Alexander's corruption
> sequence once more) must have been what corrupted things for Alexander
> too!

Here is a repo, created with the MinGW port. It has a corrupted object,
that you can see even on Linux with just

$ git show :one

It was created with an obviously bogus "git apply" on Windows.
To restore the correct object, just do this on Linux:

$ git read-tree --reset -u HEAD
$ git apply --index patch.file

Now "git show :one" gives you the correct one.

HTH,
-- Hannes
--------------3FC416367613B7DE8E68016A
Content-Type: application/x-compressed;
 name="trash.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="trash.tgz"

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
AAAAAAAAAAAAPo34P60J89MAGAEA
--------------3FC416367613B7DE8E68016A--
