From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: git-svn: commit author x commit committer issue
Date: Thu, 09 Aug 2007 01:42:24 +1000
Message-ID: <46B9E460.5080708@gmail.com>
References: <46B9C92B.3000000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Richard MUSIL <richard.musil@st.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIux2-0002s6-Nr
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761552AbXHHX2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761523AbXHHX2Z
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:28:25 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:42310 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759431AbXHHX2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 19:28:24 -0400
X-Greylist: delayed 27951 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2007 19:28:24 EDT
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=kingbee.home)
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1IIng1-0006eD-Ib; Thu, 09 Aug 2007 01:42:25 +1000
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <46B9C92B.3000000@st.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55398>

Richard MUSIL wrote:
> Normally, when patch is applied, git distinguishes commit author and
> commit committer (relying on info from patch).
> However, after the patches are committed to svn repository using:
> git-svn dcommit
> author and committer data are set to same values (or at least time and
> date, I cannot verify it for names).
> I wonder if there is any reason for this behavior, because I would
> definitely like to keep original commit info (which came from patch) in
> my git repository.

I'm sure this worked before (author and committee are different, that is).
Something went wrong recently but I haven't got time to look into the problem.
I hope someone would.

Quy
