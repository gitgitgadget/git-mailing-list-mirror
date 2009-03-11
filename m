From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 21:59:19 +0530
Message-ID: <ab9fa62a0903110929t63fcd40jbf88b21f4a1f37ba@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
	 <alpine.DEB.1.00.0903111631310.10498@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRKT-0007vA-8L
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbZCKQ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbZCKQ3X
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:29:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:16651 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZCKQ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 12:29:21 -0400
Received: by yw-out-2324.google.com with SMTP id 5so596477ywh.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=heOplFcR+M9IHBbt5guWagcWVldy/rBTkqtnv+2n7dQ=;
        b=IS9b1C2Mhe6uVBYEsHxxO4Ia45ipg9aXONFw77an+ls0e3QnQ32kRSzYMQVEnfUvjW
         wfqiwaPcr/+UqFSuIG+XB7ffC+KMejmhrwGhQwV6eYdnxy3U14VeWwmkYVGifyX+B47T
         55TKEUvIXeWbCK9nrkNLHjjVlvzPaQFEg7z10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uyTT1XO4j3uNytglWQXJIS2s33/6xfa6S1MZQmv2tsyBb+CQp4gjXtRdOKFmnLg99I
         YH9mYXzCPDD1HDFdg1VXlseIMQrKcBgLJ3GQlaXKCwLa0svYRneQW9Y+ZXXWTlEUtam6
         gAwhnj2YVggOugVs0XY1Q0WsW+vclZy8MkL8U=
Received: by 10.231.30.67 with SMTP id t3mr2040535ibc.21.1236788959202; Wed, 
	11 Mar 2009 09:29:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111631310.10498@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112950>

On Wed, Mar 11, 2009 at 9:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 11 Mar 2009, saurabh gupta wrote:
>
>> On Wed, Mar 11, 2009 at 7:32 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
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
>> > I am not sure that a plugin structure is needed.  Take, for example,
>> > three different .xml based formats: OpenOffice documents, .svg files
>> > and Ant build.xml files.  They need very different user interfaces.
>>
>> okay. In that case, if they have a different user interfaces then
>> separate plug-in would be needed for each of these. May be this will get
>> more messy.
>
> The thing is: "plugin" is an architecture issue, which I think we will
> have plenty of time hashing out.  "GUI" is the bigger problem, because if
> we cannot come up with something that is worth implementing, we can stop
> the project early.

We can decide for the GUI part. RIght now, I am going through the
background for Tcl/Tk. I am sure that using this tool will serve the
purpose in the better way and portability issue can also be kept in
mind.


>> >> However, I think in merging and notifying about the conflicts in the
>> >> xml files, other things can also be put forward. Like the GUI will
>> >> show the number of tags differing and what are the new tags added and
>> >> even if any tag is renamed with the content unchanged. If possible,
>> >> how about showing a tree like structure (just like DOM model) to
>> >> compare (or diff) the two xml files.
>> >
>> > This is a little bit too low-level for my liking.  Taking the
>> > OpenOffice example again, the GUI should not expose XML at all...
>>
>> hmmmm.....I think I get your point somewhat. Let me do some research
>> over the formats and the background formats in which tools like
>> OpenOffice store the data in xml files. May be for docbooks by
>> OpenOffice, the best thing would be to give the *diff* output in terms
>> of lines.
>
> Actually, I think that the diff is not the issue.  What is needed is a way
> that is both intuitive and versatile enough that all kinds of merge
> conflicts in OpenOffice documents can be resolved by a total computer
> illiterate.
>
> The same problem applies for SVG files, but the user interface would look
> completely different.
>
> As such, it might not be wise to have a common framework at all, but to
> make the first an extension for OpenOffice, and the second a modification
> of, say, inkscape.
>
> Of course, David will then come and say: "But that is more appropriate a
> project for OpenOffice and inkscape, then!".
>
> The good thing is that this is Open Source, and we'll just ask them to
> co-mentor this project.

All right. I agree with this and We can come up with a plan to
implement the thing in an organized way. I agree with you that one
common platform for these will not work because of the way they are
represented and is comfortable for a normal computer user.

>> I would also appreciate to know what you think and would like to see the
>> output in such case.
>
> That's the thing: I do not know yet how it should look like.
>
> Ciao,
> Dscho
>
>



-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
