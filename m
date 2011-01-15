From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: multiple group access to update repo
Date: Fri, 14 Jan 2011 22:53:28 -0600
Message-ID: <igr99g$mca$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 15 05:54:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdy9v-0002ca-Mi
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 05:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab1AOEyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 23:54:22 -0500
Received: from lo.gmane.org ([80.91.229.12]:49291 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483Ab1AOEyV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 23:54:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pdy9b-0002U8-6r
	for git@vger.kernel.org; Sat, 15 Jan 2011 05:54:19 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 05:54:19 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 05:54:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165133>

How do I allow users from different linux group to cd to a common bare 
mirror repo and also to a common non-bare cloned repo and perform 
git-fetch and git pull --ff-only?  Currently, the non-owner group gets 
this error:

error: cannot open FETCH_HEAD: Permission denied


v/r,
Neal
