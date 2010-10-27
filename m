From: Joshua Juran <jjuran@gmail.com>
Subject: Re: How do I get a list of all unmerged files?
Date: Wed, 27 Oct 2010 11:39:02 -0700
Message-ID: <DD284F82-88E1-44D8-B2B7-C11ED9F3F7DE@gmail.com>
References: <20101026143245.11433.qmail@science.horizon.com> <AANLkTi=JipA6P72hY5_FSvohCruf8hqsJc8Rh53FzAzT@mail.gmail.com> <4CC85AA2.1050406@nextest.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	George Spelvin <linux@horizon.com>, <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 20:39:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBAu4-0005vR-6p
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 20:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab0J0SjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 14:39:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54217 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0J0SjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 14:39:08 -0400
Received: by eye27 with SMTP id 27so955201eye.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=otBM8XIX8Yo1EoqwM24Cn0BLO+2HXp9+rqX8NxMpBwU=;
        b=YQUZBwm8MPSpq2wYXxvuIxXVBz1Cr1z4KspWN7zkCN8/rgP9etpvyx6fHPc7Q8UXwh
         jdMX3b6UzMdexkm/Y5SZEWVZ7ONxOaZoJAcbwAAkWev4moCibzRtGaiv+CSkUiff9xca
         2hsiK7pNAYS/T4jRQI995G722DvI4o+00LD4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=q8kxOKlb5Rt/ZlZv/S8YaXes5cV8DEBKcxZPdRkolsDmDS75Mu+lfDoh7W2Subcn0V
         5P7SFG6+No8Di8qhSerrAPkylSXcINw3CmlQGhVt2E2hI5IATqCHZHB0aWMK/QUKwNjQ
         piQGIQB8MLr/mMzt6moGSG6mQ5R/Z7YTrhOm4=
Received: by 10.213.16.84 with SMTP id n20mr1494809eba.0.1288204747332;
        Wed, 27 Oct 2010 11:39:07 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id y8sm42369vch.5.2010.10.27.11.39.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 11:39:05 -0700 (PDT)
In-Reply-To: <4CC85AA2.1050406@nextest.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160112>

On Oct 27, 2010, at 10:00 AM, Eric Raible wrote:

> On 11:59 AM, Jay Soffian wrote:
>> $ git help unmerged
>> `git unmerged' is aliased to `!git ls-files --unmerged | cut -f2 |  
>> uniq'
>>
>> If there's a better way to do it, I don't know what it is.
>
> How about: git diff --name-only | uniq

I use `git diff --stat`, via alias `git ds`.

Josh
