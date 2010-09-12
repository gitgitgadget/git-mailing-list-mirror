From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: please show tags file history browsing
Date: Sun, 12 Sep 2010 20:20:09 +0200
Message-ID: <201009122020.11556.jnareb@gmail.com>
References: <000001cb51be$ed214dd0$c763e970$@se> <201009121719.32390.jnareb@gmail.com> <001201cb5295$5c055850$141008f0$@se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tjernlund" <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Sun Sep 12 20:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OurAC-000762-LF
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 20:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0ILSUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 14:20:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65235 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab0ILSUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 14:20:22 -0400
Received: by fxm16 with SMTP id 16so2744135fxm.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hZv0r2Kd/Z7Dy88/u9n/2y6EnefnK/89re+8ArBpA08=;
        b=mnwiuSGZNEE8WlG7Lc9+bi/E+t8f1SlyHcNIz4aGnza38yrGJu5kGrVBYNv7lWR8sg
         Djg8h9NisL2Ei1qEd4rxnPimCFrzCqWUnOWH4sdD/y/6ZoVYscXkKwCMh1GrU5JGaUHQ
         tE8Xpl3VubgTdhj+W8gNWPkPpPIv0UNi+r3Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vx1Ufr845aA281VaL46ZcIPD3dryI3oQYbzq87p3Q91SoDa7oQ5wa600vKb77utFsn
         AvNv0wkFll9BH5H9tL7xwd9WJ3DO7dIQnT1QMoX3ETgw5TA7Pe36yQy23uQW3YIk38FA
         28hPJlXO54h9bGvbdFqUUglnlZm2zxYhEnyDc=
Received: by 10.223.114.72 with SMTP id d8mr2466837faq.83.1284315620943;
        Sun, 12 Sep 2010 11:20:20 -0700 (PDT)
Received: from [192.168.1.13] (abwi198.neoplus.adsl.tpnet.pl [83.8.232.198])
        by mx.google.com with ESMTPS id r5sm2417552faq.8.2010.09.12.11.20.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 11:20:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <001201cb5295$5c055850$141008f0$@se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156042>

Tjernlund wrote:
>> On Sun, 12 Sep 2010, Tjernlund wrote:
>>>> From: Jakub Narebski [mailto:jnareb@gmail.com]
>>>> On Sun, 12 Sep 2010, Tjernlund wrote:
>>>>>> From: Jakub Narebski [mailto:jnareb@gmail.com]

>>>>>> While it probably be possible to show tags in 'history' view, it would
>>>>>> be not easy.  The problem is that 'history' view shows only commits
>>>>>> that touch specified file or directory, and tagged commits usually do
>>>>>> not touch those files (at least if one is using "bump version number"
>>>>>> commits to tag them).
>>>>>>
>>>>>> So you would have:
>>>>>> 1. Design where to show those tags - they would be between shown
>>>>>>    commits.
>>>>>> 2. Create code which shows some/all tags that are between commits in
>>>>>>    the presence of nonlinear history, without affecting performance
>>>>>>    too badly.
>>>>>
>>>>> Ah, that is too bad because I think it would really useful.
>>>>> Image browsing a drivers history in the linux kernel. Then it would be
>>>>> really nice to see what changes/bug fixes went into what release.
>>>>
>>>> First, you can help with the first issue even if you can't help with
>>>> the coding itself.
>>>
>>> I like the gitk way of showing tags, won't that work in gitweb too?
>> 
>> Err... "gitk" shows tags, but so does 'shortlog' and 'log' view in
>> gitweb.  The 'history' view in gitweb doesn't show intermediate tags,
>> but neither does "gitk -- <path>".
> 
> I know, I just meant the yellow note with tag name in it, how tags
> are displayed. When they are display is another matter :)

When those yellow notes with tag name are displayed beside commit
subject it means that this commit is referenced by given tag (i.e.
<this tag>^{commit} = <this commit>).

We have to distinguish situation where tag is between commits, and
tag points to commit.

-- 
Jakub Narebski
Poland
