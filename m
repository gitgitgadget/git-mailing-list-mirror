From: Nicolas Bock <nbock@lanl.gov>
Subject: Re: error: cannot lock ref 'refs/remotes/origin/*'
Date: Mon, 16 Jun 2008 19:47:25 -0600
Message-ID: <1213667245.14393.3.camel@localhost>
References: <1213635227.17814.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 03:58:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8QSp-0006L4-Fs
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 03:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYFQB5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 21:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYFQB5c
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 21:57:32 -0400
Received: from proofpoint3.lanl.gov ([204.121.3.28]:38855 "EHLO
	proofpoint3.lanl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYFQB5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 21:57:31 -0400
Received: from mailrelay2.lanl.gov (mailrelay2.lanl.gov [128.165.4.103])
	by proofpoint3.lanl.gov (8.13.8/8.13.8) with ESMTP id m5H1ljnU002937
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 19:47:45 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id 0C00E1A8C4B0
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 19:47:45 -0600 (MDT)
X-CTN-5-Virus-Scanner: amavisd-new at mailrelay2.lanl.gov
Received: from [128.165.249.1] (dsl-usr-1.lanl.gov [128.165.249.1])
	by mailrelay2.lanl.gov (Postfix) with ESMTP id 6F1E91A8C49B
	for <git@vger.kernel.org>; Mon, 16 Jun 2008 19:47:38 -0600 (MDT)
In-Reply-To: <1213635227.17814.6.camel@localhost>
X-Mailer: Evolution 2.12.3 
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7161:2.4.4,1.2.40,4.0.164 definitions=2008-06-17_01:2008-06-16,2008-06-17,2008-06-16 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85257>

I realized that I recently upgraded from version 1.5.3.7 to 1.5.4.5. I
double checked and downgraded again, and yes, I don't have any problems
running "git gc" with the older version, but I get the below error
message with the newer version of git.

nick


On Mon, 2008-06-16 at 10:53 -0600, Nicolas Bock wrote:
> Hello list,
> 
> when running "git gc" I get the following error message as of late:
> 
> $ git gc
> error: cannot lock ref 'refs/remotes/origin/*'
> error: failed to run reflog
> 
> When I rsync the directory tree to another machine, I can run "git gc"
> without any error messages. What exactly does this error mean? Why would
> locking fail?
> 
> Thanks already,
> 
> nick
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
