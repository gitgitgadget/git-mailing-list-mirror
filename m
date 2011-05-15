From: Martin L Resnick <mresnick@bbn.com>
Subject: ACLs for GIT
Date: Sun, 15 May 2011 15:24:38 -0400
Message-ID: <4DD02876.1040404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 22:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhYi-0008HB-9h
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab1EOUEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:04:55 -0400
Received: from smtp.bbn.com ([128.33.1.81]:58111 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab1EOUEy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:04:54 -0400
X-Greylist: delayed 2414 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 May 2011 16:04:54 EDT
Received: from [128.89.254.240] (port=39984)
	by smtp.bbn.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.74 (FreeBSD))
	(envelope-from <mresnick@bbn.com>)
	id 1QLgvf-000LMc-HN
	for git@vger.kernel.org; Sun, 15 May 2011 15:24:39 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173656>

Is anyone working on adding access control to GIT ?

I'm looking for the Subversion equivalent of mod_authz_svn.
I need to restrict read access of ITAR documents that are
scattered throughout the source tree.
This restriction would need to deny fetch of the ITAR
documents yet allow fetch of any other files.

Looking through the source code it would seem that
putting a hook call in the fetch-pack code would do it.

Thanks
