From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 22:28:52 +0530
Message-ID: <ab9fa62a0903110958s215a84e6y16b4527ab76cb25b@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
	 <alpine.LNX.1.00.0903111159530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 18:01:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRn7-0004k9-2o
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 18:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbZCKQ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbZCKQ65
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:58:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:40452 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZCKQ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 12:58:56 -0400
Received: by yw-out-2324.google.com with SMTP id 5so611751ywh.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R1JnMsNqNHDE25R42l8/iZQgXkwlPFiWJHQ/RotkP3s=;
        b=af4vja6AFeYWvuOcmhGVHbrB2Vb41B8Q+ZVJY7/bCzaxMniqvSuWnLarl1/Qdgw54z
         x65ku2jd5MMpqGjDTr4TR2/4ax0nFLTg74xKn44528GKqP/nj98sXJoACPETw97RBNj3
         Evw+SaA+F8j7CxHe37baYMKUCoPXZ7yhMEjro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vXheWB8HOmXA3N0aDmLj83o5ztv31LT/qRc8KHpz0u0JKxwLk2VRThUOFdgC9NXeR3
         aWCiIoh3uVfcaxc3Ytvg6cHrZoOQEblFYysNLUi+hwPwGZoJbiEnhmDPCOESkKaF4sqw
         0+UKIXzGoURZI5hqOwIEUV1HwRn9poMvpNgwk=
Received: by 10.231.14.196 with SMTP id h4mr2046484iba.15.1236790732903; Wed, 
	11 Mar 2009 09:58:52 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0903111159530.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112957>

On Wed, Mar 11, 2009 at 9:59 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Wed, 11 Mar 2009, saurabh gupta wrote:
>
>> On Wed, Mar 11, 2009 at 7:32 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Wed, 11 Mar 2009, saurabh gupta wrote:
>> >
>> >> What I think is to implement file formats other than text like that
>> >> written on wiki i.e. latex, xml, or even any database file (db file).
>> >> Another idea (although it can be weired also) is to implement the new
>> >> file formats in the plug-in formats. For example, to incorporate the
>> >> merger engine for a new file format, a plug-in is created and can be
>> >> integrated with the present merger in the git. However, I am not sure
>> >> how much valid is this idea to make the present merger in git to be
>> >> compatible with the plug-ins for enabling newer file formats.
>> >
>> > I am not sure that a plugin structure is needed.  Take, for example, three
>> > different .xml based formats: OpenOffice documents, .svg files and Ant
>> > build.xml files.  They need very different user interfaces.
>>
>> okay. In that case, if they have  a different user interfaces then
>> separate plug-in would be needed for each of these. May be this will
>> get more messy.
>
> One thing that I think would be good whenever possible is to have the
> merge program generate a file in the same format which is easily
> recognizable as having conflict markers. For example, I think it should be
> possible to show conflicts in the text of office documents by having
> styles for each side of the merge, and show each side's content in the
> appropriate style. Then the user opens the document with their choice of
> office software, finds the things in the conflict styles, and decides what
> the result should be.

Well, I think this is what which is done in case of normal text files
also. The conflicts put the markers in the file to indicate the
changes and the modification part. However, in the case of OO
documents, we have to change the content for the xml file and when it
is opened in the office software, the user will get the modified
contents.


> Of course, if the two sides conflict over something that isn't text, it
> gets harder.
>
> Also remember that, for a merge, there are two important cases: (1) the
> two sides changed things that aren't related at all; (2) the two sides
> changed things that might affect each other. In case (1), the tool should
> take care of everything automatically and report that it took care of it;
> in case (2), it should reliably determine that user assistance is
> required.
>
>        -Daniel
> *This .sig left intentionally blank*
>



-- 
Saurabh Gupta
Senior,
Electronics and Communication Engg.
NSIT,New Delhi, India
