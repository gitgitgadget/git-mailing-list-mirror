From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:21:28 +0100
Message-ID: <4BFE8DF8.8050301@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> <4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com> <4BFE8A99.5060906@llaisdy.com> <20100527151514.GB18590@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 27 17:21:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeu1-00088n-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758118Ab0E0PVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:21:35 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:46285 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757998Ab0E0PVa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:21:30 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id CDF19DEC4D
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:21:28 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id WgXZ37T4husx for <git@vger.kernel.org>;
	Thu, 27 May 2010 16:21:28 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 936D6DEC40
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:21:28 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100527151514.GB18590@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147874>

Dear Peff

Thanks for your comment.
> What happens if you run "git pull"? If you get an error, can you try to
> run "GIT_TRACE=1 git pull"? Git should then print out exactly what it is
> trying to exec that is failing.

Not very exciting:

$ GIT_TRACE=1 git pull
trace: exec: 'git-pull'
trace: run_command: 'git-pull'
fatal: cannot exec 'git-pull': Permission denied

Best wishes

Ivan


On 27/05/2010 16:15, Jeff King wrote:
> On Thu, May 27, 2010 at 04:07:05PM +0100, Ivan Uemlianin wrote:
>
>    
>>> It looks like there's something wrong with your installation of Git.
>>> Perhaps you'd like to re-install
>>>        
>> The error is like this:
>>
>>      $ /opt/libexec/git-core/git-pull
>>      /opt/libexec/git-core/git-pull: line 11: git-sh-setup: No such
>> file or directory
>>
>> I'm calling git-pull from my clone of the repos, so I don't have
>> git-sh-setup in my current directory.  That all seems fine: I imagine
>> git-pull is not intended to be called directly.
>>      
> It's not. It expects the git wrapper to have set up the PATH to have
> /opt/libexec/git-core in it, which would then find git-sh-setup.
>
> What happens if you run "git pull"? If you get an error, can you try to
> run "GIT_TRACE=1 git pull"? Git should then print out exactly what it is
> trying to exec that is failing.
>
> -Peff
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
