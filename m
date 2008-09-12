From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 17:05:40 +0200
Message-ID: <48CA8544.8090000@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net> <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:07:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAEW-0001UZ-C0
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbYILPFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbYILPFp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:05:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:51276 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbYILPFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:05:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so325974ywe.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=NG8ZbqoOk/wO+HpYwZ+QzIUMKkI5pyuSo04yAaH6sFU=;
        b=nhKe5U+6yTscJR3wUXeL9KG8ojajVCIeTJYgOsu90DM4BbnTMdWgdbgZfE6h22xE38
         0HncGam61Oc3EsfTiLW3BiHIV2eKlQ9rCa789EM4K10iLHOI1KF+Mv588RxuD2MP40C0
         D/8Y0aFp/L6P43WHCi4fjFSHJujE86tloj7i0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=Ud6OnWP4/w+gwNjonvGTln9m6bmnAdsTpdhwp6pcXj1RFjO4M0H8Ct2n+MAUUdT9kg
         H7+2r19/Rk/3aZcB31OQm+UbpSnxjlJF/TBGFKufG/JvfMeYLRylp0kgbf3TOqPUUkFK
         tgt/NtIAqDPrbBHJ2OMeO4+WYH7Xl+WeB2hqI=
Received: by 10.86.65.9 with SMTP id n9mr3308569fga.55.1221231941816;
        Fri, 12 Sep 2008 08:05:41 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 4sm12894651fgg.4.2008.09.12.08.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 08:05:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080912145802.GV5082@mit.edu>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95732>

Theodore Tso wrote:
> On Fri, Sep 12, 2008 at 07:47:39AM +0200, Stephen R. van den Berg wrote:
>>> You could add it as a 
>>> 	Original-patch-id: <sha1>
>> That will probably work fine when operating locally on (short) temporary
>> branches.
>>
>> It would probably become computationally prohibitive to use it between
>> long lived permanent branches.  In that case it would need to be
>> augmented by the sha1 of the originating commit.
> 
> Nope, as Sam suggested in his original message (but which got clipped
> by Linus when he was replying) all you have to do is to have a
> separate local database which ties commits and patch-id's together as
> a cache/index.

Yeah, I must admit I am okay with *this* cache.

Paolo
