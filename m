From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 08/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Fri, 29 Oct 2010 01:40:17 +0200
Message-ID: <vpqocad7uou.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-9-git-send-email-Matthieu.Moy@imag.fr>
	<20101028194252.GF14212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:44:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBc8R-0003l5-J8
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0J1Xnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 19:43:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:60846 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756171Ab0J1Xnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 19:43:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9SNeHxC022872
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 29 Oct 2010 01:40:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBc4v-0006QG-E8; Fri, 29 Oct 2010 01:40:17 +0200
In-Reply-To: <20101028194252.GF14212@burratino> (Jonathan Nieder's message of "Thu\, 28 Oct 2010 14\:42\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 29 Oct 2010 01:40:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160252>

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  $ git branch -r
>>    origin/HEAD
>>    origin/html
>>    origin/maint
>>    origin/man
>>    origin/master
>>    origin/next
>>    origin/pu
>>    origin/todo
>>  ------------------------------------------------
>>
>> +In this case, "origin" is called a remote repository, or "remote" for
>> +short.
>
> "In this case" seems redundant (since we did not explain what other
> case it is being opposed to).

The wording was unfortunate, but what I meant was to explain the
example right above while defining the vocabulary.

I've changed it to "In this example".

>  The repository of origin is called a remote repository, or a "remote" for
>  short.
>
> would improve it?

It removes the link between the explanation and the example right
above. I prefer the quotes around "origin" to really show that it's
the string that appear in `git branch -r`.

>>         The branches of this repository are called "remote branches"
>> +from our point of view. The remote-tracking branches are created in
>> +the local repository at clone time, as a copy of the remote branches.
>
> Sentence structure.  Maybe
>
>           The branches of this repository are called "remote branches"
>   from our point of view. The remote-tracking branches listed above
>   were created based on the remote branches at clone time and will be
>   updated by "git fetch" and "git push".
>   See <<Updating -a-repository-With-git-fetch>> for details.

I've taken this (I like the "listed above" in particular), except I'm
keeping the (hence "git pull"), since "git pull" is probably more
likely to be used than "git fetch" by beginners.

>> +This command will fetch the changes from the remote branches to your
>> +remote-tracking branches `origin/*`, and merge default branch in the
>> +current branch.
>> +
>
> Article use.  Probably something like
>
> 	s/the changes/changes/
> 	s/merge default branch in/merge the default branch into/
>
> would do.

Taken, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
