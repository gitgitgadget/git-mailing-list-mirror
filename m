From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git-difftool
Date: Thu, 1 Jan 2009 15:38:38 +0800
Message-ID: <46dff0320812312338i5a3ee0cem702a6b67ef76e48c@mail.gmail.com>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jan 01 08:42:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIICT-0002HJ-3n
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 08:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbZAAHin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 02:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZAAHin
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 02:38:43 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:18525 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZAAHim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 02:38:42 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5546634rvb.1
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 23:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UzQ/TI3TnbfRVIvlXu2AwdwMJ3BNdgrzsaSqy1dejaM=;
        b=frxNGk2m8gQHycnC/We+s9MWYSp0fHtjqOThlB2CjGWZqlotc5POzCSG8Yq8pOxYx4
         G7wsG2h18kzvg1xnjI/p0OUzswSmHC68L8vqFsLAwLyE5oBLFoEJc1Tsl3y+17E7OAw3
         dWLWQQP4lAV/yaANiVpODaT+FVpJXOG2p02Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=so6GHpUgLj6iriytKtI+KYup9yuL1pRH/k06j9pJJ0zm0aVp7c0y2TWQTpnFeGeck+
         rQzUKKk03+9mb8loeqXs0rrY+xzngLQCO+xoVWUMbSQPfo+zT43yXd0pBB21t3UqAlD3
         hLDa3uXS0P3NfleAaSaCAlyRLvyFBlLC/VV5c=
Received: by 10.114.37.1 with SMTP id k1mr11009660wak.28.1230795518698;
        Wed, 31 Dec 2008 23:38:38 -0800 (PST)
Received: by 10.115.93.12 with HTTP; Wed, 31 Dec 2008 23:38:38 -0800 (PST)
In-Reply-To: <vpqhc4kz5zh.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104292>

On Thu, Jan 1, 2009 at 12:04 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> The usual use case for this script is when you have either
>> staged or unstaged changes and you'd like to see the changes
>> in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).
>>
>>       git difftool [<filename>*]
>
> Is it not a complex way of saying
>
>        GIT_EXTERNAL_DIFF=xxdiff git diff

$ cat mydiff
#!/bin/bash
exec vimdiff $2 $5

then i run

$ GIT_EXTERNAL_DIFF=mydiff  git diff

but it gives me the error
Vim: Warning: Output is not to a terminal

$ ps -ef | grep vimdiff
ping     20284 20283  1 15:37 pts/13   00:00:00 vimdiff
/tmp/.diff_XXXQK6 index.php
