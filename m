From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 19:43:50 +0530
Message-ID: <ab9fa62a0903110713k2a21cefbj1e7cd3c126aca8f9@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 15:16:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhPDQ-0000cv-3b
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 15:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZCKON4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 10:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbZCKONz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 10:13:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31734 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbZCKONy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 10:13:54 -0400
Received: by yw-out-2324.google.com with SMTP id 5so531018ywh.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/cROE5MrfBgma/WFzQfhd86OlVtSpA+vCXBU7nwDwTA=;
        b=hUEzU1G8uCX1goZ6T9uxorEAmjLA8V2mV/qq/GyhjNDbTsvc9CHzRIeakA2LNIGo2b
         85KqfdfHNS66JW6/bFmecq1uA1WIsj460AYZE6H7vu6xniJfp7kPGEYL5/z2pO7OcsJz
         LEwXmoBtZyKSnfw6uulZ8meYpufW0uld5oV2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oaTledDG0KthATR99WeRJUA7yYdyNW/Te2eDMzaLqdRjtT224b/vczrdtqpwHbm4Zp
         +hjx16/Fn06OieCFbn3tKqmXeNJuxrszuetkI4i58P0g6fdcpSv2S6c5b1qirwZSrby/
         GEWj+Rkx8xMzEfzwaICEHvTRI7vwbqKRbcuks=
Received: by 10.231.20.1 with SMTP id d1mr2002176ibb.19.1236780830883; Wed, 11 
	Mar 2009 07:13:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112931>

On Wed, Mar 11, 2009 at 7:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 11 Mar 2009, saurabh gupta wrote:
>
>> What I think is to implement file formats other than text like that
>> written on wiki i.e. latex, xml, or even any database file (db file).
>> Another idea (although it can be weired also) is to implement the new
>> file formats in the plug-in formats. For example, to incorporate the
>> merger engine for a new file format, a plug-in is created and can be
>> integrated with the present merger in the git. However, I am not sure
>> how much valid is this idea to make the present merger in git to be
>> compatible with the plug-ins for enabling newer file formats.
>
> I am not sure that a plugin structure is needed.  Take, for example, three
> different .xml based formats: OpenOffice documents, .svg files and Ant
> build.xml files.  They need very different user interfaces.

okay. In that case, if they have  a different user interfaces then
separate plug-in would be needed for each of these. May be this will
get more messy.

>
>> I am thinking of using gtk+ libraries to implement the GUI part (I am
>> quite comfortable with gtk+).
>
> I mentioned Tcl/Tk, because it is portable, but I'll also take gtk-based
> stuff ;-)

All right. We can think over this issue. Being honest, I have not
worked on Tcl/Tk yet but I have no problem in learning it and I am
sure that I will get my hands on Tcl/Tk within no time.

>> However, I think in merging and notifying about the conflicts in the xml
>> files, other things can also be put forward. Like the GUI will show the
>> number of tags differing and what are the new tags added and even if any
>> tag is renamed with the content unchanged. If possible, how about
>> showing a tree like structure (just like DOM model) to compare (or diff)
>> the two xml files.
>
> This is a little bit too low-level for my liking.  Taking the OpenOffice
> example again, the GUI should not expose XML at all...

hmmmm.....I think I get your point somewhat. Let me do some research
over the formats and the background formats in which tools like
OpenOffice store the data in xml files. May be for docbooks by
OpenOffice, the best thing would be to give the *diff* output in terms
of lines.
I would also appreciate to know what you think and would like to see
the output in such case.

>
> Ciao,
> Dscho
>
>



-- 
Saurabh Gupta
Senior,
Electronics and Communication Engg.
NSIT,New Delhi, India
