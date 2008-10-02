From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Help with a tcl/tk gui thing..
Date: Thu, 2 Oct 2008 17:01:46 +0200
Message-ID: <237967ef0810020801o47a40f8ye832a02783b5f992@mail.gmail.com>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
	 <237967ef0810011403i2b18255and988df29a71798bf@mail.gmail.com>
	 <alpine.LFD.2.00.0810011605001.3341@nehalem.linux-foundation.org>
	 <237967ef0810012218i28d41573s6bb7866e0be485f2@mail.gmail.com>
	 <alpine.LFD.2.00.0810020746480.3341@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:04:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPhj-0007A1-KI
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbYJBPBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYJBPBt
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:01:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:62419 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbYJBPBs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:01:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so437209nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Nx1jc1p61Xp4pyVYY7V7JKakQMi4v7GX32E18GgPmbs=;
        b=RdlVFb8LAhJ0wYxeN4vY8kCqCk58/8xyNXbVkSFyf/n7iMtVIJBA2QyynyAeg3jTFA
         3JPkcYUYGX8ar1nt1hDMqyGQiZqWSA/EKr9CnQ0eo0edlQRa2roIfw2bq9ITuCBBdSkK
         kIWoIUNU0EFOpR5kfHXNMFhGFTRNiPwgOnuFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mTWCqubZJsmzTKXxU3YJuefNODfFXG75+pFjWf8nR14dtJfERJAIaWAGsV383wAUxn
         2wWJ6xZWc79syD69wYYosdREgMGSSQjtdPVTId95xUFA/W7mJLyvDa9P0I0xrgqeV3LU
         7f7PJh2SJJLT9BFYSSkgCCDSDeS5vcyun8YiU=
Received: by 10.210.126.5 with SMTP id y5mr5946514ebc.60.1222959706894;
        Thu, 02 Oct 2008 08:01:46 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Thu, 2 Oct 2008 08:01:46 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810020746480.3341@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97349>

2008/10/2 Linus Torvalds <torvalds@linux-foundation.org>:
>
>
> On Thu, 2 Oct 2008, Mikael Magnusson wrote:
>>
>> Heh, sorry, I'm an idiot. I forgot to put '#!/usr/bin/python' on the first
>> line. I was running 'python tracker-ui.py' then did chmod +x just before
>> committing :). So the cross is coming from running 'import time'.
>
> Ahh. It did _something_, so I assumed it was working, just not well. Being
> confused about the language would do it ;)
>
> I fixed it up and merged it as an alternate UI. It doesn't react well to a
> tracker file that has just been initialized with the timeout (but without
> any of the extra information that gets filled out once you actually start
> getting tracked), but it's certainly prettier than my original one.

Ah, I didn't play around too much with the actual server part, but I guess
that would get sort of annoying, so I pushed a fix for that, and also it
now sets the window title right.

I should also note that I'm not exactly a python master, so if it looks ugly,
blame me, not python :).

-- 
Mikael Magnusson
