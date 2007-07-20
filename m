From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Another question about importing SVN with fast-import
Date: Fri, 20 Jul 2007 08:01:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707200759090.20056@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
 <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
 <20070720051142.GO32566@spearce.org> <Pine.LNX.4.64.0707200646400.18125@beast.quantumfyre.co.uk>
 <7154c5c60707192354k7db677a6m4f8cbd474747ca92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: David Frech <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmUL-00072g-3Z
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 09:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbXGTHBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 03:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757201AbXGTHBE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 03:01:04 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:51195 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756283AbXGTHBD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2007 03:01:03 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id F2824D75E1
	for <git@vger.kernel.org>; Fri, 20 Jul 2007 08:01:01 +0100 (BST)
Received: (qmail 28700 invoked by uid 103); 20 Jul 2007 08:01:01 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3701. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.031719 secs); 20 Jul 2007 07:01:01 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Jul 2007 08:01:01 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7154c5c60707192354k7db677a6m4f8cbd474747ca92@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53064>

On Thu, 19 Jul 2007, David Frech wrote:

> On 7/19/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>>  On Fri, 20 Jul 2007, Shawn O. Pearce wrote:
>> 
>> >  It is possible.  I'm just not sure what the syntax for it should be.
>> >  Suggestions?  I really want to stay backwards compatible with the
>> >  current "C" command, so:
>> > 
>> >        'C' SP commit SP path SP path
>> > 
>> >  is out because its ambiguous with the current meaning where the
>> >  second (destination) path can contain SP without being quoted by
>> >  the frontend.
>>
>>  You could always make it part of the 'M' command?
>>
>>  'M' sp mode sp 'copy' sp path_str lf (ref_str | hexsha1 | sha1exp_str |
>>  idnum) SP path_str;
>>
>>  Or just make it a new command, O (for other) or E (for existing) maybe? :S
>
> Since we'll be referring to past commits via marks (with start with
> ":") how about this:
>
> 'C' SP srcpath:mark SP dstpath

Why only via marks?  That may be what you happen to want, but no other 
command restricts you to _only_ using marks ...

>
> In the case of making it a new command I can't think of any really
> compelling one letter names. ;-)
>
> - David
>
>>
>>  --
>>  Julian
>>
>>    ---
>>  It is easier to change the specification to fit the program than vice
>>  versa.
>> 
>
>

-- 
Julian

  ---
What say you, Mr. American Ambassador?

Fuck Canada!
