From: streamlake@tiscali.it
Subject: Re: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 20:37:48 +0100
Message-ID: <47E40E8C.9040805@tiscali.it>
References: <47E3DD28.4030302@tiscali.it> <37fcd2780803211157n15cec620gb5ab1d3e57ccd37b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 20:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcn9Z-00080l-Mo
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 20:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbYCUTnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 15:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYCUTnG
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 15:43:06 -0400
Received: from jack.mail.tiscali.it ([213.205.33.53]:43358 "EHLO
	jack.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbYCUTnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 15:43:04 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Mar 2008 15:43:04 EDT
Received: from [192.168.1.11] (84.222.23.64) by jack.mail.tiscali.it (7.3.135)
        id 47DE997C00377206 for git@vger.kernel.org; Fri, 21 Mar 2008 20:37:49 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <37fcd2780803211157n15cec620gb5ab1d3e57ccd37b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77761>

Dmitry Potapov ha scritto:
>
>
> I wonder do you really need to have two files on different branches whose
> name only differ by case, especially when you work on case insensitive
> filesystem? I suspect the answer is no. In this case, you can choose one
> policy for file naming and stick to it. For instance, that all names should
> be in low case except Makefile, or something like that. This policy can be
> enforced using pre-commit hook.
>
> Dmitry
>
>   

You're right, in fact it usually happens as the result of a mistake in 
naming a file between two branches or deleting a file and creating 
another one months later with the same name, not really a question of 
policies... :-)

@Linus
As always, I'm absolutely not a windz fan (and this is demonstrated by 
the fact that I've been using cygwin for long time instead of the crappy 
win command prompt, and use linux every day for a few non-strictly-windz 
projects), but I 'must' use it if I want to work, there's no choice 
where I come from, and I can't change the market by myself, even if I 
strongly support linux as a substitute...
So, given the fact that git is almost 'officially' supported at least 
under cygwin, I think it would be a good idea, if technically possible, 
to have a look at this kind of features. Not to mention the fact that 
having a broader audience for a project like git can be positive...

Thanks for your help,
Frank
