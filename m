From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 07:29:32 +0100
Message-ID: <0AF54F9D-9B5C-41F5-A65C-B8BB50DC0D80@zib.de>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <BAYC1-PASMTP0989BAD99482FD877540CBAE2F0@CEZ.ICE>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sean <seanlkml@sympatico.ca>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNMjZ-0007AD-9e
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 07:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbYBHG2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 01:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYBHG2k
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 01:28:40 -0500
Received: from mailer.zib.de ([130.73.108.11]:40518 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbYBHG2j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 01:28:39 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m186SZv3012109;
	Fri, 8 Feb 2008 07:28:35 +0100 (CET)
Received: from [192.168.178.21] (brln-4db96af6.pool.einsundeins.de [77.185.106.246])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m186SYib011428
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 8 Feb 2008 07:28:35 +0100 (MET)
In-Reply-To: <BAYC1-PASMTP0989BAD99482FD877540CBAE2F0@CEZ.ICE>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73043>


On Feb 8, 2008, at 6:38 AM, Sean wrote:

> On Fri, 8 Feb 2008 17:44:12 +1300
> "Martin Langhoff" <martin.langhoff@gmail.com> wrote:
>
>> This means that beyond the branches I actively work on, I also have
>> local tracking branches for remote heads that I am not updating. When
>> I say git push, these stale local tracking branches are making a lot
>> of noise in the output:
>
> There may be other workflows where the noise in the output is  
> appropriate.
> What about using "git push origin HEAD" (or an alias for it) to  
> push only
> the branch you have checked out and avoid noise for other branches?


This is what I often do and I also tell my users from
the very beginning to *avoid* a naked "git push".
Instead, they always should say exactly what they mean,
like "git push origin topic", and they can use
"git push origin HEAD" as a short-hand.  Besides, they
should also run with "--dry-run" first to verify what
they do.

We had lengthy discussions about the issue Martin describes.  My
personal conclusion was that people on the list tend to regard
the current behaviour of "git push" as a very stable feature.  So
you should come up with convincing arguments for changes and
you also should ensure that the current behaviour does not break.
I decided to focus on different things and leave "git push" as is.

Here are some pointers to the discussions:

http://marc.info/?l=git&m=119384331712996&w=2

http://marc.info/?l=git&m=119400354601328&w=2

http://thread.gmane.org/gmane.comp.version-control.git/65632/focus=65747

http://thread.gmane.org/gmane.comp.version-control.git/61955/focus=65493

	Steffen
