From: Miguel Ramos <mail@miguel.ramos.name>
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 12:39:57 +0100
Message-ID: <y2y3e2876431004170439o15fbe62dv612157226d978fa5@mail.gmail.com>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
	 <m3zl12eaif.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 13:40:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O36Nz-0006yo-Kv
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 13:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab0DQLkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 07:40:01 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:40063 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab0DQLkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 07:40:00 -0400
Received: by qyk34 with SMTP id 34so4242901qyk.22
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=JRrrRep2IiS0Y4939rbnUJh93pZt9Mm3VAIKPu9KUmM=;
        b=rWzWsym0+u5A3T3zZagYEViGW3+Voyx8DHtFnm52IuIuUw5C/goM06MUd1rjd2ddJX
         zTIVijk82Iu0IaXu8UUOr7dCWh2W0pL9wip5s/3aQ1kUJ9Qw5obcuAAZ/PAM2CVmgQcY
         SM6MZUM5L1HPdyO2h1Vz2oUj4YNQ8ES/09R8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=V7E7S3YF9S3uHKhU9W+KEeLKnIx4S0QFrA8hWjfuteeEpj3LUv9jppO4pHCA8HK4Bc
         c5++Nz/cvqjyXjQtsgMSTloeHTnsM9kb0sweoZcr4OmbKGPLsVOUptb8Sxv97PAXpMZW
         1LkLEBbsksYDyvnDeUakcp52MH+taZxjqVhPk=
Received: by 10.229.90.199 with HTTP; Sat, 17 Apr 2010 04:39:57 -0700 (PDT)
In-Reply-To: <m3zl12eaif.fsf@localhost.localdomain>
X-Google-Sender-Auth: b243c505df54e342
Received: by 10.229.190.133 with SMTP id di5mr1405241qcb.23.1271504397687; 
	Sat, 17 Apr 2010 04:39:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145137>

2010/4/17 Jakub Narebski <jnareb@gmail.com>:
> Miguel Ramos <mail@miguel.ramos.name> writes:
>
>> Is it possible with git to use a git repository on the root directory?
>> I'm trying to replace subversion doing this.
>> I have a populated repository elsewhere, I can clone this to an empty
>> directory and then move .git to / to work around the demand that the
>> target directory is empty and at the same time avoid overwriting
>> files.
>> I used this method before to get my home directory versioned with
>> success, so far.
>>
>> When I'm on the root directory, things seem to work minimally. I do
>> git status, etc, and get the expected results.
>> However, if I change say to /etc, or any other directory, for that
>> matter, then git status tells me that every file in the repository is
>> deleted.
>> Adding files doesn't work, nothing works at all.
>>
>> I know this is an unforeseen use of git, however, unforeseen might not
>> imply forbidden.
>> I'm pretty disappointed I couldn't get it working.
>
> The 'nd/root-git' branch (merged into 'master' as v1.7.1-rc0~89)
> might have addressed the issue you are seeing.
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git

Yes, that's exactly it.
I tried out v1.7.1-rc1 and it works.

Good thing this got merged into the main branch.
I'm putting * in /.git/info/exclude, so adding files to the repository
must be explicit.
It seems to work, but if anyone knows of any downside to doing this,
please tell me, I'm new to git.

Thanks

-- 
Miguel Ramos <mail@miguel.ramos.name>
PGP A006A14C
