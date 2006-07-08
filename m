From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [RFC] just an (stupid) idea when creating a new branch
Date: Sat, 8 Jul 2006 15:55:47 +0000 (GMT)
Message-ID: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 08 17:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzF9s-0001gU-1x
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 17:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWGHPzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 11:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWGHPzt
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 11:55:49 -0400
Received: from web25814.mail.ukl.yahoo.com ([217.146.176.247]:45208 "HELO
	web25814.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964877AbWGHPzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 11:55:49 -0400
Received: (qmail 73056 invoked by uid 60001); 8 Jul 2006 15:55:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=ApmVNwuhXnLR4iHzDr+1HYlsjbh62n+05akLYf71qh1x2HmcHZCrD9ra7a9OguDvI9u2gD4IODAxXOtsTIK0vpSGvb9Me9kJo3PEkkBd21TfaOmJLQjkFXIL3B3DHvyxKdlRHYNibxx0BUVNfdqrlADoS4+SU/3iFkEuN2jADhc=  ;
Received: from [82.235.205.153] by web25814.mail.ukl.yahoo.com via HTTP; Sat, 08 Jul 2006 15:55:47 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23489>

Hi GIT folks.

I'm a complete newbie on git development so excuse me if
this idea is completely stupid.

Would it be possible to let the user stick a short explanation
on  what a branch is supposed to implement during its creation.

That is

$ git branch --topic "Implement a killer feature \
> This set of patches add the foo feature to GIT" mybranch master

Then it would be possible with another command to consult this topic
after a while. And even more useful, when generating the patch set
with the following git command

$ git-format-patch -n HEAD master

it uses the topic branch to generate as first patch a summary
of the patch serie. That is

"""
Subject: [PATCH 0/n] Implement a killer feature

This This set of patches add the foo feature to GIT.
"""

Is it useless ?

Thanks

Francis
