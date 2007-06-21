From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Re: Suggestions for documentation
Date: Thu, 21 Jun 2007 13:24:17 +0200
Message-ID: <467A5FE1.1010401@gmail.com>
References: <467786B1.5000009@gmail.com> <20070620180615.529dff2a@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Thu Jun 21 13:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Kux-0005Me-4h
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 13:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbXFULdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 07:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbXFULdA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 07:33:00 -0400
Received: from ms01.sssup.it ([193.205.80.99]:34966 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754177AbXFULc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 07:32:59 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 31357761; Thu, 21 Jun 2007 13:24:55 +0200
Received: from [10.30.3.110] ([10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l5LAUAqi012598;
	Thu, 21 Jun 2007 12:30:10 +0200
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070620180615.529dff2a@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50613>

Hi,

    actually I didn't understand the difference between "git clone --bare" and
"git --bare fetch" either... (maybe is not clear in the documentation ?)

For instance, what should be used when setting up a public not-working repository ?

I mean, we can use both

git --bare init
git --bare fetch ... master:master

and

git clone --bare  ...

Thank you in advance.

Regards,

             Claudio



Luiz Fernando N. Capitulino wrote:
> Em Tue, 19 Jun 2007 09:33:05 +0200
> Claudio Scordino <cloud.of.andor@gmail.com> escreveu:
> 
> | Hi,
> | 
> |     I just want to suggest to put some missing information in the git manpages.
> | 
> | 1) As my previous question shown, how to clone from a specified port is not 
> | currently documented. You should just add a sentence saying that the command is
> | 
> | git clone git://server:port/path/
> | 
> | 2) Maybe it is better to highlight that after a push on a remote repository, the 
> | user has to do a checkout on that repository (people from the CVS and SVN worlds 
> | get easily confused, otherwise).
> | 
> | Moreover (and I did not fully understood why) if I just use "git checkout" 
> | without the -f option, I cannot see the changes that have been pushed from the 
> | cloned repository.
> 
>  git-rebase documentation needs some change too. We should add some high level
> description in one paragraph at the top of the file.
> 
>  I answer the very same question ('why should I want to use git-rebase?')
> three times per week.
> 
>  I'll submit a patch shortly.
> 
