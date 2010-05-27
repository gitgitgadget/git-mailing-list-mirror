From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:07:05 +0100
Message-ID: <4BFE8A99.5060906@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> 	<4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 27 17:07:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHefz-0007ze-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab0E0PHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:07:08 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:53423 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab0E0PHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:07:07 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 88F72DEC4B
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:07:06 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id 2yyRtH8AqJyU for <git@vger.kernel.org>;
	Thu, 27 May 2010 16:07:06 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 55E10DEC3D
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:07:06 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147869>

Dear All

Thanks for your comments.

On Thu, May 27, 2010 at 4:37 PM, Ivan Uemlianin<ivan@llaisdy.com>  wrote:

> >  git-pull is 755, and I can run /path/to/git-pull (I get an error and it
> >  crashes, but I have the permission).
>    

On 27/05/2010 15:47, Sverre Rabbelier wrote:
> ...
> That's not supposed to happen, what does it say? Also, is it possible
> you have an old git install lying around? It might be that it's partly
> using the old, and partly using the new install.
>    

On 27/05/2010 15:50, Ramkumar Ramachandra wrote:
> ...
> Your error comes from run-command.c:290 - Maybe it tries to execute
> git-pull and (wrongly) reports that it wasn't able to execute it? What
> error (and return status) do you get when you execute the script
> yourself?
> It looks like there's something wrong with your installation of Git.
> Perhaps you'd like to re-install
>    
The error is like this:

     $ /opt/libexec/git-core/git-pull
     /opt/libexec/git-core/git-pull: line 11: git-sh-setup: No such file 
or directory

I'm calling git-pull from my clone of the repos, so I don't have 
git-sh-setup in my current directory.  That all seems fine: I imagine 
git-pull is not intended to be called directly.

The git is a recent install from source, on a Centos machine.  There was 
no git previous.

As for reinstalling: unless something else is broken, I'm happy with 
"git fetch; git merge origin".  However, I should like to understand why 
git pull is not working.

Best wishes

Ivan




-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
