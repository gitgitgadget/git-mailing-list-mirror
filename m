From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 8 Aug 2013 17:51:15 +0000 (UTC)
Message-ID: <ku0lqj$qvs$1@ger.gmane.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com> <vpqfvukdy39.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 19:51:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7UNC-0000Ub-4J
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966003Ab3HHRvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:51:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:42654 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965829Ab3HHRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:51:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V7UN6-0000OO-4E
	for git@vger.kernel.org; Thu, 08 Aug 2013 19:51:36 +0200
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 19:51:36 +0200
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 19:51:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Thu, 08 Aug 2013 19:48:10 +0200 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231911>

Matthieu Moy  wrote in message <vpqfvukdy39.fsf@anie.imag.fr>:
>> that confuses users.
> 
> ... but I do agree that the doc is really confusing. It would be much
> better if the doc could be reduced to:
> 
> "This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
> Please refer to the documentation of that command."

If I may chime in as a user: what really confused me about git whatchanged
is this part of man gitcore-tutorial:

       To see the whole history of our pitiful little git-tutorial project,
       you can do

           $ git log


       which shows just the log messages, or if we want to see the log
       together with the associated patches use the more complex (and much
       more powerful)

           $ git whatchanged -p


       and you will see exactly what has changed in the repository over its
       short history.

I had to go look at the source code to realize that nowadays git log and
git whatchanged are basically the same functions with different defaults. A
pointer to that in the man page of git whatchanged would definitively be
helpful.
