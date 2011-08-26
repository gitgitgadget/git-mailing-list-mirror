From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 23:58:50 -0400
Message-ID: <4E5719FA.9060603@sunshineco.com>
References: <20110825204047.GA9948@sigill.intra.peff.net> <5qgbkjmEZ8jSRkpVNieElg1bcVbuEStD525CFu1hZPQ7F03R3EzjXwQdDKQBOnR1zWDiZBsGu53K20rbOGpYd6rmp2-e-ZI3Z42BKT01TVI@cipher.nrlssc.navy.mil> <20110826024533.GB17625@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 05:58:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwnZK-0003JS-QI
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 05:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab1HZD6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 23:58:54 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57730 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab1HZD6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 23:58:53 -0400
Received: by qyk34 with SMTP id 34so1978079qyk.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fuqU/m6QmZXs+yucCZpiskQyjsBn8NY2Z84ViBFaR1A=;
        b=JqqL+gHt2JchgFeMg6PXI3PEKDDbC6wWj5FgIL4H9AB0IYHxnCGAOc5xrkl5pLmUoS
         NEAuul5a52DkAsz2KbGxFPNRZ9sq1z/Mkk8B98FYWKURguNsqNn0B5C80FTNKVt/rz+1
         unCb49fO42MuCeZoE2eT0J0rv1ws4td78L4o4=
Received: by 10.229.46.142 with SMTP id j14mr752398qcf.263.1314331132709;
        Thu, 25 Aug 2011 20:58:52 -0700 (PDT)
Received: from [192.168.1.3] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id f17sm1031658qct.18.2011.08.25.20.58.51
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Aug 2011 20:58:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <20110826024533.GB17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180150>

On 08/25/2011 10:45 PM, Jeff King wrote:
> Should all of our matches be case-insensitive? That is, should we be
> matching both .HTML and .html? Clearly lowercase is the One True Way,
> but I don't know what kind of junk people with case-insensitive
> filesystems have, or whether we should even worry about it.

In the Windows world, uppercase extensions are common. Also, one often 
finds .htm on Windows rather than .html.

Speaking of other platforms, on Mac OS X:

Objective-C is .m
Objective-C++ is .mm (and long-deprecated .M is probably not relevant)

-- ES
