From: Dotan Barak <dotanba@gmail.com>
Subject: Re: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 16:34:30 +0300
Message-ID: <2f3bf9a60906150634p18e67e71q6e5e7cbb8df1d8c4@mail.gmail.com>
References: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
	 <4A363741.9030604@nokia.com>
	 <2f3bf9a60906150503p69e992b4m18bdc2cc842b933e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 15:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGCKd-0001n5-R8
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 15:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbZFONea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 09:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZFONe3
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 09:34:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:17513 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbZFONe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 09:34:29 -0400
Received: by fg-out-1718.google.com with SMTP id d23so390567fga.17
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DOyWza5y84spmIiqFaDn1/7CLBlFPGXGI/gVof1fxnI=;
        b=aqSopRo9EkNsn42IwUCLgksu9H6v+S5GGVrxZcjuk+awrq0ESGtWiDqNN4QTsN3C6/
         VChyJ0dHHHJbd+JkadtRayyNwwgTcCQQYaCkYQSfbGjeL2Mwjho7EuPV/9lThjfzmcCm
         M3nOkoGAMNJhPFLT7dE4z8dhY8TWHE3cQSyLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E+AnAXaLRvNv3lE4xVuEb1ZUUXaU57CmkGj8ty6My6R0bmWT7w+D9I4CjjAbmlRLY9
         zUduateyPPqwbSJr/j+xD3L+NKwZTi8eeU1GG79ZTpQNQKM1rLzTTSZlq1DxG6stpnrY
         eVdlY+t1KI+W0IGc1e25mlg1MeIhsudxUH0Bs=
Received: by 10.86.23.20 with SMTP id 20mr6630565fgw.49.1245072870720; Mon, 15 
	Jun 2009 06:34:30 -0700 (PDT)
In-Reply-To: <2f3bf9a60906150503p69e992b4m18bdc2cc842b933e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121607>

Thanks, your suggestion helped, but there is one problem:

I noticed that if there is only one branch, the entry
branch.<branch_name>.merge doesn't exist.
Even if there is more than one remote URLs.


Dotan

On Mon, Jun 15, 2009 at 3:03 PM, Dotan Barak<dotanba@gmail.com> wrote:
> Thank you very much for a quick and exact answer
> :)
>
> Dotan
>
>
> On Mon, Jun 15, 2009 at 2:57 PM, Kristian Amlie<kristian.amlie@nokia.com> wrote:
>> ext Dotan Barak wrote:
>>> Hi.
>>>
>>> Is it possible to find the origin of a branch?
>>> (the remote repository that this branch was cloned and checked out from)
>>
>> git config -l
>>
>> Assuming you're on the master branch, branch.master.remote and
>> branch.master.merge will tell you which remote and which branch you are
>> tracking. Assuming that the remote is origin, you can check
>> remote.origin.url to see the URL of the repo.
>>
>> --
>> Kristian
>>
>
