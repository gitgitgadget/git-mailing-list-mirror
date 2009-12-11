From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 19:07:50 -0800
Message-ID: <4B21B786.3090000@eaglescrag.net>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <1260488743-25855-2-git-send-email-warthog9@kernel.org> <m34onye3h8.fsf@localhost.localdomain> <4B21AC4D.2020407@kernel.org> <7vk4wu6x6a.fsf@alter.siamese.dyndns.org> <4B21B550.1060806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 04:08:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIvrO-0008QP-6U
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 04:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZLKDHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 22:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbZLKDHu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 22:07:50 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:33299 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZLKDHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 22:07:50 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBB37qfx024713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 19:07:54 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <4B21B550.1060806@kernel.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10149/Thu Dec 10 14:26:20 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Thu, 10 Dec 2009 19:07:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135070>

J.H. wrote:
> Junio C Hamano wrote:
>> "J.H." <warthog9@kernel.org> writes:
>>
>>> It was intended to be the most minimal possible, mainly get in, get
>>> out. Also not sure the die_error existed in gitweb when this was
>>> originally written.  Probably worth switching to it now since it's
>>> there either way, and I don't think using it would add enough overhead
>>> to matter.
>>
>> Thanks; all sounded a reasonable response to the review.  Are you
>> re-rolling the series anytime soon (I am asking because then I'd rather
>> not to queue this round especially because I didn't see 5/6).
> 
> I'll probably have some changes up and about tomorrow, and it's a little 
> troubling that 5/6 didn't come through for you
> 
> 6 at least made it to marc.info: 
> http://marc.info/?l=git&m=126048884825985&w=2
> 
> and 5 seems to have been eaten by a grue somewhere.  It was a *big* 
> patch mainly because all the caching flips over in a single go.  If you 
> want I can privately bounce 5 & 6 to you so you have a complete tree 
> right now?

Not to reply to myself but this might also be helpful:

http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v2

- John 'Warthog9' Hawley
