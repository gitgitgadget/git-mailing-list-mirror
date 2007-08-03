From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 07:48:47 -0400
Message-ID: <fcaeb9bf0708030448id1d961dv58264da335526aad@mail.gmail.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
	 <46B2D547.6050406@trolltech.com>
	 <fcaeb9bf0708030417y39f84db2lb0b202af57d8fccb@mail.gmail.com>
	 <Pine.LNX.4.64.0708031224530.14781@racer.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_67814_7529905.1186141727695"
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 13:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGveH-0008WM-Ax
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 13:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759804AbXHCLsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 07:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758268AbXHCLsu
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 07:48:50 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:29577 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092AbXHCLst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 07:48:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so154329and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 04:48:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=I8QMOUvDsFtQGXw/Inm8gb/ao/i5XiDHWctWbfESwSLLT0utDYz/wsgSyXr4FcETQCo/8p3xYz7c82EBr3dHxQTiGEgQ16MeuZL5qg6brsS13IuuWPE0nBW3narykqClrFee+RXJfqrBbw/s6Btm8C64aCWH1WARfWOlXV67P8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Dlokb11EPGCvF4DCDFKOREy+/NT9YcJJXU+iK1rYPjSMq4jEPP+s37aJ0XBjdPlEpcnPLVhDela310M9l9gcS3yhALxAYQKa6naLJLQyyc9yy0PV8o2Pg1wn+ZrkOoIHlCCUNa0/jobBWmMtlvIZ2ggH4e1Y0hrFEZl1bEHKDZs=
Received: by 10.100.31.2 with SMTP id e2mr1656111ane.1186141728472;
        Fri, 03 Aug 2007 04:48:48 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 04:48:47 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708031224530.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54709>

------=_Part_67814_7529905.1186141727695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/3/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 3 Aug 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > > > I finally broke down, waiting for the sourceforge project to get
> > > > granted. In the meantime, I registered a project at
> > > >
> > > > http://code.google.com/p/msysgit/
> > > >
> > > > (WARNING: temporary only!)
> > > >
> > > > Would you believe that Google code has a restriction to 20MB per
> > > > file, and 100MB in total, and you cannot remove files?  The same
> > > > Google that gives you 1TB mail space and counting?  Yes, it is
> > > > ludicrous.
> > > >
> > > > Anyway, you can get a complete Development environment in 3 files
> > > > (because one would be too large), and... oh well, just read what is
> > > > written on the website if you're really interested.
> > >
> > > Great effort Johannes!
> > > The package work perfectly on XP.
> > > I'm trying to get it to work under Wine, but it (Wine) is not playing
> > > nice with me at the moment. (The whole system barfs of "Access Denied"
> > > and other things. Grrr)
> >
> > Even if it installs ok under Wine, git may not work properly because a
> > bug in dup2() not duplicating to 0-2 and some others that I think only
> > affect tests. So get XP if you can or prepare to fix Wine along the
> > way.
>
> I do not have XP.  So I very much would appreciate any work done on Wine.
>
> As it happens, I have a hanging rxvt now (still investigating what causes
> it; ever since wine-0.9.30-466-gb0e9d7e it stopped working for me).

I attached what I did with Wine until now. You probably only need
patch 2 but if you are going to test gitbox, you'll need patch 1 as
well. It is based on wine-0.9.41-313-gd0b21ab. With these patches, I
can run git tests under Wine.
Ah, and if you want to run tests under Wine, beware that setting TZ in
scripts has no effect. You have to set TZ before running wine.

>
> Ciao,
> Dscho
>
>


-- 
Duy

------=_Part_67814_7529905.1186141727695
Content-Type: application/x-gzip; name=wine-for-git.tar.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4wlyi4h
Content-Disposition: attachment; filename="wine-for-git.tar.gz"

H4sIAMUUs0YAA+1XbW/bNhDOZ/2Ka4G1dmwqpKw3u/PSNE6RDEk2JNlaYBsMiqRsbbLk6SUvXbvf
vqMkt86StB26thuqBwYo3pFH+u74HEkpZWSmCnEhyfEPh4eEknyelrEkPI5TwQtFeCJJpooySwgn
ibogQRmG5pIXYr7xXqAI17Z1yzyHVn1W95tPusGo69gusyzb2aDWYMAGG0Dfz/yHocwLngFsLEWc
ljJ/yziV3a393+Jpli7Acn0ZcCqEG0oqA9cRzKFCDZQUTHp2OHRcy5K+hKM0gVO1BOYBpaPqBxZG
0NBmRjDeLouQ+Nu/bx/PyqvxHhs/eTL2nWRs0bP5eHcw3mERfh/PVqqJwO6kvNoew9dNAB7PFjyK
TZEuvjEmmH4jeKZkHywHvi1jvZgHbDhy6MjxgFCbUuO0DH5VohjBT9/vnO3u/wJ1Ond0OvdpF+p8
hlU+A+Yz1PkMHDCfQeezygzjbK5AlFmmkmJlowtpEl+9npuvjYcohDx6oSDKIVZ5DsWcJ8YLlaUm
HDQq3dP6WXSukj5ERbNwDnpzpkEIMUDGcb61yM9FVmzJKDMFvASEBT1UMggjtA4Cjc+0IxhECaZi
EaVJ3ul1tUCqWNV90jUMGYUhEDLDxfjWTdvBTZkRJVJdAh47S9jSNAWGejhgwKpjqzd5myWj1+vd
au3xYyA2G/Y96NUNCnD72SbsTvZ2D2Ha+FbLYFN7Ez2DLtce6xpg4H9H13buoaKrO38YBBpZ5dSv
gXaN3nXRWMugRhPbaV5kslx2cFPdR8a6pt6t1ifNgH61djXqFf5fMJjpmJZpGcbnPp8fG8i/FjnL
FC+ITjSCaSYx37AMMGIRnpMyL3n8T9j+1jXeyv+W41znf+a5OKzl/0+Aiv/50PGpzylWAMbU0BNe
EAx9dzh0HHsgQsf3LJsNPPZ5+P9pFiH/e9f432Yjat/F/1U6V7wJTToD7bO+BTyHKp2Nm8SrR380
5m2MB7cIG+71qRMIxzFNX7jCDwd3c28z7Sb5NgrNvsynmn3rBgWY4kUk4DyN5Ir8wkypaSg7mnhD
2XCn4LkCa4QhLk4LuV/5rnN6NpnunZx8dzLd3zmeHO71oSpe3UcQoJ9/a6j1VcOdACrOlabnrU39
tblVUzis+DqUMB7D0emPuydnuAGFxZgAe03e6wpCHn1ZZPwZgPw7IJMo5wGSf54u9HU/Sa+iZEYu
eJZgm38Y+W+8k/+tgfs3/sdTPrBb/v8UqPjfdj0fr/6hCJTFhtwK7YHyHRZ4ggeMOa7vBEwObf8/
xf+WdRf/N+kMOp1hlc6wSue7yR+xxv/rA5ZZKvCKvyoQDFBvvbM+WP9ifajLgmlSJHXJ1QfWB9se
VAWiblGky0B9O28IeJqnS5V0QODmC6iv6sgD8/qqnoYxn+XNtX3edEzThIbHz/kU+bvDl/pOveL+
znKRSgUP4M/OapHT6cHJ3s4EvbomeXZycLbX7da3foCnB8+P9jr3R1BPp5dfUfsSolmSZkr+nNzv
1wpcqVdPYE1JqgpRU1ae7Zwcv5cNuDtKb5IguF3exEp4NHBDzzQtXw68YHh3rN7MvBmuN7rqPeVV
FV03ro5X4y70/7LIpqvYTfMlv0jOVV3V66i8CeAmJHyhrkuq703g2k9bm7pAJymoy0IlOabt2tOV
53mJp8lUlwrqmo4Bhc4SX2PaKrx8ifkB98bw0HzYhQcP8Emc6GfZ0c7zKR7LfSzyDqw/55qwVs/r
IqtOaGX8Yo4Tr22i2gEGafWKW6iFWF51wjKO9dK9WO/vvp6McbRXo/T6vTHYX+KjrkWLFi1atGjR
okWLFi1atGjRokWLFi0QfwF6oNthACgAAA==
------=_Part_67814_7529905.1186141727695--
