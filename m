From: "Eivind LM" <eivliste@online.no>
Subject: Re: Split a subversion repo into several git repos
Date: Fri, 12 Oct 2007 16:15:42 +0200
Message-ID: <op.tz28kglcjwclfx@ichi>
References: <op.tz09zaizjwclfx@ichi> <e2a1d0aa0710110624x2b50cfafo9bfdc176ba9063ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Patrick Doyle" <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgLJH-00048V-BU
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 16:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbXJLOQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 10:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbXJLOQE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 10:16:04 -0400
Received: from mail-forward.uio.no ([129.240.10.42]:55144 "EHLO
	mail-forward.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbXJLOQC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 10:16:02 -0400
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IgLJ2-0001OP-Ph; Fri, 12 Oct 2007 16:16:00 +0200
Received: from cma-eivindlm.uio.no ([129.240.223.140] helo=ichi)
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <eivliste@online.no>)
	id 1IgLJ2-0001xH-86; Fri, 12 Oct 2007 16:16:00 +0200
In-Reply-To: <e2a1d0aa0710110624x2b50cfafo9bfdc176ba9063ce@mail.gmail.com>
User-Agent: Opera Mail/9.23 (Linux)
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.3, required=12.0, autolearn=disabled, AWL=-0.269,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: AD10B0B7CA4BC4CCA4A25BC04C74CAD0440A13F4
X-UiO-SPAM-Test: remote_host: 129.240.223.140 spam_score: -52 maxlevel 200 minaction 2 bait 0 mail/h: 2 total 16 max/h 2 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60690>

Thanks,
I found svndumpfilter in the svn book, and gave it a try. Unfortunately it  
seems to be confused about files that have moved around in the repository,  
I was at least not able to make it dump the entire history for a directory  
that over time has changed name, and that contains files that have moved  
in from other directories.

Eivind

On Thu, 11 Oct 2007 15:24:59 +0200, Patrick Doyle <wpdster@gmail.com>  
wrote:

> If you look through the Subversion FAQ or the book (I forget where
> I've seen it -- but I know I've seen it), you can export/filter out a
> tree from a subversion repository and load it into a new repository.
> Then you can import from that new repository.
>
> This presumes you have direct access to the subversion repository and
> can run commands like svnadmin --dump.
>
> --wpd
>
>
> On 10/11/07, Eivind LM <eivliste@online.no> wrote:
>> Hi,
>> I would like to convert a subversion repository to Git. The subversion
>> repository used to track development of several projects (only slightly
>> related), and I would like to divide the repository into several smaller
>> git repositories.
>>
>> For example, I want to convert one subversion repository which contains
>> the folders:
>> trunk/projectA
>> trunk/projectB
>>
>> into two git repositories:
>> projectA.git
>> projectB.git
>>
>> As far as I have understood, the way to do this is to
>> 1) Convert the entire subversion repository to git with git-svn.
>> 2) Make two copies of the whole new git-repository (projectA.git and
>> projectB.git).
>> 3) Use git-rm to remove projectB from projectA.git, and projectA from
>> projectB.git.
>>
>> This works fine, but both git-repositories now carries the history for
>> both projects. If possible, I would like to "clean" the history in the
>> repositories, so that I don't see history information for projectA when  
>> I
>> am browsing logs in projectB.git. Has anyone been in the same situation?
>> Do you have suggestions on how it can be solved?
>>
>> Any help will be greatly appreciated.
>>
>> Thanks,
>> Eivind
>> -
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
