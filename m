From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git to p4 conversion
Date: Fri, 4 Feb 2011 00:03:33 +0000 (UTC)
Message-ID: <loom.20110204T004658-497@post.gmane.org>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com> <4D4AF29E.7070509@vmware.com> <AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 01:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl9ih-0002es-72
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 01:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab1BDAkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 19:40:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:48286 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148Ab1BDAkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 19:40:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pl9iW-0002aC-Dw
	for git@vger.kernel.org; Fri, 04 Feb 2011 01:40:04 +0100
Received: from 111.216.54.77.rev.vodafone.pt ([77.54.216.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 01:40:04 +0100
Received: from vitor.hda by 111.216.54.77.rev.vodafone.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 01:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.54.216.111 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110109 Iceweasel/3.6.13 (like Firefox/3.6.13))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166013>

Hi Endre,

Endre Czirbesz <endre <at> czirbesz.hu> writes:

> 
> Hello Ian,
> 
> Thanks for your reply.
> 
> 2011/2/3 Ian Wienand <ianw <at> vmware.com>:
> > What exactly did you try?
> I am not at my work computer now, but as I remember:
> 
> cd workdir
> git-p4 clone //depot/projectdir/...@all .
> git clone myprojectrepo .

I think what you should do is add the git repository as a remote with something
like:

git remote add remotename myprojectrepo
git pull remotename master
git p4 submit

Hope this helps,
Vitor
