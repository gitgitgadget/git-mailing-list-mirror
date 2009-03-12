From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line 
	lengths)
Date: Thu, 12 Mar 2009 09:12:11 +0000
Message-ID: <e2b179460903120212x67081f69wb66364918714add7@mail.gmail.com>
References: <49B5AF67.6050508@gmail.com>
	 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
	 <49B5F0BA.3070806@gmail.com>
	 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
	 <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
	 <alpine.DEB.1.10.0903120956460.18527@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhgz9-00055V-Nv
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbZCLJMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZCLJMV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:12:21 -0400
Received: from mail-qy0-f122.google.com ([209.85.221.122]:55564 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZCLJMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 05:12:19 -0400
Received: by qyk28 with SMTP id 28so577730qyk.33
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PUuP+mwVpbKCCaGFwBPZWn0TiFM+rcNoGnztLx/hM3A=;
        b=rHo9gDWWorQxDDT4uBYSE2DK6bJVOJKAwi0/F9Yz0aUCne4EDHqcsEunvhFeHeABMd
         816KQ0dXlx0YeB64qVgEvyXwYtGNpJ+pjTOO6QwiHSDxVqW+yS+2Gdtlew2edWoXGl6G
         Vi2ntF+MSo+xOPkX44rWSLQawEEjZlvrN5fjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x2u947HFT28BDPNAKaUivHEZn/aYJ0DBUq7zQqZhgxvQkHOnlR3bWwd5olISWHlrvO
         BgKjUN8C7Hh35q/Ze1YQmJZYKGH/Zj38NWoY/qXunZ2FW8m6MRcwUUOXJW5GvtmTnzj0
         5g6CtSQ2gm10gjOb4xD9MY2LOPrk7XsTFgGiM=
Received: by 10.224.2.141 with SMTP id 13mr4172944qaj.299.1236849131541; Thu, 
	12 Mar 2009 02:12:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903120956460.18527@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113025>

2009/3/12 Daniel Stenberg <daniel@haxx.se>:
> On Thu, 12 Mar 2009, Mike Ralphson wrote:
>
>> Elsewhere we seem to protect use of CURL_NETRC_OPTIONAL by checking for
>> LIBCURL_VERSION_NUM >= 0x070907. I have an ancient curl here
>> (curl-7.9.3-2ssl) which doesn't seem to have this option, so building next
>> is broken on AIX for me from this morning (c33976cb).
>>
>> Is there a specific minimum version of curl we want to continue
>> supporting?
>
> May I suggest perhaps require a libcurl version that is no older than three
> years or something like that?

It might be a plan 8-) Though I was thinking technically in terms of
features we think git needs. Though doubtless there are several
security fixes it would be beneficial to keep up to date with.

> (spoiler: libcurl 7.9.3 is more than seven years old!)

And still the release IBM package for AIX [1]. 8-(

The summary of automatic builds (http://curl.haxx.se/auto/) is very
nicely presented. Is that custom code?

Thanks for curl, even the old versions!

Mike

[1] http://www-03.ibm.com/systems/power/software/aix/linux/toolbox/alpha.html
