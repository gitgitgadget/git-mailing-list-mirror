From: John Tapsell <johnflux@gmail.com>
Subject: Re: git merge --abort
Date: Fri, 20 Feb 2009 08:42:34 +0000
Message-ID: <43d8ce650902200042y13caa60dtcc55d8069d90ee4d@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <7v63j6n16s.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902190534j49e24f86k9b716190ae3d134b@mail.gmail.com>
	 <76718490902191226k7b87f478p9a79b9b2372b464d@mail.gmail.com>
	 <43d8ce650902192047g383a5cc1re6697e8009ad72fc@mail.gmail.com>
	 <7v7i3lk7dp.fsf@gitster.siamese.dyndns.org>
	 <43d8ce650902200013q4aca6b2na27092e0825f969a@mail.gmail.com>
	 <7vljs1fqxn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQzg-0000B2-H9
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757914AbZBTImi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbZBTImh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:42:37 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:53424 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbZBTImg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:42:36 -0500
Received: by el-out-1112.google.com with SMTP id b25so419594elf.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=iFozlG3R2z4gnAbA5p6NUfVELKRLrFjhhl6UHvUoKpk=;
        b=jRMMPK/rtH+8UpmtQdwmIyPtXTg8CShQVD1rqDSH4J9s6Y+7L3V7HOm7+Drn2BvmD6
         FfyG7MUJQ3/kecF7+Vxa5+5+MjuAq0MFmFjudmyZaYqodUPl+9vxBACTS3lI4zVdVtV3
         C5OxrI3hlXHF+jpkohGaoeLeJyyC27iYl5b/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=rigyX8bUj0s1Da1VXd+dtodl1ZYSBxs8lWYZlKsnNkdhp+inQIQGKEUW2HlgLTFlQK
         Qb4Yx5avKFgql/cRcYqCY1lh7/Wdy025MQdPTmwWAzB2Lm3F5uXip642YqwSUu8Ctg7p
         gQ0ssQjzRcGSzoxS4/lZ+FippCtgGLS49P5c4=
Received: by 10.151.150.13 with SMTP id c13mr1839549ybo.63.1235119354832; Fri, 
	20 Feb 2009 00:42:34 -0800 (PST)
In-Reply-To: <7vljs1fqxn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110821>

2009/2/20 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
>
>> 2009/2/20 Junio C Hamano <gitster@pobox.com>:
>> <snip>
>>>    $ edit ;# unrelated local changes are still here
>>>    $ git pull ;# or merge or whatever
>>>    ... oops, large conflict ...
>>>    ... look and see if it can easily be resolved ...
>>>    ... otherwise
>>>    $ git merge --abort
>>
>> Can I just confirm - at this stage, "git merge --abort" would be a
>> "git reset --hard HEAD" ?
>
> Not at all.  Please re-read my previous message that begins with "Not at all".

Doh sorry.  Yeah it has to be that long algorithm that you outlined.
Can it be done with a series of currently existing commands?  Can I
persuade someone else to implement it ? :-)

John
