From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: "git branch" to list whether it's tracking remote branch?
Date: Tue, 14 Jun 2011 15:57:22 +0200
Message-ID: <4DF768C2.2050001@dirk.my1.cc>
References: <934599.4947.qm@web121018.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Timrod <jtimrod@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 15:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWU7d-0005yl-Ou
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 15:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1FNN51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 09:57:27 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:41311 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1FNN50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 09:57:26 -0400
Received: from [84.176.57.13] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1QWU7O-0007pt-C0; Tue, 14 Jun 2011 15:57:22 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <934599.4947.qm@web121018.mail.ne1.yahoo.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175770>

Hi Jason,

Am 14.06.2011 12:23 schrieb Jason Timrod:
> Hi,
> 
> please cc me as i am not subscribed to this list.
> 
> is there a command in git that will tell me if a given topic branch in a repository is setup to track a remote branch?
> 
> i think it would be useful so i can see which branches are pointing where when i try and then do a "git push"
> 
> TIA!
> 
> Jason

you could do "git branch -avv" (especially -vv for "very verbose" :-))

---------
  docs   57dddc4 Docs: Reformatted ...
* foo    96afa77 [pub/foo] Ticket 1234 ...
---------

In the second line you can see that local branch "foo" follows "foo" in
the remote "pub".

Or simply "cat .git/config" and check the "branches" sections:

---------
[branch "foo"]
        remote = pub
        merge = refs/heads/foo
---------


HTH,
Dirk
