From: Andreas Ericsson <exon@op5.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 12:10:04 +0200
Message-ID: <49D33D7C.1080200@op5.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D32CE5.21780.391D18@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Wed\, 01 Apr 2009 08\:59\:16 +0200"), <vpq63horepl.fsf@bauges.imag.fr> <49D35254.4137.CB56FE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 12:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoxQH-0005cJ-IT
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 12:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbZDAKKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 06:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZDAKKM
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 06:10:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:39562 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZDAKKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 06:10:11 -0400
Received: by fg-out-1718.google.com with SMTP id e12so156494fga.17
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 03:10:07 -0700 (PDT)
Received: by 10.86.1.1 with SMTP id 1mr5970302fga.0.1238580607561;
        Wed, 01 Apr 2009 03:10:07 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id d6sm1421225fga.2.2009.04.01.03.10.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 03:10:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <49D35254.4137.CB56FE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115364>

Ulrich Windl wrote:
> On 1 Apr 2009 at 9:54, Matthieu Moy wrote:
> 
>> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
>>
>>>> Not to mention that you can have multiple roots (multiple commits with
>>>> no parent) in git repository; besides independent branches (like
>>>> 'man', 'html' or 'todo') it is usually result of absorbing or
>>>> subtree-merging other projects.  In 'master' branch there are 5 roots
>>>> or more: joined 'git-tools' (mailinfo / mailsplit), absorbed gitweb,
>>>> and subtree-merged gitk and git-gui.  And here you would again have
>>>> multiple commits with the same number...
>>> Which would not harm, because it would be version N from committer X. Any if 
>>> committer X merges from anything else, the next number would be > N. I did not 
>>> claim that my method makes a total ordering of commits and merges possible.
>> Neither does it make the numbers unique for committer X.
>>
>> If commiter X commits a successor to commit N, it's labeled N+1. If
>> later, he creates another branch from commit N, and commit, the new,
>> other commit will be labeled N+1.
> 
> Correct: They live in a parallel universe. But on the long term they will either 
> vanish or be merged in which case the number will be "> N+1" (on the main branch). 
> So we have a branch plus a sequence number all the time.
> 
>> This means even within a repository, you cannot say things like
>> "commit number N", so, OK, you have numerical IDs, but you can't use
>> them.
> 
> I never wanted to have such a thing (using those numbers for commit).
> 

If you weren't going to use them for commits, what use are they at all?

I think you need to show us at least one use-case where this would
be beneficial *at all* before anyone is going to take this suggestion
seriously (this time around; It's been dropped on the floor numerous
times before when those original posters came to their senses).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
