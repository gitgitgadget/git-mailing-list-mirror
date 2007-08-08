From: "Sparks, Sam" <SSparks@twacs.com>
Subject: RE: Git'ing a non-labeled set of sources
Date: Wed, 8 Aug 2007 15:59:38 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC170CE7@twx-exch01.twacs.local>
References: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local> <20070808193720.GD27470@xp.machine.xx> <CF7E46FCFF66AD478BB72724345289EC170CE5@twx-exch01.twacs.local> <20070808201718.GE27470@xp.machine.xx> <CF7E46FCFF66AD478BB72724345289EC170CE6@twx-exch01.twacs.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsdW-0004pK-VS
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762043AbXHHVAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761652AbXHHVAG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:00:06 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:52605 "EHLO
	outbound3-blu-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762008AbXHHVAD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 17:00:03 -0400
Received: from outbound3-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-blu-R.bigfish.com (Postfix) with ESMTP id 1C19DB11BCB
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 21:00:01 +0000 (UTC)
Received: from mail63-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound3-blu.bigfish.com (Postfix) with ESMTP id 105D11B8004F
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 21:00:01 +0000 (UTC)
Received: from mail63-blu (localhost.localdomain [127.0.0.1])
	by mail63-blu-R.bigfish.com (Postfix) with ESMTP id 5D073DB84B4
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 21:00:00 +0000 (UTC)
X-BigFish: VP
X-FB-SS: 0,
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 68.89.149.4;Service: EHS
Received: by mail63-blu (MessageSwitch) id 1186606798928081_13361; Wed,  8 Aug 2007 20:59:58 +0000 (UCT)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail63-blu.bigfish.com (Postfix) with ESMTP id 9A20A19F0078
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 20:59:58 +0000 (UTC)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC170CE6@twx-exch01.twacs.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git'ing a non-labeled set of sources
Thread-Index: AcfZ+RYzRSku8+MYSZym9uzHJ6DBMwAA6iqAAABlvNA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55364>

 

>-----Original Message-----
>From: Sparks, Sam 
>Sent: Wednesday, August 08, 2007 3:46 PM
>To: Peter Baumann
>Cc: git@vger.kernel.org
>Subject: RE: Git'ing a non-labeled set of sources
>
> 
>
>>-----Original Message-----
>>From: Peter Baumann [mailto:waste.manager@gmx.de] 
>>Sent: Wednesday, August 08, 2007 3:17 PM
>>To: Sparks, Sam
>>Cc: git@vger.kernel.org
>>Subject: Re: Git'ing a non-labeled set of sources
>>
>>On Wed, Aug 08, 2007 at 02:52:14PM -0500, Sparks, Sam wrote:
>>>  
>>> 
>>> >-----Original Message-----
>>> >From: Peter Baumann [mailto:waste.manager@gmx.de] 
>>> >Sent: Wednesday, August 08, 2007 2:37 PM
>>> >To: Sparks, Sam
>>> >Cc: git@vger.kernel.org
>>> >Subject: Re: Git'ing a non-labeled set of sources
>>> >
>>> >On Wed, Aug 08, 2007 at 01:59:38PM -0500, Sparks, Sam wrote:
>>> >> Hello All,
>>> >> 
>>> >> Please excuse me if this is an ignorant question; I'm new to 
>>> >git and my
>>> >> have overlooked something in the documentation.
>>> >> 
>>> >> I'm attempting to obtain a snapshot of source code from an 
>>> >unlabeled git
>>> >> branch in a public repository. I've found in the 
>>documentation that a
>>> >> timestamp cannot be used to specify a particular version of 
>>> >source code,
>>> >> but I believe I can work with the commit value as 
>returned by 'git
>>> >> show'.
>>> >> 
>>> >> However, I have been unsuccessful in my attempts to use this 
>>> >identifier
>>> >> to clone or checkout the associated source tree. Has anyone been
>>> >> successful in using git to successfully replicate an 
>>> >unlabeled version
>>> >> of sources in a repository?
>>> >> 
>>> >> Here is my latest attempt:
>>> >> /dir_i_want_to_replicate $ git show --pretty=short
>>> >> commit 5b1313fb2758ffce8b624457f777d8cc6709608d
>>> >> Author: ....
>>> >> 
>>> >> /replication_dir $ git clone git://www.denx.de/git/u-boot.git
>>> >> u-boot-mpc83xx
>>> >> Blah blah blah..
>>> >>  100% (4378/4378) done
>>> >> /replication_dir/u-boot-mpc83xx/ $ git checkout
>>> >> 5b1313fb2758ffce8b624457f777d8cc6709608d
>>> >> error: pathspec '5b1313fb2758ffce8b624457f777d8cc6709608d' 
>>> >did not match
>>> >> any. 
>>> >> 
>>> >
>>> >Because there is no 5b1313fb2758ffce8b624457f777d8cc6709608d in the
>>> >repo.
>>> >
>>> >  $ git clone git://www.denx.de/git/u-boot.git
>>> >  Initialized empty Git repository in /tmp/u-boot/.git/
>>> >  remote: Generating pack...
>>> >  remote: Done counting 40938 objects.
>>> >  remote: Deltifying 40938 objects.
>>> >  remote:  100% (40938/40938) done
>>> >  Indexing 40938 objects...
>>> >  remote: Total 40938 (delta 32545), reused 39302 (delta 31040)
>>> >  100% (40938/40938) done
>>> >  Resolving 32545 deltas...
>>> >  100% (32545/32545) done
>>> >
>>> >  $ cd u-boot; git-rev-list --all|grep ^5b1
>>> >  5b1d713721c3ea02549940133f09236783dda1f9
>>> >
>>> >-Peter
>>> 
>>> Hmmm. There must be something I am not understanding about git.
>>> When I run the same command on my existing git repository, I get the
>>> following:
>>> $ git-rev-list --all | grep ^5b1
>>> 5b1313fb2758ffce8b624457f777d8cc6709608d
>>> 5b1d713721c3ea02549940133f09236783dda1f9
>>> 
>>> Does git allow the removal of commits? I don't understand 
>>how I was able
>>> to download it a couple of months ago, but it is no longer 
>>accessible.
>>> 
>>> Thanks for the quick reply,
>>> Sam
>>
>>If the branch was rebased, then yes. But this is not nice for
>>contributers, so it is normally the rule to not rebase a published
>>branch. But e.g. the branch 'pu' on git.git is a branch which will be
>>rebased. This is mentioned by Junio in his notes from the maintainer.
>>
>>What made me wonder is, if you have the commit localy, why can't you
>>check it out? Please try a git-fsck --full run, to see if you have a
>>corrupt repo.
>>
>>-Peter
>>
>>
>I had to upgrade from git v1.4.4.4 to v1.5.0.7 to have access 
>to the git-fsck command. 'git-fsck --full' printed out 
>nothing, and 'git-fsck --full run' printed out an error 
>message (error: invalid parameter: expected sha1, got 'run'). 
>Was I doing something wrong?
>
>--Sam

Peter,

I had an epiphany and discovered the problem: When I created the
repository I was trying to replicate, I didn't download it using git; I
simply copied it from another u-boot repository on the same server. 

When trying to use the commit number on a known good build, I didn't
have any problem replicating that branch.

Thanks for the help, and sorry it was a dumb error on my part.
--Sam
