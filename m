From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: Re: git svn clone failure
Date: Sun, 29 Mar 2009 01:16:55 +1100
Message-ID: <F76E6356-60EB-4FDE-B97E-CB34FF2D7017@gmail.com>
References: <A5DCF978-5D10-4A6C-BE4B-1024FA475E2F@gmail.com> <200903281359.34412.markus.heidelberg@web.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Mar 28 15:19:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnZNE-0006Ai-Tm
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 15:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbZC1OR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 10:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbZC1OR3
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 10:17:29 -0400
Received: from ti-out-0910.google.com ([209.85.142.188]:13144 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbZC1OR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 10:17:28 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1134505tid.23
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=1bTgHV7N7OKiDjJIL7FFBevMCG4SuhEue9v7npa3FXE=;
        b=uNDMTkliKT0wQae3WlyqKy2ZdPw4jidtbfhidGhQvHsfXZKPsSqhlDh1gsOlhmHxgl
         McH8eDezwk6aAVoMRGNtNXVnyNyCQbzArcNn6NTyB6FU4Q5HIo+k/3rPteACql4EPUm/
         paOKRD9ByfFWEWHZF9KfmeSXEVNBNtTcFNKI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=TAkxmdjBWDgFmbKJRObvehP9IY6D8Fe6Ud3EWx7AWjw1ekMSPE+NXJKriSzBt5e/39
         5gc8cHToagamZeuUgdHxkOwaQfgCsMuUpwL1D0T7J5pk18Qbwu0MlkBxu2/206LXDgfN
         MhtErZqDOTSO46wh1j7HfvDgLVlKtMtVSIpzI=
Received: by 10.110.39.20 with SMTP id m20mr4706879tim.59.1238249844212;
        Sat, 28 Mar 2009 07:17:24 -0700 (PDT)
Received: from ?10.0.1.200? (208.198.233.220.exetel.com.au [220.233.198.208])
        by mx.google.com with ESMTPS id u12sm1304519tia.18.2009.03.28.07.17.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 07:17:16 -0700 (PDT)
In-Reply-To: <200903281359.34412.markus.heidelberg@web.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114957>

On 28/03/2009, at 11:59 PM, Markus Heidelberg wrote:

> Lachlan Deck, 27.03.2009:
>> Hi there,
>>
>> I'm trying to clone an existing svn repository with git (just getting
>> started with git) and it keeps failing with:
>> ...
>> r604 = 6428e63734a21ee5fcb4593274747e2758578a91 (git-svn)
>> fatal: unable to run 'git-svn'
>
> Are you sure r604 isn't the latest svn revision?

A few thousand out, yes.

> I always get this error when doing "git svn fetch" with an http URL,  
> it
> doesn't occur with an svn URL. But everything seems to work fine,
> though.

Interesting. Yes, it's from an https url. I'll try svn+ssh://..
But are you saying there's no way to get more info about the error?

Thanks

with regards,
--

Lachlan Deck
