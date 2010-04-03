From: Peter Collingbourne <peter@pcc.me.uk>
Subject: Re: [PATCH 01/12] Generate unique ID for submodules created using "git submodule add"
Date: Sat,  3 Apr 2010 21:04:38 +0100
Message-ID: <1270325080-22951-1-git-send-email-peter@pcc.me.uk>
References: <20100327094427.GA30216@progeny.tock>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 22:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny9aw-0005l1-BO
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 22:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0DCUFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 16:05:20 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:40541 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884Ab0DCUFS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 16:05:18 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Ny9an-0004i6-LB
	for git@vger.kernel.org; Sat, 03 Apr 2010 21:05:17 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Ny9al-0005zB-FW
	for git@vger.kernel.org; Sat, 03 Apr 2010 21:05:15 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <20100327094427.GA30216@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143898>

> The suggestion of _appending_ some nonsense to a submodule name sounds
> much more palatable to me than _replacing_ the submodule name with
> nonsense.  YMMV, of course.

Indeed.  But we should be careful about which components of the path
we include in the submodule name, in order to minimise confusion.
Here are a couple of suggested patches which could be squashed into
this patch; we may choose to apply one or both of them.

Thanks.
-- 
Peter
