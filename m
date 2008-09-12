From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 17:40:26 +0200
Message-ID: <48CA8D6A.4000303@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu> <200809121711.32448.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAmB-0005Ev-2g
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbYILPkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbYILPkc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:40:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:50942 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbYILPkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:40:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so335363yxm.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=87dKe4L3WpVA2OdkvdjYMVRcUBqv1+jHX5jgtXmrPLI=;
        b=aj7hz54R3j/z2o62WtP6uuEuAfPi4OHdxPLz6+nlzAfqgiztogJA+DMdl0Lx4+hdq0
         rG/P5JfLGaly+wamxbsT69I+57wXSwwQlTa+9jExbhCHN6czL92giWjNgdl+UtszbGHq
         GrPKUvQZkTkLhxOOFZoKuCOqCqTlPRPADXt48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=fM30oS9ufnLU5XdedOodntzQ51C6etl2J9aZvCGEuyo5v+he/YM0yCYiw/UJ6XKMIg
         T7HqJfNgGaJy8YCmYCg/3m3clWak1HNvqvmBf1i9WUtSQY9J8lN3IIiLJSziugeynXxA
         TsQzapNFqsFx2guMCDMW5UeO5WMQKm78ZgQP8=
Received: by 10.86.80.17 with SMTP id d17mr3342920fgb.24.1221234029351;
        Fri, 12 Sep 2008 08:40:29 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.179.202])
        by mx.google.com with ESMTPS id 12sm11126847fgg.0.2008.09.12.08.40.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 08:40:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <200809121711.32448.jnareb@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95739>


>> I know you seem to be resistent to caches, but caches are **good**
>> because they are local information, which by definition can be
>> implementation-dependent; you can always generate the cache from the
>> git repository if for some reason you need to extend it. [...]
> 
> But it is not true that "you can always generate the cache from the
> git repository" in this case; the patch-id that is to be saved is
> _original_ patch-id of cherry-picked (or reverted) changeset.

He's proposing storing the original patch id in the commit message, and
caching the commit SHA->patch id association on the side.

Paolo
