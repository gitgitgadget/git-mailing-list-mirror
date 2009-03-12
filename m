From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 13:47:28 +0100
Message-ID: <49B90460.2020803@drmicha.warpmail.net>
References: <49B74373.3090609@gmail.com>	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>	 <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>	 <alpine.LNX.1.00.0903111159530.19665@iabervon.org> <ab9fa62a0903110958s215a84e6y16b4527ab76cb25b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkLh-0008Hh-MB
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539AbZCLMro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbZCLMrn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:47:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35846 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755402AbZCLMrm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:47:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4A43E2ECCE3;
	Thu, 12 Mar 2009 08:47:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 12 Mar 2009 08:47:40 -0400
X-Sasl-enc: YgmFSZTgEuPdJyKjF5bcdAsWQZqLonPY6LuhUr3rfJY1 1236862059
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 534144C69E;
	Thu, 12 Mar 2009 08:47:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <ab9fa62a0903110958s215a84e6y16b4527ab76cb25b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113061>

saurabh gupta venit, vidit, dixit 11.03.2009 17:58:
> On Wed, Mar 11, 2009 at 9:59 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>
>>> On Wed, Mar 11, 2009 at 7:32 PM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>> Hi,
>>>>
>>>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>>>
>>>>> What I think is to implement file formats other than text like that
>>>>> written on wiki i.e. latex, xml, or even any database file (db file).
>>>>> Another idea (although it can be weired also) is to implement the new
>>>>> file formats in the plug-in formats. For example, to incorporate the
>>>>> merger engine for a new file format, a plug-in is created and can be
>>>>> integrated with the present merger in the git. However, I am not sure
>>>>> how much valid is this idea to make the present merger in git to be
>>>>> compatible with the plug-ins for enabling newer file formats.
>>>> I am not sure that a plugin structure is needed.  Take, for example, three
>>>> different .xml based formats: OpenOffice documents, .svg files and Ant
>>>> build.xml files.  They need very different user interfaces.
>>> okay. In that case, if they have  a different user interfaces then
>>> separate plug-in would be needed for each of these. May be this will
>>> get more messy.
>> One thing that I think would be good whenever possible is to have the
>> merge program generate a file in the same format which is easily
>> recognizable as having conflict markers. For example, I think it should be
>> possible to show conflicts in the text of office documents by having
>> styles for each side of the merge, and show each side's content in the
>> appropriate style. Then the user opens the document with their choice of
>> office software, finds the things in the conflict styles, and decides what
>> the result should be.
> Well, I think this is what which is done in case of normal text files
> also. The conflicts put the markers in the file to indicate the
> changes and the modification part. However, in the case of OO
> documents, we have to change the content for the xml file and when it
> is opened in the office software, the user will get the modified
> contents.

OO already knows versioned documents and recording of changes. It can
even merge documents which are different modifications of the same base
document (assuming all authors used recording of changes) and compare
possibly unrelated documents, merging them interactively. At least OO 3
can do that. So I guess for OO one mostly has to figure out how to call
that stuff from the command line. Heck, even MS Office can do that.
Remember those docs with recorded changes, where published documents
contained the deletions as well as the deleted passages?

Michael
