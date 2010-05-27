From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:36:18 +0100
Message-ID: <4BFE9172.9080209@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> 	<4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com> 	<4BFE8A99.5060906@llaisdy.com> <AANLkTimDOOjbCRJMOlW8sTEtiHdI4AqjdOcdFug7MD94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 27 17:36:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHf8M-0000Sp-NS
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361Ab0E0Pg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:36:26 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:52654 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963Ab0E0PgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:36:25 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 36D4CDEC56
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:36:19 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id 1QIHqiZyi2Nq for <git@vger.kernel.org>;
	Thu, 27 May 2010 16:36:19 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 2599EDEC53
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:36:18 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTimDOOjbCRJMOlW8sTEtiHdI4AqjdOcdFug7MD94@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147879>

On 27/05/2010 16:15, Ramkumar Ramachandra wrote:
> Hi,
>
>    
>>     /opt/libexec/git-core/git-pull: line 11: git-sh-setup: No such file or
>> directory
>>      
> You seem to be missing git-sh-setup (called `git-sh-setup.sh` in
> git.git), another shell script that's called by every other shell
> script in Git.
>    
... but git-sh-setup is in /opt/libexec/git-core/ ...
>> As for reinstalling: unless something else is broken, I'm happy with "git
>> fetch; git merge origin".  However, I should like to understand why git pull
>> is not working.
>>      
> A lot of other things won't work. `git rebase -i` for example is
> another shell script `git-rebase--interactive.sh`.
>    
You're right!

Is there something I need to set in my global .gitconfig?

If it's a botched install I need to know why, or it will just be botched 
the same way when I reinstall.  I only remember two things about the 
install, ...

- I did configure with prefix=/opt
- odd thing: nothing was installed into /opt: it all went into /root (I 
might have been root for the whole process, which I know is bad).  I 
just cp'd everything over to /opt, and everything worked OK (until now).

Any ideas?  I'm happy to reinstall once I know what went wrong.  The git 
I installed on my mac is really working fine.

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
