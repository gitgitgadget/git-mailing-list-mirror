From: "Sparks, Sam" <SSparks@twacs.com>
Subject: RE: Git'ing a non-labeled set of sources
Date: Wed, 8 Aug 2007 15:45:35 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC170CE6@twx-exch01.twacs.local>
References: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local> <20070808193720.GD27470@xp.machine.xx> <CF7E46FCFF66AD478BB72724345289EC170CE5@twx-exch01.twacs.local> <20070808201718.GE27470@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:46:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsQ8-0000QF-U3
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931AbXHHUqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 16:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757694AbXHHUqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 16:46:16 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:47616 "EHLO
	outbound1-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756197AbXHHUqP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 16:46:15 -0400
Received: from outbound1-fra.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-fra-R.bigfish.com (Postfix) with ESMTP id CB44A8E2794
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 20:46:02 +0000 (UTC)
Received: from mail48-fra-R.bigfish.com (unknown [10.4.252.3])
	by outbound1-fra.bigfish.com (Postfix) with ESMTP id CD20B570002
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 20:45:56 +0000 (UTC)
Received: from mail48-fra (localhost.localdomain [127.0.0.1])
	by mail48-fra-R.bigfish.com (Postfix) with ESMTP id B471020507
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 20:45:56 +0000 (UTC)
X-BigFish: VP
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 68.89.149.4;Service: EHS
Received: by mail48-fra (MessageSwitch) id 1186605956542469_19808; Wed,  8 Aug 2007 20:45:56 +0000 (UCT)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail48-fra.bigfish.com (Postfix) with ESMTP id 3AB7E970086
	for <git@vger.kernel.org>; Wed,  8 Aug 2007 20:45:56 +0000 (UTC)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20070808201718.GE27470@xp.machine.xx>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git'ing a non-labeled set of sources
Thread-Index: AcfZ+RYzRSku8+MYSZym9uzHJ6DBMwAA6iqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55361>

 

>-----Original Message-----
>From: Peter Baumann [mailto:waste.manager@gmx.de] 
>Sent: Wednesday, August 08, 2007 3:17 PM
>To: Sparks, Sam
>Cc: git@vger.kernel.org
>Subject: Re: Git'ing a non-labeled set of sources
>
>On Wed, Aug 08, 2007 at 02:52:14PM -0500, Sparks, Sam wrote:
>>  
>> 
>> >-----Original Message-----
>> >From: Peter Baumann [mailto:waste.manager@gmx.de] 
>> >Sent: Wednesday, August 08, 2007 2:37 PM
>> >To: Sparks, Sam
>> >Cc: git@vger.kernel.org
>> >Subject: Re: Git'ing a non-labeled set of sources
>> >
>> >On Wed, Aug 08, 2007 at 01:59:38PM -0500, Sparks, Sam wrote:
>> >> Hello All,
>> >> 
>> >> Please excuse me if this is an ignorant question; I'm new to 
>> >git and my
>> >> have overlooked something in the documentation.
>> >> 
>> >> I'm attempting to obtain a snapshot of source code from an 
>> >unlabeled git
>> >> branch in a public repository. I've found in the 
>documentation that a
>> >> timestamp cannot be used to specify a particular version of 
>> >source code,
>> >> but I believe I can work with the commit value as returned by 'git
>> >> show'.
>> >> 
>> >> However, I have been unsuccessful in my attempts to use this 
>> >identifier
>> >> to clone or checkout the associated source tree. Has anyone been
>> >> successful in using git to successfully replicate an 
>> >unlabeled version
>> >> of sources in a repository?
>> >> 
>> >> Here is my latest attempt:
>> >> /dir_i_want_to_replicate $ git show --pretty=short
>> >> commit 5b1313fb2758ffce8b624457f777d8cc6709608d
>> >> Author: ....
>> >> 
>> >> /replication_dir $ git clone git://www.denx.de/git/u-boot.git
>> >> u-boot-mpc83xx
>> >> Blah blah blah..
>> >>  100% (4378/4378) done
>> >> /replication_dir/u-boot-mpc83xx/ $ git checkout
>> >> 5b1313fb2758ffce8b624457f777d8cc6709608d
>> >> error: pathspec '5b1313fb2758ffce8b624457f777d8cc6709608d' 
>> >did not match
>> >> any. 
>> >> 
>> >
>> >Because there is no 5b1313fb2758ffce8b624457f777d8cc6709608d in the
>> >repo.
>> >
>> >  $ git clone git://www.denx.de/git/u-boot.git
>> >  Initialized empty Git repository in /tmp/u-boot/.git/
>> >  remote: Generating pack...
>> >  remote: Done counting 40938 objects.
>> >  remote: Deltifying 40938 objects.
>> >  remote:  100% (40938/40938) done
>> >  Indexing 40938 objects...
>> >  remote: Total 40938 (delta 32545), reused 39302 (delta 31040)
>> >  100% (40938/40938) done
>> >  Resolving 32545 deltas...
>> >  100% (32545/32545) done
>> >
>> >  $ cd u-boot; git-rev-list --all|grep ^5b1
>> >  5b1d713721c3ea02549940133f09236783dda1f9
>> >
>> >-Peter
>> 
>> Hmmm. There must be something I am not understanding about git.
>> When I run the same command on my existing git repository, I get the
>> following:
>> $ git-rev-list --all | grep ^5b1
>> 5b1313fb2758ffce8b624457f777d8cc6709608d
>> 5b1d713721c3ea02549940133f09236783dda1f9
>> 
>> Does git allow the removal of commits? I don't understand 
>how I was able
>> to download it a couple of months ago, but it is no longer 
>accessible.
>> 
>> Thanks for the quick reply,
>> Sam
>
>If the branch was rebased, then yes. But this is not nice for
>contributers, so it is normally the rule to not rebase a published
>branch. But e.g. the branch 'pu' on git.git is a branch which will be
>rebased. This is mentioned by Junio in his notes from the maintainer.
>
>What made me wonder is, if you have the commit localy, why can't you
>check it out? Please try a git-fsck --full run, to see if you have a
>corrupt repo.
>
>-Peter
>
>
I had to upgrade from git v1.4.4.4 to v1.5.0.7 to have access to the
git-fsck command. 'git-fsck --full' printed out nothing, and 'git-fsck
--full run' printed out an error message (error: invalid parameter:
expected sha1, got 'run'). Was I doing something wrong?

--Sam
