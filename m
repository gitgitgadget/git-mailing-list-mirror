From: Joseph Parmelee <jparmele@wildbear.com>
Subject: Lack of detached signatures
Date: Tue, 27 Sep 2011 17:48:46 -0600 (CST)
Message-ID: <alpine.LNX.2.00.1109271742460.24832@bruno>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 01:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hVw-0007Ss-Jw
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 01:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1I0X4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 19:56:36 -0400
Received: from ip205-30-10-190.ct.co.cr ([190.10.30.205]:49932 "EHLO
	bruno.wildbear.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049Ab1I0X4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 19:56:35 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Sep 2011 19:56:35 EDT
Received: by bruno.wildbear.com (Postfix, from userid 503)
	id DC52A1BE0546; Tue, 27 Sep 2011 17:48:46 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by bruno.wildbear.com (Postfix) with ESMTP id BF8701BE0545
	for <git@vger.kernel.org>; Tue, 27 Sep 2011 17:48:46 -0600 (CST)
X-X-Sender: jparmele@bruno
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182277>

Hello all:

Under the present circumstances, and particularly considering the
sensitivity of the git code itself, I would suggest that you implement
signed detached digital signatures on all release tarballs.  Just a crypto
hash by itself, however strong, does not protect against man-in-the-middle
attacks.

Joseph
