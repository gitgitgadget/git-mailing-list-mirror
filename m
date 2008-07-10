From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: git over rsync+ssh
Date: Thu, 10 Jul 2008 12:09:14 +0200
Message-ID: <g54n4a$kek$2@ger.gmane.org>
References: <g52gbg$si9$1@ger.gmane.org> <32541b130807090902q2cdc9fcbg6f685dcb96407644@mail.gmail.com> <20080709171721.GA3679@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 12:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGt79-0004MJ-6w
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 12:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbYGJKKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 06:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbYGJKKF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 06:10:05 -0400
Received: from main.gmane.org ([80.91.229.2]:47579 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbYGJKKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 06:10:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KGt6A-0005p0-BY
	for git@vger.kernel.org; Thu, 10 Jul 2008 10:10:02 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 10:10:02 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 10:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080709171721.GA3679@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87966>

Teemu Likonen venit, vidit, dixit 09.07.2008 19:17:
> Avery Pennarun wrote (2008-07-09 12:02 -0400):
> 
>> I don't know if this will help in your case, but if it will be only
>> you pushing to this repository, one option is to simply create a bare
>> push repository on your local machine, and then manually just
>> rsync+ssh it to the remote machine from the command line as
>> a so-called "push" operation.
> 
> Again, I don't know if this is helpful for Michael, but this "manual"
> rsyncing can be done automatically via hooks/post-receive. Just like
> Avery said, "git push" to a bare repository in a local machine and this
> bare repo has post-receive hook which does "git update-server-info" and
> the rsyncing (or "sitecopy --update" or similar).

Thanks for your hints. Your posts combined made me understand the trick, 
using the "auxiliary" local repo for the hooks triggering the rsync. 
I'll hopefully remember it when I need it; in this case, a second repo 
would not have been very convenient, but I managed to get git running on 
the server side meanwhile.

Michael
