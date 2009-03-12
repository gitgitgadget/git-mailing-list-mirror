From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 12:29:57 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>  <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>  <alpine.DEB.1.00.0903112136560.10279@pacific.mpi-cbg.de>  <alpine.DEB.1.10.0903111401520.16753@asgard.lang.hm>
  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1322869717-1236886198=:16753"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 20:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhqd5-0003mU-48
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbZCLTaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbZCLTaR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:30:17 -0400
Received: from mail.lang.hm ([64.81.33.126]:33258 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZCLTaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 15:30:16 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2CJTv18017335;
	Thu, 12 Mar 2009 11:29:57 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113115>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1322869717-1236886198=:16753
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 13 Mar 2009, saurabh gupta wrote:

> On Fri, Mar 13, 2009 at 12:23 AM,  <david@lang.hm> wrote:
>> On Thu, 12 Mar 2009, saurabh gupta wrote:
>>
>>> On Thu, Mar 12, 2009 at 11:30 PM, <david@lang.hm> wrote:
>>>
>>>> On Thu, 12 Mar 2009, saurabh gupta wrote:
>>>>
>>>>>
>>>>> =>Merging of two xml files
>>>>>
>>>>> => existing merge driver (like xdl) is called which marks the
>>>>> conflicts points just like a normal text file.
>>>>>
>>>>> => the conflicted file can be read through a text terminal and
>>>>> conflicted lines can be seen.
>>>>>
>>>>> => suppose the xml file is from the domain of OO document. Then, a
>>>>> merge helper for OO xml type file is called which takes input as the
>>>>> conflicted file produced by xdl driver.
>>>>>
>>>>> => The merge helper creates a new file or changes the input file to
>>>>> make it a valid xml file so that it can be opened in OpenOffice and
>>>>> user can see the markers like "====" or "<<<<<"  in an appropriate
>>>>> manner and can resolve the file manually.
>>>>>
>>>>
>>>> with XML files it's possible to be symanticly identical, but not
>>>> identical
>>>> as far as a text merge driver is concerned.
>>>>
>> <SNIPB>
>>>
>>> you are right. For xml merging, what I am thinking is to create the
>>> algorithm based on the document object model. Inside, any tag, all tags
>>> are
>>> compared only in terms of content and not in order. But again, this
>>> ordering
>>> option can be given to the user. If the user wants order to matter, then a
>>> conflict will be resulted if order mismatches.
>>
>> right.
>>
>>> But other issue is regarding the display of conflict markers. Either
>>> conflict markers should be put in xml format or like text merger. This is
>>> the main project idea for GSoC 2009.
>>
>> this may need to be a configurable option, but I suspect that we could get
>> away with always using something in XML format. exactly what the markers are
>> needs to be configurable (the markers for OO will not be the same as for SVG
>> for example)
>
> yeah.
>
>> building a library of 'this works especially well for this app' markers is
>> something that needs to be started as part of the GSOC project, but possibly
>> only far enough to show a couple of examples and have confidence that the
>> tool is configurable enough.
>>
>
> I think picking up some formats and then building libraries above that
> is needed. In some sense, I talked about the plug-in architecture
> also. Can;t it be possible that for different applications (like OO or
> SVG), different merge helper plugins are created which can be
> integrated with it. Or speaking in  other words, instead of plug-ins
> now, libraries for merge helpers for different applications are
> created.

defining terminology that was mentioned before

merge drivers are run by git to do the merges and create the conflict 
markers. git already has a 'plug-in architecture' for these drivers (you 
can define file types and tell git to use a particular merge driver for 
this file type)

merge helpers are run by the users if there is a conflict and make use of 
the markers. depending on what you end up using for conflict markers, you 
may not need to write a merge helper (for OO, if your conflict markers are 
good enough you can use OO to resolve conflicts easily, no need for a new 
tool)


with this terminology, you can't do merge helpers without doing the merge 
drivers first (what does the helper look for as an indicator of a 
conflict?)

I believe that there is a lot of potential for a configurable merge driver 
to support many similar formats.

using the example of XML-based files, configurable options could include

1. is the file stored compressed or not

2. does the order of the tags matter

3. does whitespace matter

   note: #2 and #3 may boil down to 'is this a document with XML markup, or 
are the XML tags the primary content'

4. how is the conflict marked

4a. wrap the conflicting tags in a set of tags that look like _

4b. if the conflict is in the content, not the tags, modify it similar to 
what we do with text today.

   note: this still requires the new driver to decide if there is a 
conflict or not

4c. other (potentially including calling out to other code for more 
drastic restructuring)


with a merge driver along these lines you can handle many different types 
of XML documents.

with SVG you may be able to put the offending tags in different layers

with OO you may be able to put in tags that indicate a merge conflict in a 
way that OO will directly handle

etc.

in many cases you may not even need to create a merge helper or library 
for other software you use. you just need to figure out what sort of 
manipulation would need to be done to to file to mark the conflict in a 
way that existing applications can understand.

David Lang
--680960-1322869717-1236886198=:16753--
