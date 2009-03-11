From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 12 Mar 2009 01:32:02 +0530
Message-ID: <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
	 <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
	 <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
	 <ab9fa62a0903110655y4a47ccfkde0984ecb46b3307@mail.gmail.com>
	 <alpine.DEB.1.00.0903111458340.10498@intel-tinevez-2-302>
	 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
	 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
	 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Mar 11 21:07:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUeP-0005QS-QX
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 21:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbZCKUCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 16:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbZCKUCG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 16:02:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:19605 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZCKUCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 16:02:04 -0400
Received: by wa-out-1112.google.com with SMTP id v33so94289wah.21
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3ZpQ3Nk3qU/JBi/bAWE0UHwCuNs5t7jNtc7FaL+Q/l0=;
        b=X+U/KuV1bw7jda0i6/Au4nyndfnfMO5NYe6uk0tGWBUhPjUrb3jrAcuvXmaVj3HsAx
         LE6TaZ984zG6O16vZ2v3yom/poBXpMlHIYfXmW+s7b0ZO+pg04oT+P9Xl4pnP1bBMQa1
         8n2KZxw7jWm9vcsbvNRiJMrYl1J7/kRA1apzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TScmw1vu3azL684YPopT+upEnWK8C5UIqoe11xMT3j2zI71llUV40JueO7VJv2J+eE
         reNOSMXiDW8GLgdE1LDb3c8bfr/xkj+DDlFRg2ijV4kjs5dHvD26eQdASb8hFJxo8L9D
         9+f/XsFMUWbo+CiEQ9BSBxicRli9H0nPW+jHE=
Received: by 10.115.89.18 with SMTP id r18mr5401064wal.111.1236801722241; Wed, 
	11 Mar 2009 13:02:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112970>

On Thu, Mar 12, 2009 at 12:59 AM,  <david@lang.hm> wrote:
> On Wed, 11 Mar 2009, saurabh gupta wrote:
>
>> On Wed, Mar 11, 2009 at 10:02 PM,  <david@lang.hm> wrote:
>>>
>>> On Wed, 11 Mar 2009, Johannes Schindelin wrote:
>>>
>>>> Hi,
>>>>
>>>> On Wed, 11 Mar 2009, saurabh gupta wrote:
>>>>
>>
>> In case of only a terminal, It would be very difficult to show an OO
>> document to represent the *diff* output in both text as well in GUI.
>> For example, to indicate the changes in an OO document, we will have
>> to change the underlying XML file appropriately to show the markers
>> signs and other things in the conflict file. Now, if this file is
>> opened in terminal, it would not be at all comprehensible to see the
>> differences.
>>
>> The main thing is that to create *diff* for different file formats, we
>> will have to write the parser code accordingly.
>
> correct, and in the case of an XML file, the meaningful diff can be
> substantially shorter than what a text diff of the two files would be
> (whitespace changes that don't matter, even some tag ordering changes may
> not matter)
>
> I'm just asking that you don't get so fixated on what can be done in a GUI
> that you provide no benifit to people who don't have the GUI
>
> there are a _lot_ of XML based formats out there, having a diff/merge
> capability to make dealing with them better than just treating them as text
> files would be a _very_ useful thing.
>
> going beyond that and creating the ability to do the markup in
> application-specific ways, and present it to the user in a nice GUI would
> also be nice, but these are a step up after having the basic XML handling
> that isn't specific to a particular application.

Yes, but the thing is that the underlying codes and method will be
different for GUI part and terminal part to make it readable and
understandable. Like for OO Documents, if we aim to show the *diff*
output in the Office tool, then we have to change the xml file
accordingly. But the same xml file when used with terminal only, the
*diff* output is not clear.

As Johannes said in above post that for OO documents, while showing
the *diff* result, no xml data should be shown.

-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
