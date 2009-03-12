From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 11:53:57 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>  <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>  <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>  <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
  <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>  <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhq4I-000640-Vg
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 19:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbZCLSyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 14:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbZCLSyR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 14:54:17 -0400
Received: from mail.lang.hm ([64.81.33.126]:54577 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZCLSyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 14:54:17 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2CIrvSc017159;
	Thu, 12 Mar 2009 10:53:57 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113104>

On Thu, 12 Mar 2009, saurabh gupta wrote:

> On Thu, Mar 12, 2009 at 11:30 PM, <david@lang.hm> wrote:
>
>> On Thu, 12 Mar 2009, saurabh gupta wrote:
>>
>>>
>>> =>Merging of two xml files
>>>
>>> => existing merge driver (like xdl) is called which marks the
>>> conflicts points just like a normal text file.
>>>
>>> => the conflicted file can be read through a text terminal and
>>> conflicted lines can be seen.
>>>
>>> => suppose the xml file is from the domain of OO document. Then, a
>>> merge helper for OO xml type file is called which takes input as the
>>> conflicted file produced by xdl driver.
>>>
>>> => The merge helper creates a new file or changes the input file to
>>> make it a valid xml file so that it can be opened in OpenOffice and
>>> user can see the markers like "====" or "<<<<<"  in an appropriate
>>> manner and can resolve the file manually.
>>>
>>
>> with XML files it's possible to be symanticly identical, but not identical
>> as far as a text merge driver is concerned.
>>
<SNIPB>
> you are right. For xml merging, what I am thinking is to create the
> algorithm based on the document object model. Inside, any tag, all tags are
> compared only in terms of content and not in order. But again, this ordering
> option can be given to the user. If the user wants order to matter, then a
> conflict will be resulted if order mismatches.

right.

> But other issue is regarding the display of conflict markers. Either
> conflict markers should be put in xml format or like text merger. This is
> the main project idea for GSoC 2009.

this may need to be a configurable option, but I suspect that we could get 
away with always using something in XML format. exactly what the markers 
are needs to be configurable (the markers for OO will not be the same as 
for SVG for example)

building a library of 'this works especially well for this app' markers is 
something that needs to be started as part of the GSOC project, but 
possibly only far enough to show a couple of examples and have confidence 
that the tool is configurable enough.

David Lang
