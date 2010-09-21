From: David Brown <davidb@codeaurora.org>
Subject: Enforcing clone/fetch to use references.
Date: Tue, 21 Sep 2010 13:44:56 -0700
Message-ID: <20100921204456.GA24357@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 22:45:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9i3-0001Z1-07
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab0IUUo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 16:44:58 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:9256 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab0IUUo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:44:57 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6113"; a="55249571"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 21 Sep 2010 13:44:57 -0700
Received: from huya.qualcomm.com (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id C849610004C8
	for <git@vger.kernel.org>; Tue, 21 Sep 2010 13:44:53 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156758>

[resending with corrected subject]

Suppose I want to publish some changes to a tree.  I have a server
available where I can run a git daemon, but for one reason or another
I want to force people to use the another git repo as a reference.
The reason could be one of bandwidth, or someone who isn't comfortable
making all of the other source available.  Ideally, someone who
already has the other git repo cloned, and just adds mine as a remote
wouldn't notice the difference.

Is there a way to do this?  I've tried various ways of using
alternates to keep the blobs out of the repository I want to export,
but the daemon just follows the alternates.  If I remove the
alternates, I then seem to have a broken repository.  Most things I
try, at least carry objects for all of the files in the HEAD tree,
which most of the time is a large portion of the data.

If there isn't a way of doing this currently, is this something that
others would find useful?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
