From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Thu, 30 Oct 2008 15:25:42 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0810301518300.13964@reaper.quantumfyre.co.uk>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030132453.GB24098@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Sam Vilain <samv@vilain.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:56:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZsc-0004gJ-Ul
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbYJ3Pyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbYJ3Pyp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:54:45 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:55418 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752460AbYJ3Pyp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2008 11:54:45 -0400
X-Greylist: delayed 1694 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2008 11:54:44 EDT
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6593129E1DD9
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 15:26:28 +0000 (GMT)
Received: (qmail 4692 invoked by uid 103); 30 Oct 2008 15:25:42 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.94/8541. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.02889 secs); 30 Oct 2008 15:25:42 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 30 Oct 2008 15:25:42 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20081030132453.GB24098@artemis.corp>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99491>

On Thu, 30 Oct 2008, Pierre Habouzit wrote:

> On Thu, Oct 30, 2008 at 03:48:05AM +0000, Sam Vilain wrote:
>> +Working with patches
>> +--------------------
>> +
>> +  * 'git send-email' should prompt for all SMTP-related information
>> +    about sending e-mail when it is running with no configuration.
>> +    Because these days /usr/lib/sendmail is rarely configured
>> +    correctly.
>
> And when the user answer them, it should set them (a bit like zsh does
> when it's run from the first time e.g.)
>
>> +
>> +  * other git send-email functionality which has bitten people -
>> +    particularly building the recipient list - should prompt for
>> +    confirmation until configured to be automatic.
>> +
>
>  * git-send-email should be either more interactive, or less: either
>    just use the damn configuration, or propose a mode where it spawns
>    an editor for each patch so that you can add further comments.
>
>  * git-send-email should be able to format-patches by himself (IOW
>    accept most of format-patch arguments and deal with the patch list
>    by himself, which is usable if the previous point is implemented).

This gets my vote ...

These are two of the reasons that I ended up ignoring git-send-email and 
writing my own replacement.  I found the whole format-patch/send-email 
dance too cumbersome and confusing - particularly for sending a single 
patch.  To send a single patch I ended up with the command:

git mail-commmits --edit HEAD~1

It would be nice if I could replace this with:

git send-email --edit HEAD~1

;)

>
>> +  * 'git am -3' the default; with global option to make it not the
>> +    default for those that prefer the speed of -2
>> +
>> +

-- 
Julian

  ---
Blessed be those who initiate lively discussions with the hopelessly mute,
for they shall be know as Dentists.
