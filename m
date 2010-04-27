From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 14:18:54 -0700 (PDT)
Message-ID: <m3och4d27t.fsf@localhost.localdomain>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern>
	<4BD6ACEF.1040909@op5.se>
	<alpine.LFD.2.00.1004272111540.5630@bbs.intern>
	<4BD73F64.1070604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerhard Wiesinger <lists@wiesinger.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 27 23:19:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6sBW-0006BC-1N
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 23:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936Ab0D0VS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 17:18:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:36408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756879Ab0D0VS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 17:18:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2885487fgg.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=oVqL/EG337Z5QXcFa8t+dEF9xIkxHZXzKzElK7FlM9E=;
        b=ewmSCWKfGtZjUevDGWEUFQ2hNRPUWQyxDcWR7Sj55hAAAnj6uK5rhs3OMv/ANqP9Sw
         +Q3ZsYLnFQxL+73vTgRsFVo1FqboVIHzRrM7/bU5UVLfMdqM2T76kRH72E6lP6+OU+qs
         VvhodMiTzDIj/n4ULUyIPP1Ja4BukWmuTYRuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KRsHodkqZdKlrmokIXT0mr6V3C68kV/dAmo9VKEUEkwfYKPqg8G77XTaJvsN2/HfVO
         c37tdUUfzv+2jmnEDg4EI5G0fcM7cErpB1baepCNYCnbUO3shuB5hUC0VESHHkajjgvd
         0AZepx7Pq+s+/c17NtFeO6rdJm48e9fSXE6R4=
Received: by 10.87.35.20 with SMTP id n20mr3156340fgj.0.1272403134935;
        Tue, 27 Apr 2010 14:18:54 -0700 (PDT)
Received: from localhost.localdomain (abvy105.neoplus.adsl.tpnet.pl [83.8.222.105])
        by mx.google.com with ESMTPS id 22sm7993320fkr.59.2010.04.27.14.18.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 14:18:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3RLIK9Z032163;
	Tue, 27 Apr 2010 23:18:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3RLHxSY032159;
	Tue, 27 Apr 2010 23:17:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BD73F64.1070604@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145957>

Andreas Ericsson <ae@op5.se> writes:
> On 04/27/2010 09:38 PM, Gerhard Wiesinger wrote:
>> On Tue, 27 Apr 2010, Andreas Ericsson wrote:
>>> On 04/27/2010 07:23 AM, Gerhard Wiesinger wrote:
>>>>
>>>> I'm new to git and I'm looking for the following features:
>>>> 1.) Metadata for
>>>> a.) directory versioning (e.g. add/rm, mv)
>>>
>>> If you're talking about empty directories, that feature doesn't
>>> exist and I can't imagine why you'd want it to. If you'd care to
>>> explain why you want it, I'm sure we can find a different way of
>>> achieving your goal.
>> 
>> Git focuses on content but I think git should also focus on metadata. 
>> For example restructuring source code moves (git mv file1.c file2.c, git 
>> mv dir1 dir2) should be documented also in the repository like e.g. 
>> subversion and commercial SCM like clearcase do. Otherwise we are on 
>> "CVS" level.

"git mv file1.c file2.c" works in practice thanks to heuristic
similarity based rename detection that git uses.  (Note that it might
not work in simplistic tests.)

"git mv dir1 dir2" works via _file_ rename detection, except for one
use case, namely when on one branch one does "git mv dir1 dir2", 
and in other branch one does "git add dir1/file.c" (new file in old
directory name).  See also below.

>> Empty directories is a special case and sometimes you need just 
>> versioned empty directies.
> 
> This has been discussed to death several times before on this mailing
> list. Browse the archives. There haven't been any new arguments the
> last 14 times it came up, so I doubt you'll be able to come up with
> a single good reason to track file renames explicitly.

There are three issues conflated here:

1. Rename tracking.  This is no go.  The only idea that have hint of
   being perhaps possibly accepted is recording resolutions of
   tree-level conflict in git-rerere2 cache.

2. Wholesame directory rename detection.  Possible, there were even
   some proof of concept patches send to git mailing list, but it
   didn't get merged in.  Would need to be resurrected, but this is
   not easy task.

3. Support for versioning empty directories.  Possible, but it would
   require extending index (the staging area one) to be able to hold
   not only files but also directories.  Not very easy.

   Current workaround: empty .gitignore / .keepme files.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
