From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
 branch
Date: Sat, 21 Mar 2009 13:28:00 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0903211326390.20324@reaper.quantumfyre.co.uk>
References: <200903181448.50706.agruen@suse.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk> <200903210135.33729.agruen@suse.de> <alpine.LNX.2.00.0903211323010.20272@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Sat Mar 21 14:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll1IC-0003ko-M9
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 14:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbZCUN3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 09:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbZCUN3r
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 09:29:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:35920 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752963AbZCUN3q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 09:29:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 3126AC63A7
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 13:29:44 +0000 (GMT)
Received: (qmail 17561 invoked by uid 103); 21 Mar 2009 13:28:00 +0000
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9146. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025754 secs); 21 Mar 2009 13:28:00 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 21 Mar 2009 13:28:00 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LNX.2.00.0903211323010.20272@reaper.quantumfyre.co.uk>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114038>

On Sat, 21 Mar 2009, Julian Phillips wrote:

> On Sat, 21 Mar 2009, Andreas Gruenbacher wrote:
>
>>  On Saturday, 21 March 2009 0:08:42 Julian Phillips wrote:
>> >  How about adding a generic escape hatch, that would cover this and
>> >  future extensions?
>> > 
>> >  Let a ref that starts with a single quote be taken as given and not
>> >  processed.  You have to escape it to get it past the shell, but that 
>> >  makes
>> >  it rather unlikely that anyone has used a name that starts with a quote 
>> >  -
>> >  and if they have you can still use this mechanism to rename it.
>>
>>  To me the most obvious escape sequence would be \x for disabling whatever
>>  special meaning x has (for non-alphabetic x). With quoting you likely
>>  eventually end up needing  \' in some cases anyway...
>
> Except that \ is the escape character for the shell too ... and that can get 
> very confusing.  Haven't you ever spent too long trying to figure out how 
> many \s you needed to get the command to work properly?

Having said that, the actual character used doesn't really matter.  That's 
just a what colour do you want your shed type detail ...

-- 
Julian

  ---
BOFH Excuse #118:

the router thinks its a printer.
