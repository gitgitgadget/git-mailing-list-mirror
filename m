From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 12:24:22 +0100
Message-ID: <m2vd3ojna1.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<m27hg4l8a3.fsf@gmail.com> <4CEB8774.7050504@drmicha.warpmail.net>
	<m2zkt0jsha.fsf@gmail.com> <4CEB9109.4000008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 12:24:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKqzL-00015u-Qr
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 12:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab0KWLY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 06:24:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58892 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0KWLY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 06:24:27 -0500
Received: by wyb28 with SMTP id 28so8165706wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=zjJPEeOjS8LXVkk0Lgj4CarCu77VeT+FmD5fe5Prslg=;
        b=nBi9Sl1nH7UPk3jr1muG69LR43G6BwpIeriYZbGMHMM6aXmfrqnjOipehoeW43o4+F
         P3+0QwVFy2ZTdukF2dKRajJRrZUrlSCZUuMzN6EWVG9Drv6whix/LSvPS8hvFEnykzsX
         cBbvx12WPqrqcNsflKYzhTsIom3N3ZSRLNlpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=a9smAcc/i13mNl9timFEuAYA25Ff/kmEaEgiLDBdeYgjyTGyArOBnvmfKL5IJ7sXCU
         08eVMrVgwAE7IVO6JA5WC1kl3Mc0nvDDO84Mf/hlk1/k+dfWIfWNGKARg24d8sY92Qjt
         pJCwrpZ4ar5ZjxMLp1ZjEgZ5xg6wu0NttTpaA=
Received: by 10.227.38.143 with SMTP id b15mr7524367wbe.167.1290511466301;
        Tue, 23 Nov 2010 03:24:26 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id i19sm4034966wbe.5.2010.11.23.03.24.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 03:24:25 -0800 (PST)
In-Reply-To: <4CEB9109.4000008@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 23 Nov 2010 11:01:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161943>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Francis Moreau venit, vidit, dixit 23.11.2010 10:32:
>> 
>>   $ make prefix=/usr/local NO_CURL=1 ASCIIDOC8=y DOCBOOK2X_TEXI=db2x_docbook2texi ASCIIDOC_NO_ROFF=y XMLTO_EXTRA="--skip-validation" V=1 doc
>>   make -C Documentation all
>>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
>>   make -C ../  GIT-VERSION-FILE
>>   make[2]: Entering directory `/home/fmoreau/git'
>>   make[2]: `GIT-VERSION-FILE' is up to date.
>>   make[2]: Leaving directory `/home/fmoreau/git'
>>   rm -f git-fetch.1 && \
>>   xmlto -m manpage-normal.xsl --skip-validation man git-fetch.xml
>>   I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>   warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
>>   compilation error: file /tmp/xmlto-xsl.A7kzn5 line 4 element import
>>   xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
>>   make[1]: *** [git-fetch.1] Error 1
>>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
>>   make: *** [doc] Error 2
>
> This is weird for several reasons.
>
> Can you wget or curl these files?

Yes I can.

>
> Besides, I can build the doc even without network access, even though my
> /tmp/xmlto... has the same import statement.
>
> Can you check with which options your xmlto calls your xsltproc? Mine
> has "--nonet".

I can see the following ones:

  --nonet
  --xinclude

> Do you have libxslt-1.1.26-3.fc14.x86_64, and is your xsltproc the one
> from that package?

  $ rpm -qa | grep libxslt
  libxslt-devel-1.1.26-3.fc14.x86_64
  libxslt-1.1.26-3.fc14.x86_64

  $ which xsltproc
  /usr/bin/xsltproc

  $ rpm -qf /usr/bin/xsltproc
  libxslt-1.1.26-3.fc14.x86_64


Thanks for your time.
-- 
Francis
