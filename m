From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: Preemptive EOF when pushing (using Msys git and PuTTY)
Date: Wed, 13 May 2009 13:45:43 +0200
Message-ID: <4A0AB2E7.8080707@isy.liu.se>
References: <4A0A8529.9010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luben Manolov <luben.manolov@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 14:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4D9q-00012D-51
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbZEMMBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 08:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755908AbZEMMBt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:01:49 -0400
Received: from mailgw1.uni-kl.de ([131.246.120.220]:44564 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbZEMMBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 08:01:47 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2009 08:01:47 EDT
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.13.8/8.13.8/Debian-3) with ESMTP id n4DBjgNu023384;
	Wed, 13 May 2009 13:45:42 +0200
Received: from serv-4100.kl.dfki.de (serv-4100.kl.dfki.de [192.168.41.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id n4DBjgPM021602;
	Wed, 13 May 2009 13:45:42 +0200 (CEST)
Received: from [192.168.21.153] (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-4100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id n4DBjf9j028733;
	Wed, 13 May 2009 13:45:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A0A8529.9010009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119039>

Luben Manolov wrote:
> Hi Gustaf,
> 
> I had exactly the same problem, which you have described below. We are 
> using MsysGit 1.6.3 and plink on Windows. The solution in our case was 
> to start using OpenSSH (the version from msysgit) instead of PuTTY/plink.

Thanks Luben!  I will test that solution the next time the problem 
arises.  Hopefully it solves the problem for people.

/Gustaf

> 
> Best regards,
> 
> Luben
> 
>> Hello everyone, and thanks for all your dedicated work with git.
>>
>> I have used git for quite some time now, mainly on different Linux
>> platforms, without any problems.  Recently we convert the office's pet
>> project from svn to git.  Many people at the office use Windows (Msys
>> git 1.6.2 and plink), and I have stared to see (only from Windows
>> people) problems when pushing similar to the following:
>>
>> Counting objects: 422, done.
>> Compressing objects: 422, done.
>> Writing objects: 100% (379/379), 77.77 KiB, done.
>> Total 379 (delta 310), reused 371 (delta 303)
>> fatal: early EOF
>> error: unpack failed: index-pack abnormal exit
>> To jkoehler <at> serv-4100:/git/argos.git
>>  ![remote rejected] jk/ellipseFit -> jk/ellipseFit (n/a (unpacker error))
>> error: failed to push some refs to
>> 'jkoehler <at> serv-4100:/git/argos.git'
>>
>> There seems to be no problem with the repo, neither local nor remote,
>> but for a specific setup the problem is reproducible on several Windows
>> machines, but if I move the whole local repo to a Linux machine instead
>> the problem is gone.
>>
>> I suspect the problem is that a ^Z EOF gets embedded in the pack to be
>> transported, and that somehow interacts poorly with PuTTY, but that is
>> just my guessing.  And if so I don't know how to handle it.
>>
>> Has anyone experienced anything similar?  If so, is there any simple fix
>> to the problem?  How would I go about to try to debug this?
>> Unfortunately, this seems to happen on a regular basis and affects the
>> git experience in a negative way, so I would be really happy to be able
>> to resolve the problem.
>>
>> I'm thankful for any help that I can get.
> 
