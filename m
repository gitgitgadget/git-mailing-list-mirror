From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 21:51:24 +0530
Message-ID: <ab9fa62a0903110921k43599ba5u5187615b28650d89@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
	 <49B7D84B.6080501@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:23:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRDm-0004kI-PO
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbZCKQWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbZCKQWP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:22:15 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:54358 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbZCKQWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 12:22:14 -0400
Received: by gxk11 with SMTP id 11so193469gxk.13
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9VeBBzR7WuJcP3vy/WRlmpyoVzQTGanmAiZy1NNYMSE=;
        b=jbj2Si3YpBQ1zbm4mo4agmfjUiY8gwbJS66NzMWbx0ND3qMfVaxnyvybQHinzHbKmg
         3PuD4wmGI9K9B8x1oX6PB/Kx88e9YWIicSHeGC8qgre3Qd55nr95o0ABVOGgaQnWj2oq
         Wid9AKPWKkQWh4hq7qmtneRaHE182vQR370oE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rn5GdDNYEI3QynX2DJa5SP2UV5RCowYuM2Ctd26m05sZzyP00O44Crb0aSEJZdr5jD
         WAhvLO8ZYqwv7gRCw+/NOEgjv4X2tSbxgWpswBbqnOPFy7UbX3Kim2vkNHLB3GWKUH7r
         Qk7cDLBUTPejiQ0aRuxTzPQSsJtrDtvP7GEdY=
Received: by 10.231.11.137 with SMTP id t9mr2027500ibt.49.1236788484803; Wed, 
	11 Mar 2009 09:21:24 -0700 (PDT)
In-Reply-To: <49B7D84B.6080501@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112948>

On Wed, Mar 11, 2009 at 8:57 PM, Rogan Dawes <lists@dawes.za.net> wrote:
> saurabh gupta wrote:
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
>> hmmmm.....I think I get your point somewhat. Let me do some research
>> over the formats and the background formats in which tools like
>> OpenOffice store the data in xml files. May be for docbooks by
>> OpenOffice, the best thing would be to give the *diff* output in terms
>> of lines.
>> I would also appreciate to know what you think and would like to see
>> the output in such case.
>
> I think that the implementation may make use of features inherent in the
> file format where possible. e.g. I suspect that OpenOffice has the
> ability to show "Tracked changes", and then allow the user to view the
> changes using the actual OpenOffice implementation.
>
> I suspect that that will get a lot more difficult with e.g. conflicts
> and merges, because I doubt that OOo has the ability to show changes
> from multiple versions.
>
> But I have to agree with Dscho, that the output would have to depend on
> the file type (OOo document), not just the data structure (e.g. XML)
> inside the file.
>
> A regular XML file diff could choose to ignore/collapse whitespace
> (pretty printing) when doing the comparison, to show things like moving
> a branch further down the tree.
>
> e.g.
>
> <i>text</i>
>
> vs
>
> <b><i>text</i></b>
>
> vs
>
> <b>
>  <i>text</i>
> </b>
>
> For plain XML, a textual diff might choose to show it with each element
> un-indented, and a standard text diff output:
>
> + <b>
>  <i>
>  text
>  </i>
> + </b>
>
> while a GUI diff might show the new element highlighted in a tree:
>
> #green#<b>#/green#
>  <i>
>   text
>
> I think that where reasonable that you should aim to have a text-only
> version that could be wrapped by a GUI. Obviously, this would be
> meaningless when diffing a JPG, for instance.

All right. I got what you mean to say.
>
> Ok, that was a bit rambling. I hope it helped more than it confused.
>
> Rogan
>



-- 
Saurabh Gupta
Senior,
Electronics and Communication Engg.
NSIT,New Delhi, India
