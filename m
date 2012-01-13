From: Rahul Jain <rahuljain81@gmail.com>
Subject: Re: problem with updating a shallow clone via a branch fetch
Date: Fri, 13 Jan 2012 04:09:59 +0000 (UTC)
Message-ID: <loom.20120113T050744-134@post.gmane.org>
References: <AANLkTinx01bzzLKk=DfyEvfSz8Hun-YqzJfEDpX7gNSS@mail.gmail.com> <7vtyfng00i.fsf@alter.siamese.dyndns.org> <AANLkTimSRG+UkD1vJszUf+3j0nV+_pPWSE3N2Dy9SfTa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:15:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlYXr-0006Jw-C7
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 05:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356Ab2AMEPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 23:15:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:60656 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756919Ab2AMEPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 23:15:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RlYXj-0006FB-AN
	for git@vger.kernel.org; Fri, 13 Jan 2012 05:15:07 +0100
Received: from 203.92.57.135 ([203.92.57.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 05:15:07 +0100
Received: from rahuljain81 by 203.92.57.135 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 05:15:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.92.57.135 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188494>

I was also getting the same error. I went to .git/shallow file and deleted 
<hash>. After that everything was working fine.
