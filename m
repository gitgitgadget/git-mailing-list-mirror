From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Sat, 10 Apr 2010 12:05:54 +0400
Message-ID: <hppbhu$bc7$1@dough.gmane.org>
References: <loom.20100406T161552-321@post.gmane.org>	<alpine.LFD.2.00.1004061709360.7232@xanadu.home>	<4BBC1ED3.6020008@gmail.com>	<alpine.LFD.2.00.1004070842580.7232@xanadu.home>	<4BBECE44.4040608@gmail.com> <vpqr5mp6o1q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 10:06:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ViC-0001O6-Ul
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 10:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108Ab0DJIGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 04:06:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:35244 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab0DJIGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 04:06:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O0Vi2-0001Jz-4w
	for git@vger.kernel.org; Sat, 10 Apr 2010 10:06:30 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 10:06:30 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 10:06:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <vpqr5mp6o1q.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144533>

On 04/09/2010 12:13 PM, Matthieu Moy wrote:
> Vitaly Berov<vitaly.berov@gmail.com>  writes:
>
>> Objects amount: 3997548.
>> Size of the repository: ~57Gb.
> [...]
>> By the way, we have a large amount of binary files in our rep.
>
> This is clearly not the kind of repositories Git is good at.
Hmm.. I'm looking for a good repository because I'm tired of subversion, 
Perforce isn't an option to (very expensive and even more 
uncomfortable). It seems like there only Git/Mercurial are good options. 
Can you recommend some other scms?

> I encourage you to continue this discussion, and try to find a way to
> get it working, but the standard approach (probably a "my 2 cents"
> kind of advices, but ...) would be:
>
> * Split your repo into smaller ones (submodules ...)
>
> * Avoid versionning binary files

I can't get rid of binary files because they are the "sources" of our 
artists work (the develop a game).
Splitting a repo can be an option, but it's very inconvenient for us.

Vitaly
