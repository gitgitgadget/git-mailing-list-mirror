From: Reynald Borer <reynald.borer@gmail.com>
Subject: Re: git-svn checksum mismatch
Date: Wed, 8 Dec 2010 16:17:01 +0100
Message-ID: <AANLkTimVyCndGZQLUnVM9CCQmDfOHYywcfzBAL2w0gbC@mail.gmail.com>
References: <AANLkTik0NBkjrPTzLp9ozMnnV+bng_u5Br1v+H4y6ed0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 16:17:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQLm4-0005pI-Ge
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab0LHPRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 10:17:22 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:54302 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab0LHPRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 10:17:22 -0500
Received: by iwn40 with SMTP id 40so1771295iwn.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 07:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=SKqKEWdvDW/rIHPO9gW5p/imPiKHOV3Xlud7J5hs4ZA=;
        b=wBWZ22lks1GqcRD4IL0mcC0O75GdYj4cmobydudn7Jl4DcyUPvoXEA/hsFoYvRH9NK
         8KeuWZTUuBCGelNnDQeMy1K5OKI9mv3iRV42hl4grmtMRZIKdHVHzdTD5qJ7hkLpM6w5
         UPHlIMk2FdcOGFmFX8VPI430Lza41E6t1HqIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=H0e1Nadi5iAVbDyNCkCFRi9UqVozFbZcob1KtbhtvNkt6JalBSv+8FbKPRBCyiTv1P
         u7c/ZG6c3mqF6UdZt2ZmCC9R6kt2nEz2qiOZN4/v/6cY5FXOBArGi+NPvTat/A6usYoT
         S8TQfCObW5bZKh2k5Rh49OXpPVWoQwneQGOtM=
Received: by 10.231.11.77 with SMTP id s13mr9374671ibs.33.1291821441418; Wed,
 08 Dec 2010 07:17:21 -0800 (PST)
Received: by 10.231.17.2 with HTTP; Wed, 8 Dec 2010 07:17:01 -0800 (PST)
In-Reply-To: <AANLkTik0NBkjrPTzLp9ozMnnV+bng_u5Br1v+H4y6ed0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163199>

Hi again,

Sorry to bother you again but I am still experiencing this problem. I
tried with a more up to date version of Git (version 1.7.3.2), and
this is still happening. I also tried to diagnose this issue but I am
completely lost.

I am very annoyed because this is preventing me using Git on all my
SVN repos (2 are failing on 30...)

Does anyone know how I could try to solve this issue?

Thanks very much in advance.

Regards,
Reynald

---------- Forwarded message ----------
From: Reynald Borer <reynald.borer@gmail.com>
Date: Wed, Dec 8, 2010 at 3:28 PM
Subject: git-svn checksum mismatch
To: git@vger.kernel.org


Hello all,

I'm using git with a subversion repository and am experiencing the
well known checksum mismatch problem when I try to fetch from our
repository:

r5289 = f110f54fc3a488639e8b645438c4538e7785228f (refs/remotes/trunk)
Checksum mismatch:
app/tnin/model/src/main/resources/etc/sql/migration_scripts/STX-12229.sql
expected: c70c72fe170781e3279c37d0de637a55
    got: f90d31e1fd8e0f88569f87eb087c06c9

I have already been trying to diagnose this issue and have found
nothing to fix it so far. I have tried to do a checkout with an svn
client of the revision 5289, the previous one and then do an update,
everything works fine when doing so.

The only thing I see that may cause this issue is that the file has
special svn property (eol-style=native).

I am using git version version 1.7.2.3 (using svn 1.6.13).

Thanks in advance for your help,
Reynald Borer
