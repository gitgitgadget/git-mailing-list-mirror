From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 20:00:55 +0200
Message-ID: <483EEF57.6060304@gnu.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <alpine.DEB.1.00.0805291343120.13507@racer.site.net> <483EABD8.3050600@gnu.org> <alpine.DEB.1.00.0805291454270.13507@racer.site.net> <483EC079.1050008@gnu.org> <20080529175157.GB5596@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 20:02:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1mRg-0005a9-HN
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYE2SA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbYE2SA4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:00:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:46756 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYE2SA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:00:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2096832fgg.17
        for <git@vger.kernel.org>; Thu, 29 May 2008 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=bXo4x0lyldYzHxHy5sesAVxkx+CShL9Nr2v1deOmoJA=;
        b=toY90qFE/pnoUjBNdSKsLaEnem21Oyef2hjWZjNd4flAGNvj/CXWZJuvtTCblg9uuCLTYvobO5ouMoAllSRzXsfwxq7xdFHYywjMA1tgAoFrrG61KJP12LIn3ZO/UyeCyycYvSstB7laJjdHU48m86WUbMW4jIR9/kAFsP9UIfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=f+teJwReYynvFwZcchleL4dOlcUmuM1HiSels0oFP3i9vPqqVPsQakds0SkT3lf8f6AWq2yZjNsTy3KAXnQDH+N/aBpPNDqbX3p6z1YTHNJBkW5VeUyDjvt0k1BIRTSY9TaDP1f4wXRCSQVrUt3W11iE120DlNKobHW8m7o/ZpY=
Received: by 10.86.77.5 with SMTP id z5mr7482523fga.35.1212084054666;
        Thu, 29 May 2008 11:00:54 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l12sm873797fgb.8.2008.05.29.11.00.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 11:00:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080529175157.GB5596@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83228>


>> The "if() die ()" thingie is already in builtin-commit.c, so we won't  
>> ever get a pathspec in the "add --interactive" case.  If we do,  
>> something else has already been done incorrectly before -- not by the  
>> user but by the programmer.
> 
> What could that be?

Nothing, but it documents to whoever reads the code what is the path 
that will be taken.  Anyway if it happened it would be very bad.

Paolo
