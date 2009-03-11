From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 12:30:37 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903111229330.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>  <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>  <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302> <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302> <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm> <alpine.DEB.1.00.0903111800500.10498@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: saurabh gupta <saurabhgupta1403@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 20:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUA5-0001wj-W0
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 20:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZCKTar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZCKTaq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 15:30:46 -0400
Received: from mail.lang.hm ([64.81.33.126]:59632 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971AbZCKTap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 15:30:45 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2BJUbbC008987;
	Wed, 11 Mar 2009 11:30:37 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903111800500.10498@intel-tinevez-2-302>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112965>

On Wed, 11 Mar 2009, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 11 Mar 2009, david@lang.hm wrote:
>
>> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
>>
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
> I do not think it makes sense to assume all you have at your hands is a
> terminal when you try to resolve a merge conflict in an .svg file.

I'm not saying that you assume that all you have is a terminal, I'm saying 
that you _support_ the case that all you have is a terminal.

David Lang
