From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in non-trivial places
Date: Thu, 28 Oct 2010 23:50:03 +0200
Message-ID: <vpq4oc6f0ms.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-4-git-send-email-Matthieu.Moy@imag.fr>
	<20101028183919.GD14212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 23:53:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaPh-00049M-Ju
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 23:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758888Ab0J1Vxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 17:53:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:47731 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756714Ab0J1Vxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 17:53:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9SLo3Gh016936
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 23:50:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBaMF-0005Wc-Lc; Thu, 28 Oct 2010 23:50:03 +0200
In-Reply-To: <20101028183919.GD14212@burratino> (Jonathan Nieder's message of "Thu\, 28 Oct 2010 13\:39\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 28 Oct 2010 23:50:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160232>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> --- a/Documentation/everyday.txt
>> +++ b/Documentation/everyday.txt
>> @@ -180,12 +180,12 @@ directory; clone from it to start a repository on the satellite
>>  machine.
>>  <2> clone sets these configuration variables by default.
>>  It arranges `git pull` to fetch and store the branches of mothership
>> -machine to local `remotes/origin/*` tracking branches.
>> +machine to local `remotes/origin/*` remote-tracking branches.
>>  <3> arrange `git push` to push local `master` branch to
>>  `remotes/satellite/master` branch of the mothership machine.
>>  <4> push will stash our work away on `remotes/satellite/master`
>> -tracking branch on the mothership machine.  You could use this as
>> -a back-up method.
>> +remote-tracking branch on the mothership machine.  You could use this
>> +as a back-up method.
>>  <5> on mothership machine, merge the work done on the satellite
>>  machine into the master branch.
>
> Just for the record: I still don't think this hunk fits with the rest
> of the patch, and I think it just switches from one bad wording to
> another.
>
> This is the "Everyday git" document, one of the first pages a new user
> might read.  Using jargon that does not explain itself (whether it is
> "tracking branches" or "remote-tracking branches") is not really a
> good idea.
>
> Wouldn't it be possible to split this into a separate patch, so it
> does not hold back the other "add hyphen" changes?

I don't get the point. If you like neither "tracking branch" nor
"remote-tracking branch", then my patch doesn't make the situation
worse anyway, so it should not hold back anything. It doesn't prevent
better wording of this document later, but this is not the point of my
patch serie.

What I'm trying to do here is really to achieve consistancy. If
something has a name, let's use the same name everywhere. I'd be
really frustrated if some instances of any name other than
"remote-tracking branch" remain purposedly after my patch serie to
designate what we seem to agree should be called "remote-tracking
branch".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
