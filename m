From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull suggestion
Date: Thu, 8 Apr 2010 23:06:42 -0400
Message-ID: <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com> 
	<201004081754.24954.trast@student.ethz.ch> <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com> 
	<20100408231154.GB13704@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git list <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Apr 09 05:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O04Yp-0003XI-2R
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 05:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab0DIDHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 23:07:06 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38545 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0DIDHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 23:07:04 -0400
Received: by wwi17 with SMTP id 17so630732wwi.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=mSY38yDaW1YUx5XJbYEHJ/C2ctT2RKtRKj4DQ+mteWs=;
        b=p2hjmjJODVfnIq4W3VAfDCZ7Uyfyt5fnffae6Jf4RdwN3FK4Z8kKel9aIKC6E6ky7O
         3FVMmldcERHLNJ2pwpHUfRs58nd4VWHtohfvOI27bnyGhseUamH6Yk0CBa5+1eBM2vbC
         ngX6IhWN/+SZbcMCqivfsb2M7EzClDf8KjIWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=j+qjwBgpn5kIDYvnC/h82zWbvTJJHE18T1eiKVDI6Py1cDJfBpw1Zv68FX8SjJvkN6
         97Dr0KKPfJN3w3yy4JSRpczFMwRDh6SdssbV92viQHu12VwVv0919wv4s/rqvxHAMnqV
         7aKSEjQiw5nc4M7lLaaanL0yduMzAp6KgpcGI=
Received: by 10.216.170.8 with HTTP; Thu, 8 Apr 2010 20:06:42 -0700 (PDT)
In-Reply-To: <20100408231154.GB13704@vidovic>
Received: by 10.216.89.211 with SMTP id c61mr543073wef.86.1270782422106; Thu, 
	08 Apr 2010 20:07:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144391>

Nicolas wrote:
>>
>> Sorry, my explanation was not clear. I am talking about changes in the
>> working directory that are not in the index. So my working directory is
>> "dirty" and I just issue a 'git pull'. Because some files are not "up to date"
>> git would abort the pull, saying that a certain file is not "up to date".
>> So I was suggesting to list all the "problematic" files in one go instead.
>
> Doesn't 'git status' ouput what you want ? Or am I out of the scope ?
>

Kind of ! 'git status' will effectively tell you what files are modified but not
in the index. The problem is that there is no way to know what files are
in potential conflict with what is coming from 'git pull'. So basically, you can
have as many dirty files as you want in your working directory as long as
they are not conflicting with what's coming.
If dirty files are in conflict, then 'git pull' will complain, but slowly ... :)

Another way of looking at it: do we have a command to know if some files
that are _not_ in the index are in a conflict with some upstream repository.
I guess this would imply fetching and then doing some work but I am not a
git expert, not by a  stretch of the word!

  -- aghiles
