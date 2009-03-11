From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 12:29:29 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>  <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
  <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>  <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm> <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 20:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhU9W-0001fO-Gf
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 20:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbZCKTaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 15:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbZCKTaN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 15:30:13 -0400
Received: from mail.lang.hm ([64.81.33.126]:59627 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbZCKTaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 15:30:12 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2BJTUq7008978;
	Wed, 11 Mar 2009 11:29:30 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112964>

On Wed, 11 Mar 2009, saurabh gupta wrote:

> On Wed, Mar 11, 2009 at 10:02 PM,  <david@lang.hm> wrote:
>> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
>>
>>> Hi,
>>>
>>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>>
>>>> What I think is to implement file formats other than text like that
>>>> written on wiki i.e. latex, xml, or even any database file (db file).
>>>> Another idea (although it can be weired also) is to implement the new
>>>> file formats in the plug-in formats. For example, to incorporate the
>>>> merger engine for a new file format, a plug-in is created and can be
>>>> integrated with the present merger in the git. However, I am not sure
>>>> how much valid is this idea to make the present merger in git to be
>>>> compatible with the plug-ins for enabling newer file formats.
>>>
>>> I am not sure that a plugin structure is needed.  Take, for example, three
>>> different .xml based formats: OpenOffice documents, .svg files and Ant
>>> build.xml files.  They need very different user interfaces.
>>>
>>>> I am thinking of using gtk+ libraries to implement the GUI part (I am
>>>> quite comfortable with gtk+).
>>>
>>> I mentioned Tcl/Tk, because it is portable, but I'll also take gtk-based
>>> stuff ;-)
>>>
>>>> However, I think in merging and notifying about the conflicts in the xml
>>>> files, other things can also be put forward. Like the GUI will show the
>>>> number of tags differing and what are the new tags added and even if any
>>>> tag is renamed with the content unchanged. If possible, how about
>>>> showing a tree like structure (just like DOM model) to compare (or diff)
>>>> the two xml files.
>>>
>>> This is a little bit too low-level for my liking.  Taking the OpenOffice
>>> example again, the GUI should not expose XML at all...
>>
>> don't assume that you have a GUI just to handle a filetype. if you have one,
>> good, make use of it. but have a fallback for how to deal with things if all
>> you have is a text terminal.
>
> In case of only a terminal, It would be very difficult to show an OO
> document to represent the *diff* output in both text as well in GUI.
> For example, to indicate the changes in an OO document, we will have
> to change the underlying XML file appropriately to show the markers
> signs and other things in the conflict file. Now, if this file is
> opened in terminal, it would not be at all comprehensible to see the
> differences.
>
> The main thing is that to create *diff* for different file formats, we
> will have to write the parser code accordingly.

correct, and in the case of an XML file, the meaningful diff can be 
substantially shorter than what a text diff of the two files would be 
(whitespace changes that don't matter, even some tag ordering changes 
may not matter)

I'm just asking that you don't get so fixated on what can be done in a GUI 
that you provide no benifit to people who don't have the GUI

there are a _lot_ of XML based formats out there, having a diff/merge 
capability to make dealing with them better than just treating them as 
text files would be a _very_ useful thing.

going beyond that and creating the ability to do the markup in 
application-specific ways, and present it to the user in a nice GUI would 
also be nice, but these are a step up after having the basic XML handling 
that isn't specific to a particular application.

David Lang
