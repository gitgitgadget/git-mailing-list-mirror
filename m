From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:10:30 +0100
Message-ID: <200704171810.31797.andyparkins@gmail.com>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 19:11:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdrDG-0002BP-Dg
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbXDQRKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbXDQRKs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:10:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:36963 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160999AbXDQRKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:10:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2111623wxd
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 10:10:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=du8zpABM/ezgW8DqMlmXNNECTPU0KHTnTx2V4Q+dLSVbmfojMxnmKSrHzYnq7Z9oltPk7O6eb15dsi+BOSmVQgiZ3pKsNSdCdYBJnw9k6dpGPfuFSeS/hjPZoHi4TX3H/sjXRnEPTVjXPbe+xctyACtABrk9V6ZbjGFHB6aXTdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dxHd8pGRkTmBhaU3j3TMazleHpX9wScTZbIb9UWYumbFU81BQI23s8KpIPtrntTpB4aMzapJ1/+CA2r9PtkCgLjREcECUFjws9fZRKjOj6U2Zl5Yy7pEk3yeTJ9qW2kBorXp4dBcwdvI8oPH/OTU3KAz8CeMyQrq41yIxu7u5UE=
Received: by 10.66.242.5 with SMTP id p5mr597979ugh.1176829844735;
        Tue, 17 Apr 2007 10:10:44 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm1385330ugf.2007.04.17.10.10.43;
        Tue, 17 Apr 2007 10:10:43 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44802>

On Tuesday 2007, April 17, Linus Torvalds wrote:

> And think what we do about files (and whole subdirectories!) that
> haven't even changed. And finally, think about how important that
> optimization is in an SCM like git that supports branches.
>
> I think you'll find that keyword expansion simply isn't acceptable.

As I said in my reply to Junio; other VCSs only expand keywords when the 
file itself is checked out - when git's uber-fast switching decides 
that fileA is the same in the source and target checkouts, then the 
keywords won't be updated - fine.

In this one respect git would be "as good as" instead of "infinitely 
better".  I can live with that.

> But hey, you didn't believe me, so I'm happy you are trying to write
> the patches. Either you'll prove me wrong, or you'll realize just
> *how* broken the feature is.

Could be - I'm happy to disagree.  I'm even happy to accept that I might 
fail miserably.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
