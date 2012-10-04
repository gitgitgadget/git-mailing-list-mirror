From: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Thu, 04 Oct 2012 10:59:36 +0200
Message-ID: <k4jj5n$72b$1@ger.gmane.org>
References: <k4hj91$4tt$4@ger.gmane.org> <CABURp0qVWg2PvD4PcjJ9q45x9WxJCuJEQL8Rze=qerWXg72Txw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 03:31:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJwkX-0001e5-CW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 03:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab2JEBaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 21:30:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:41319 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab2JEBae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 21:30:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TJwit-0000hg-3E
	for git@vger.kernel.org; Fri, 05 Oct 2012 03:29:03 +0200
Received: from 99.1-241-81.adsl-dyn.isp.belgacom.be ([81.241.1.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 03:29:03 +0200
Received: from ge0ffrey.spam by 99.1-241-81.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 03:29:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 99.1-241-81.adsl-dyn.isp.belgacom.be
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CABURp0qVWg2PvD4PcjJ9q45x9WxJCuJEQL8Rze=qerWXg72Txw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207062>


Op 03-10-12 18:40, Phil Hord schreef:
> But I feel your pain.  I think the solution lies in relegating 'reset'
> to the plumbing or the power-user realm of commands since I feel it is
> quite overloaded and sometimes dangerous.  There was a thread some
> months back heading in this direction, but I failed to keep it going.
>
>      http://comments.gmane.org/gmane.comp.version-control.git/185825

I personally use git reset a lot:
- Try an experiment
- Commit a few commits as the experiment progresses
- figure out that the experiment is a dead end
- git reset all those _local_ commits

The point is: they are local commits, so no harm done.
But there's nothing preventing me from resetting pushed commits too, 
which would mean harm.
