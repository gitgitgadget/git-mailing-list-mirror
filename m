From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 22:37:13 +0530
Message-ID: <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Mar 11 18:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRvE-0007yx-JU
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 18:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbZCKRHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 13:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbZCKRHR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 13:07:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:48145 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbZCKRHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 13:07:15 -0400
Received: by yx-out-2324.google.com with SMTP id 8so110541yxm.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0CZ7d6fRZi6w+Hi5GI/0Q04I+4Ut6e0vNJWRo2Af4t0=;
        b=oqMrAxCecFHvVVUK+npK+3+KGpMK2MABSgyWxKFDrHjMn3yqDM4tFpEor67QCmqQ58
         NR4O48EOPumWBAsMx+kAR+MVLGq22N03FWmwlTdwalSIyweWUHdzNb4c/YcGERpe2lv9
         F1WyvY9j/dM7t/QbS/MqJMFtfk+uTcivVifxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s0TeA5go3tUkjdV1tLiNiPuBelz1E9xrrw2rx/ygDko76QRiTLv00s8bSIeLz/ZCwl
         Ph70Ro0rr3h3IU/LtMNu+dnKD427V3m5ZeAp7zHl5NHd6/qN/7c3RgRdEHjIv36MjQRh
         mlpHCViRFTi98zCwPTsu5O11CsGCrt4tnkoaQ=
Received: by 10.231.14.196 with SMTP id h4mr2048622iba.15.1236791233238; Wed, 
	11 Mar 2009 10:07:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112960>

On Wed, Mar 11, 2009 at 10:02 PM,  <david@lang.hm> wrote:
> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
>
>> Hi,
>>
>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>
>>> What I think is to implement file formats other than text like that
>>> written on wiki i.e. latex, xml, or even any database file (db file).
>>> Another idea (although it can be weired also) is to implement the new
>>> file formats in the plug-in formats. For example, to incorporate the
>>> merger engine for a new file format, a plug-in is created and can be
>>> integrated with the present merger in the git. However, I am not sure
>>> how much valid is this idea to make the present merger in git to be
>>> compatible with the plug-ins for enabling newer file formats.
>>
>> I am not sure that a plugin structure is needed.  Take, for example, three
>> different .xml based formats: OpenOffice documents, .svg files and Ant
>> build.xml files.  They need very different user interfaces.
>>
>>> I am thinking of using gtk+ libraries to implement the GUI part (I am
>>> quite comfortable with gtk+).
>>
>> I mentioned Tcl/Tk, because it is portable, but I'll also take gtk-based
>> stuff ;-)
>>
>>> However, I think in merging and notifying about the conflicts in the xml
>>> files, other things can also be put forward. Like the GUI will show the
>>> number of tags differing and what are the new tags added and even if any
>>> tag is renamed with the content unchanged. If possible, how about
>>> showing a tree like structure (just like DOM model) to compare (or diff)
>>> the two xml files.
>>
>> This is a little bit too low-level for my liking.  Taking the OpenOffice
>> example again, the GUI should not expose XML at all...
>
> don't assume that you have a GUI just to handle a filetype. if you have one,
> good, make use of it. but have a fallback for how to deal with things if all
> you have is a text terminal.

In case of only a terminal, It would be very difficult to show an OO
document to represent the *diff* output in both text as well in GUI.
For example, to indicate the changes in an OO document, we will have
to change the underlying XML file appropriately to show the markers
signs and other things in the conflict file. Now, if this file is
opened in terminal, it would not be at all comprehensible to see the
differences.

The main thing is that to create *diff* for different file formats, we
will have to write the parser code accordingly.

> David Lang
>



-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
