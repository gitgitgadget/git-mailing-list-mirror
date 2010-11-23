From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 12:57:46 +0100
Message-ID: <m2r5ecjlqd.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<m27hg4l8a3.fsf@gmail.com> <4CEB8774.7050504@drmicha.warpmail.net>
	<m2zkt0jsha.fsf@gmail.com> <4CEB9109.4000008@drmicha.warpmail.net>
	<m2vd3ojna1.fsf@gmail.com> <4CEBA872.2020001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 12:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKrWz-0007XW-1H
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 12:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab0KWL5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 06:57:53 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57269 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab0KWL5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 06:57:53 -0500
Received: by wyb28 with SMTP id 28so8195943wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 03:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=eL+/C/E6tImQgv3AJDtdgYANbMYbtk4vVg+aIAV+Jyg=;
        b=S+79FjI8Grx+FRTIP5ObuJa6mdGugkogwBMKcaHbNDO5i4DfOEt/bYz/U2TXq5nHV8
         kB7VY6MJs3ituhip578LGQEvzefEOsPA/mvK5sK9rBMVCR1uHvlxGSs4bb7oVzRSnLmY
         7hI9CENJyFXrPvzYCJj/dAc+M7oftyN/VNSDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=Ok1EjDV+84n/kF8rhEoXALmOHIBH6FycRH/HQQ27MjlgI0rXKlub76wec6vSBB44i8
         lr+rlifdN6FecuWPFIAeIX4Qb5Hw/Z6Ggkn3eFp2KmE7BPjGwoeM40NXK78ATH92K24C
         1ZEBCsSQYhkEvH7dxTKOjzxWj3oD304+FyMNc=
Received: by 10.216.23.129 with SMTP id v1mr6260831wev.84.1290513470643;
        Tue, 23 Nov 2010 03:57:50 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id x3sm2812745wes.22.2010.11.23.03.57.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 03:57:49 -0800 (PST)
In-Reply-To: <4CEBA872.2020001@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 23 Nov 2010 12:41:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161945>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Francis Moreau venit, vidit, dixit 23.11.2010 12:24:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> Francis Moreau venit, vidit, dixit 23.11.2010 10:32:
>
>>>>
>>>>   $ make prefix=/usr/local NO_CURL=1 ASCIIDOC8=y DOCBOOK2X_TEXI=db2x_docbook2texi ASCIIDOC_NO_ROFF=y XMLTO_EXTRA="--skip-validation" V=1 doc
>>>>   make -C Documentation all
>>>>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
>>>>   make -C ../  GIT-VERSION-FILE
>>>>   make[2]: Entering directory `/home/fmoreau/git'
>>>>   make[2]: `GIT-VERSION-FILE' is up to date.
>>>>   make[2]: Leaving directory `/home/fmoreau/git'
>>>>   rm -f git-fetch.1 && \
>>>>   xmlto -m manpage-normal.xsl --skip-validation man git-fetch.xml
>>>>   I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>>>   warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
>>>>   compilation error: file /tmp/xmlto-xsl.A7kzn5 line 4 element import
>>>>   xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>>>   make[1]: *** [git-fetch.1] Error 1
>>>>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
>>>>   make: *** [doc] Error 2
>>>
>>> This is weird for several reasons.
>>>
>>> Can you wget or curl these files?
>> 
>> Yes I can.
>> 
>>>
>>> Besides, I can build the doc even without network access, even though my
>>> /tmp/xmlto... has the same import statement.
>>>
>>> Can you check with which options your xmlto calls your xsltproc? Mine
>>> has "--nonet".
>> 
>> I can see the following ones:
>> 
>>   --nonet
>>   --xinclude
>> 
>>> Do you have libxslt-1.1.26-3.fc14.x86_64, and is your xsltproc the one
>>> from that package?
>> 
>>   $ rpm -qa | grep libxslt
>>   libxslt-devel-1.1.26-3.fc14.x86_64
>>   libxslt-1.1.26-3.fc14.x86_64
>> 
>>   $ which xsltproc
>>   /usr/bin/xsltproc
>> 
>>   $ rpm -qf /usr/bin/xsltproc
>>   libxslt-1.1.26-3.fc14.x86_64
>> 
>
> I'm pretty stomped then. The only remaining suggestions:
>
> - remove xml-commons-resolver and try again
> - try as a different user

still fails.

>
> Otherwise, an strace of xsltproc might give some hints...

Here it is:

  stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
  stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
  stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
  stat("/tmp/xmlto-xsl.aSCQgY", {st_mode=S_IFREG|0600, st_size=346, ...}) = 0
  open("/tmp/xmlto-xsl.aSCQgY", O_RDONLY) = 3
  lseek(3, 0, SEEK_CUR)                   = 0
  read(3, "<?xml version='1.0'?>\n<xsl:style"..., 8192) = 346
  read(3, "", 7846)                       = 0
  close(3)                                = 0
  stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl", 0x7fffa8779e50) = -1 ENOENT (No such file or directory)
  stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl", 0x7fffa8779d90) = -1 ENOENT (No such file or directory)
  stat("/etc/xml/catalog", {st_mode=S_IFREG|0644, st_size=819, ...}) = 0
  open("/etc/xml/catalog", O_RDONLY)      = 3
  lseek(3, 0, SEEK_CUR)                   = 0
  read(3, "<?xml version=\"1.0\"?>\n<!DOCTYPE "..., 8192) = 819
  read(3, "", 7373)                       = 0
  close(3)                                = 0
  stat("http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl", 0x7fffa8779d90) = -1 ENOENT (No such file or directory)
  write(2, "I/O ", 4)                     = 4
  write(2, "error : ", 8)                 = 8
  write(2, "Attempt to load network entity h"..., 103) = 103
  write(2, "warning: ", 9)                = 9
  write(2, "failed to load external entity \""..., 105) = 105
  write(2, "compilation error: file /tmp/xml"..., 68) = 68
  write(2, "xsl:import : unable to load http"..., 100) = 100

This looks weird, it does stat(2) on an URL...

-- 
Francis
