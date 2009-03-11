From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 14:05:56 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>  <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>  <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>  <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com> <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm> <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhVeN-0006l8-Ma
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 22:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZCKVGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZCKVGI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 17:06:08 -0400
Received: from mail.lang.hm ([64.81.33.126]:38578 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbZCKVGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 17:06:07 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2BL5ufx009409;
	Wed, 11 Mar 2009 13:05:56 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112977>

On Wed, 11 Mar 2009, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 11 Mar 2009, david@lang.hm wrote:
>
>> there are two types of helpers that can be written
>>
>> 1. a low-level part that does the simple merges automaticaly and leaves
>>    behind appropriate conflict markers when it can't
>>
>> [...]
>>
>>
>> 2. after a conflict has taken place, a helper to work with the user to
>>    resolve the conflict
>
> I thought that from my description on the wiki it was obvious that both
> are needed.

first off, I'll admit that I am just going by what's been posted here, I 
haven't gone looking on the wiki.

secondly, I somewhat disagree with you. #1 is needed for any new formats 
that are goning to be handled, but #2 may not be.

take the case of OO documents, you may not need to write a conflict 
resolver helper. the 'appropriate conflict markers' may be something that 
shows up in your normal OO document editor similar to how the ====> shows 
up in a text editor for text conflicts

David Lang
