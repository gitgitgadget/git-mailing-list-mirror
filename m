From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 19:25:54 +0530
Message-ID: <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhOw3-0001hk-1e
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 14:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZCKNz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 09:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZCKNz6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 09:55:58 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:33123 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbZCKNz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 09:55:57 -0400
Received: by gxk11 with SMTP id 11so36848gxk.13
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CcEbEXk7L5vAWpIBP7wqENBb44XGi9yUXR8qCeIxWH8=;
        b=V8EXboFtR73+aiUUhaStJLwIH9aXVa4WUceQZ4DHXNNOMKgpwCyXz5bAC57Xvs3DUg
         nP9v4g6WVOLNK9R7bLtJfSr2VlBStjGaFoTTs6UFjCh91l/cydSn81cOWDkgya68/XNJ
         WByBbcDUU9nkUjMEv+cY+2kZoT4uC/B9oWrPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tA+GYAcb1eeMg9rNO4ceC0jKtnD+DdK3y7a9wHs9zpeVIIdhvFa0QHuozohhjG+yS/
         8ei5YhRmZJGmWX1pmG0LNix+bUAivbs5qFhcIcqZZM83f4ykCbF+7O2yyMg9wzoOmeSz
         BE+vuBSLroR6dyeSIR2f4LYCKH2QLHH+u+Re8=
Received: by 10.231.12.138 with SMTP id x10mr1998367ibx.16.1236779754752; Wed, 
	11 Mar 2009 06:55:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112929>

On Wed, Mar 11, 2009 at 6:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 11 Mar 2009, saurabh gupta wrote:
>
>> On Wed, Mar 11, 2009 at 5:28 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Wed, 11 Mar 2009, Saurabh Gupta wrote:
>> >
>> > > /*About GSoC GIT ideas; */Here are the ideas which I found to be
>> > > interested in. Although, I would like to discuss any other idea than
>> > > these in GIT organization.
>> > >
>> > > *1) Domain specific merge helpers* Intelligence in the merger can be
>> > > put which modifies the source file according the format. Different
>> > > file formats can be put in the merger to support.
>> >
>> > You said that you are interested in this project, but from your mails
>> > I do not see what are the specific reasons why.
>>
>> All right. May be I lacked in my mail to specify the reason for my
>> interest.
>
> Oh, sorry, I did not mean to imply any offense...

No, I didn;t mean that either too :-D

>
>> The reason is that from my past experience, I got the notion that this
>> project is according to my interest and is doable in the three months
>> time period.
>>
>> Another reason is that I have been using the versioning tools like svn
>> and now perforce for a long time and this added up to my interest.
>
> Sounds good!
>
>> > IMHO this project can only fly if you have a specific file format that
>> > you absolutely want to be able to merge; otherwise, it will be an
>> > uphill fight.
>>
>> Well, as suggested on the wiki, I would like to work on the xml file
>> formats as I have quite experience of working with xml files and parsing
>> them using msxml and nsxml libraries and some of personal wrappers.
>
> As I am known to not exactly like Microsoft's products, if you wanted to
> have me as a mentor, you'd need to use Open Source libraries to do the
> parsing.

Yeah, of course. I mentioned msxml and nsxml just to indicate that I
am comfortable with the xml parsing. I will, no doubt, go for open
source libraries to parse xml and write or reuse some of my own
wrappers to parse xml.



>> How about my idea of making the support of new file formats in the
>> plug-ins (suggested in my last post).
>
> Sorry, I missed that idea.  Could you describe it again?
>

All right. This is the quote which I said in my last posts.

=>What I think is to implement file formats other than text like
that written on wiki i.e. latex, xml, or even any database file (db
file).  Another idea (although it can be weired also) is to implement
the new file formats in the plug-in formats. For example, to
incorporate the merger engine for a new file format, a plug-in is
created and can be integrated with the present merger in the git.
However, I am not sure how much valid is this idea to make the present
merger in git to be compatible with the plug-ins for enabling newer
file formats.


>> > Personally, I would _love_ to see a good graphical tool (maybe written
>> > in Tcl/Tk) to help merging conflicts in LaTeX files, but I just do not
>> > have the time...
>>
>> Ok. What I am thinking is to implement something  like that of
>> graphical *diff* command output but in these special file formats, it
>> ought to have intelligence to bring out the difference of two files
>> (like latex or xml) in a readable manner. For example, in case of xml
>> files, if one file contains an inner tag block , then merger GUI
>> should notify the user in a readable manner about this added tag
>> rather than only the difference in lines.
>
> A diff would be a first step, but the real issue are the merge helpers.
> And they need first and foremost a thought-through user interface design.
> The technical issues are all solveable, I am sure.

I got your point. I am thinking of using gtk+ libraries to implement
the GUI part (I am quite comfortable with gtk+). However, I think in
merging and notifying about the conflicts in the xml files, other
things can also be put forward. Like the GUI will show the number of
tags differing and what are the new tags added and even if any tag is
renamed with the content unchanged. If possible, how about showing a
tree like structure (just like DOM model) to compare (or diff) the two
xml files.


> Ciao,
> Dscho
>
>



-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
