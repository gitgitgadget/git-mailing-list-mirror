From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: modifying commit's author
Date: Tue, 23 Jan 2007 08:38:12 +0100
Organization: eudaptics software gmbh
Message-ID: <45B5BB64.EC3AD29E@eudaptics.com>
References: <20070122203734.GB23187@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 23 08:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9GDy-0003hU-VU
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 08:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbXAWHhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 02:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932867AbXAWHhT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 02:37:19 -0500
Received: from main.gmane.org ([80.91.229.2]:35024 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbXAWHhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 02:37:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9GDQ-0001t6-6H
	for git@vger.kernel.org; Tue, 23 Jan 2007 08:37:12 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 08:37:12 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 08:37:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37486>

"J. Bruce Fields" wrote:
> 
> If I got the author wrong on a commit, is there a quick way to fix it
> (e.g. by passing the right arguments or environment variables to commit
> --amend)?

Use cogito: cg commit --amend -e
You can edit the author name+email in the commit message.

-- Hannes
