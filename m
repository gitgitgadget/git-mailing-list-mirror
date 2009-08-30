From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [msysGit] Re: Using VC build git (split patch)
Date: Sun, 30 Aug 2009 17:24:58 -0300
Message-ID: <a4c8a6d00908301324o25d1cb48u12b527ea68e43680@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <4A899FDB.8080308@gmail.com>
	 <1976ea660908171807x22f4b755r2e522a15ff462917@mail.gmail.com>
	 <a4c8a6d00908301236l4394a471vb83ed2befda3a91@mail.gmail.com>
	 <40aa078e0908301316m68258630oe84c0e9b6191332b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <marius@storm-olsen.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 22:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhqxX-0000HW-7g
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 22:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbZH3UY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 16:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbZH3UY5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 16:24:57 -0400
Received: from mail-yx0-f181.google.com ([209.85.210.181]:43097 "EHLO
	mail-yx0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbZH3UY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 16:24:57 -0400
X-Greylist: delayed 2918 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2009 16:24:56 EDT
Received: by yxe11 with SMTP id 11so614871yxe.4
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QNTix2cuySS/kGLALyR1m1DdETxRYBdIr6cv4YH3UN4=;
        b=A0dEc1zuE4UOBoK1m7hh1YPFDpanQzyD/ciTzM4t5dsCljO+JicZ+z398Le+aQWxGX
         IGqGz5Hn+XkDB5XatViddg+EH860DHoCqf9Zc2RD9kyEm1ZeQMwif2XNvbcm95TtwJWD
         9tpJIPg19HpCAvH0PgyvjdU/u3MmymgVWsMgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nWHuqX61h3AFHq2THtHhGErxZFnkxEBLF7jE7Ln1He/JnvzFvYMqIQKEo8370vpx/g
         hdIpkEqkhiG0LmdL3ySbwt3HBZ4kBJmQujD/I2ivS2rqlL59FDNxQQI8aieCxHEm41zt
         cOYzrfykCfa5VS1UVElZCkmUgjaP+j6JxPVRk=
Received: by 10.100.17.27 with SMTP id 27mr4327608anq.199.1251663898887; Sun, 
	30 Aug 2009 13:24:58 -0700 (PDT)
In-Reply-To: <40aa078e0908301316m68258630oe84c0e9b6191332b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127429>

Hi,
On Sun, Aug 30, 2009 at 5:16 PM, Erik Faye-Lund<kusmabite@googlemail.co=
m> wrote:
> On Sun, Aug 30, 2009 at 9:36 PM, Thiago Farina<tfransosi@gmail.com> w=
rote:
>> Error =A0 2635 =A0 =A0error LNK2019: unresolved external symbol _soc=
ketpair
>> referenced in function _imap_open_store imap-send.obj =A0 imap-send
>>
>> Anyone faced this problem before?
>
> Yes. imap-send isn't supported on windows, since it uses
> posix-functions that aren't available in msvcrt. The Makefile system
> excludes it for MinGW-builds. Is it added to the vcproj-files?
>
Yep, an imap-send vcproject with one file(imap-send.c) was added to
gitbuild.sln.
