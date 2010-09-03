From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH] Add unit test for check_cherry_pick
Date: Fri, 3 Sep 2010 15:26:09 -0400
Message-ID: <AANLkTik5kcD1reuGfq4k_Oidkx00MY8E+Ucf+Ef_gCDD@mail.gmail.com>
References: <AANLkTikuY28wwccxekDXD1WGtaOoF3JG7ZBfm6vjapwt@mail.gmail.com>
	<1283539935-14672-1-git-send-email-stevenrwalter@gmail.com>
	<AANLkTikjGgzOxNz-Fepcg2ALqdWurzMyQUmRgqyxQN5L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 21:26:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orbu2-0002bY-3S
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757275Ab0ICT0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 15:26:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40292 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329Ab0ICT0L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 15:26:11 -0400
Received: by bwz11 with SMTP id 11so1812358bwz.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nfXq5IUbWr2Qf9KG2QjSMJAjO+BfCa7ZGkA3a7yStSc=;
        b=bfl3gNkAH3pGMKjV3S7KtftZywaKlII6fQNtFUyzk6IWng7tZsJRDz4CuiMKGc3Q1c
         ePULRxxIZpuRl0y/FUPBRpzBm27DjiIjeOYLaLKHPT4XuKUwvBPsXsBDW5LBxvXDgilW
         8XV1J0M8W1IKX4MLZiFtw0ATYJVhie4f4MzVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Tj00l3OfeU81I3Xab1sKGwD843xJik8HBq4yn84+DS9MznORHZeKeuM2oxDfYVDHwb
         +L7G3iJFky2qzRlmsPfP4egECV82bOOWNMQES9A3LCKO2z7T/CxlOHjdwCb5q0emHiGy
         /4JEgXGTfGo6FnGe7xCvm9WI3ouFUSGqjTYuI=
Received: by 10.204.71.139 with SMTP id h11mr198542bkj.135.1283541969855; Fri,
 03 Sep 2010 12:26:09 -0700 (PDT)
Received: by 10.204.52.4 with HTTP; Fri, 3 Sep 2010 12:26:09 -0700 (PDT)
In-Reply-To: <AANLkTikjGgzOxNz-Fepcg2ALqdWurzMyQUmRgqyxQN5L@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155265>

On Fri, Sep 3, 2010 at 3:12 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Sep 3, 2010 at 18:52, Steven Walter <stevenrwalter@gmail.com>=
 wrote:
>
>> +GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
>
> What's this about?
>
>> +. ./lib-git-svn.sh
>> +
>> +say 'define NO_SVN_TESTS to skip git svn tests'
>> +
>> +case "$GIT_SVN_LC_ALL" in
>> +*.UTF-8)
>> + =A0 =A0 =A0 test_set_prereq UTF8
>
> You never use this prereq?

I'll admit that I copied these from t9100.  I assumed they were
necessary for correct operation.  If that's not the case, then they
can be removed.
--=20
-Steven Walter <stevenrwalter@gmail.com>
