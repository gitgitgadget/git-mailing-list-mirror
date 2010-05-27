From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 15:37:27 +0100
Message-ID: <4BFE83A7.4020604@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 16:37:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeDP-00065l-0Y
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab0E0Ohb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 10:37:31 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:47177 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757310Ab0E0Oha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 10:37:30 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 5A97FDEC47;
	Thu, 27 May 2010 15:37:29 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id cQL1JKCH9e+k; Thu, 27 May 2010 15:37:29 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id AD64CDEC44;
	Thu, 27 May 2010 15:37:28 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147865>

Dear Ram

Thank you for your comment.

git-pull is 755, and I can run /path/to/git-pull (I get an error and it 
crashes, but I have the permission).

Ivan

On 27/05/2010 15:20, Ramkumar Ramachandra wrote:
> Hi,
>
>    
>>         $ git pull
>>         fatal: cannot exec 'git-pull': Permission denied
>>      
> git-pull is simply a shell script (see git-pull.sh in git.git) which
> executes `git fetch` and `git merge-base` among other things. Maybe
> your git-pull file doesn't have execute permissions?
>
> -- Ram
>    


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
