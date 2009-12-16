From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Tue, 15 Dec 2009 18:00:29 -0800
Message-ID: <4B283F3D.3020209@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <m3ljh9cy3b.fsf@localhost.localdomain> <4B226C0F.2070407@kernel.org> <200912112353.11034.jnareb@gmail.com> <7v8wd3ww4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 03:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKjCm-0000PC-W5
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 03:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934465AbZLPCB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 21:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934499AbZLPCBH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 21:01:07 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:43108 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934497AbZLPCBF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 21:01:05 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBG20T38014312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Dec 2009 18:00:31 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <7v8wd3ww4d.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10172/Mon Dec 14 14:53:58 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Tue, 15 Dec 2009 18:00:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135316>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> On Fri, 11 Dec 2009, J.H. wrote:
>>
>>>>> This is also a not-so-subtle start of trying to break up gitweb into
>>>>> separate files for easier maintainability, having everything in a
>>>>> single file is just a mess and makes the whole thing more complicated
>>>>> than it needs to be.  This is a bit of a baby step towards breaking it
>>>>> up for easier maintenance.
>>>> The question is if easier maintenance and development by spliting
>>>> gitweb for developers offsets ease of install for users.
>>> This would just get dropped into the same location that gitweb.cgi 
>>> exists in, there is no real difference in installation, and thus I can't 
>>> see this as an issue for users.
>> To be more exact you have to know that you have to drop _generated files_,
>> which means (for this version of patch) gitweb.cgi and gitweb_defaults.pl
>> (or whatever the generated file with config variables would be named).
>>
>>
>> ATTENTION!
> 
> You didn't have to shout.
> 
> Any progress on this front?

Sadly, no.  Busy weekend and a need to get some of the kernel.org 
servers upgraded has taken some precedence.  I should be circling back 
around on this tomorrow I think.

> Not that I am anxious to queue new topics to 'next' right now (we are
> frozen for 1.6.6), but I think having what is proven to work well at a
> real site like k.org is much better than waiting for an unproven
> reimplementation using somebody else's framework only for your theoretical
> cleanliness.  John has better things to do than doing such a rewrite
> himself, and even if you helped the process by producing a competing
> caching scheme based on existing web caching engines, the aggregated
> result (not just the web caching engine you base your work on) needs to
> get a similar field exposure to prove itself that it can scale to the load
> k.org sees, which would be quite a lot of work, no?
