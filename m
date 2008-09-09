From: "Jing Xue" <jingxue@digizenstudio.com>
Subject: Re: git-p4 and keyword expansion
Date: Tue, 09 Sep 2008 13:38:48 -0400
Message-ID: <20080909133848.487451nasi1gnyww@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: "GIT SCM" <git@vger.kernel.org>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd7C1-0000HI-2j
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbYIIRiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbYIIRiw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:38:52 -0400
Received: from k2smtpout03-01.prod.mesa1.secureserver.net ([64.202.189.171]:47420
	"HELO k2smtpout03-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754454AbYIIRiv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 13:38:51 -0400
Received: (qmail 9848 invoked from network); 9 Sep 2008 17:38:50 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-01.prod.mesa1.secureserver.net (64.202.189.171) with ESMTP; 09 Sep 2008 17:38:50 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 4645910007A;
	Tue,  9 Sep 2008 17:38:49 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UX5suiBMUQe; Tue,  9 Sep 2008 13:38:48 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id AE23A100A22; Tue,  9 Sep 2008 13:38:48 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde Framework) with
	HTTP; Tue, 09 Sep 2008 13:38:48 -0400
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95411>

On Tue, Sep 09, 2008 at 04:44:11PM +0530, dhruva wrote:
> Hello,

Hi,

> I feel the configuration must be set the first time only, when you
> clone using 'git-p4 clone'. Altering it in between will be very
> confusing!
> Ideally, the setting must be transferred when the git repo
> (cloned from git-p4) is cloned using standard git. Is it something
> possible (well, I am new to git and am exploring. Any extra
> information would help).
>
> My proposal is as follows:
> 1. Add an extra command line argument to 'git-p4 clone' to either  
> enable/disable keyword expansion
> 2. Store that information under the .git folder in a file that is  
> copied when someone clones that repo
> 3. Use the stored information in future 'git-p4 sync/rebase'

Any way to make it optional would be welcome by me.

> I agree that keyword expansion is bad but there is no alternative
> when you work with a system that has keyword expansion and you
> need interoperability (p4<->git)

A patch would only fail if it has a hunk containing a line with
keyword expansion in it. So I for one am willing to _occasionally_
have to submit to perforce manually, for the benefits of no keyword
expansion - among other things, the ability to diff between
branches without the interferences is very important for me.

But that's just my 2 cents, and I'm just another git(-p4) user.
If you do come up with a "formal" patch, you might want to
explicitly add Simon Hausmann to the To list, for he's the git-p4
author.

Cheers.
-- 
Jing

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
