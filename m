From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 10:05:24 +0100
Message-ID: <m27hg4l8a3.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 10:05:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKoov-0002vK-ON
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 10:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab0KWJFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 04:05:36 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52338 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0KWJFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 04:05:31 -0500
Received: by wyb28 with SMTP id 28so8039038wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 01:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=FMi2QMqVu+06n4zNhACuJrJcOmULmSRwwF3kvmp+r0E=;
        b=noIHKFvjh2swzeZzo9y0h2HKSlqHzTmCCTf7JprnhFUfELIcI3hps08Pzcf6zgv1hl
         J0o2nyKrZrIGEjXqtADySkJ5HEvhTeNhTGMZ6ISPz1j/z5LGUU3sDeyF4cp0iTgoYI4I
         XA7RgJYnbIV3Asx2aKJsB7NmAhL1h7Bvm7Bmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=Gdl3cghFZEgrlXYJtj00VQrUpt64omlBjJkfqE4+HwzBsjp+AWRNFguuDXwMPOMNcU
         zACtezTjHUtkhlHlZgsXL9+5/XpmIfVUq2CWLFVT1InInXUm9PIGk/iRssBIyTPKWv8v
         bSZLHwfAujPjyR5I0vfC7XHjxKxD0x3GLCKCU=
Received: by 10.216.30.65 with SMTP id j43mr6257121wea.20.1290503129719;
        Tue, 23 Nov 2010 01:05:29 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id y80sm2733730weq.27.2010.11.23.01.05.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 01:05:28 -0800 (PST)
In-Reply-To: <4CEB7F1F.809@drmicha.warpmail.net> (Michael J. Gruber's message
	of "Tue, 23 Nov 2010 09:45:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161933>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Francis Moreau venit, vidit, dixit 23.11.2010 08:50:
>> Drew Northup <drew.northup@maine.edu> writes:
>> 
>> [...]
>
>> 
>>> Supposedly docbook-dtds-1.0-53.fc14 contains the files needed. I would
>>> check to make sure that your /usr/share/sgml/docbook/xmlcatalog file is
>>> correct. If it is it will contain a line an awful lot like the
>>> following:
>>> <public publicId="-//OASIS//DTD DocBook XML V4.5//EN" uri="xml-dtd-4.5/docbookx.dtd"/>
>> 
>> It doesn't seem so:
>> 
>>   $ cat /usr/share/sgml/docbook/xmlcatalog
>>   <?xml version="1.0"?>
>>   <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
>>   <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>
>> 
>> This file belongs to xml-common-0.6.3-33.fc14.noarch which sounds pretty
>> uptodate for a Fedora distribution.
>> 
>> Here's a list of some packages installed on my system that might be
>> relevant:
>> 
>>   asciidoc-8.4.5-5.fc14.noarch
>>   docbook-utils-0.6.14-26.fc14.noarch
>>   docbook-style-xsl-1.75.2-6.fc14.noarch
>>   docbook-style-dsssl-1.79-11.fc14.noarch
>>   docbook-dtds-1.0-53.fc14.noarch
>>   xml-commons-resolver-1.2-4.fc14.noarch
>>   xmlto-0.0.23-3.fc13.x86_64
>>   xmltex-20020625-16.fc13.noarch
>>   libxml2-devel-2.7.7-2.fc14.x86_64
>>   libxml2-python-2.7.7-2.fc14.x86_64
>>   libxml++-2.30.1-1.fc14.x86_64
>>   libxml2-2.7.7-2.fc14.i686
>>   libxml++-2.30.1-1.fc14.i686
>>   xml-common-0.6.3-33.fc14.noarch
>>   xml-commons-apis-1.4.01-1.fc13.noarch
>> 
>
> I have no problems building the doc on F14 with
>

Yes I think it's related to my config otherwise a lot of users would
have already complained.

>
> ASCIIDOC8=y
> ASCIIDOC_NO_ROFF=y
> DOCBOOK2X_TEXI=db2x_docbook2texi

I tried with these options but still fails

>
> in my config.mak (besides other stuff), with these versions:
>
> asciidoc-8.4.5-5.fc14.noarch
> docbook2X-0.8.8-7.fc14.x86_64
> docbook-dtds-1.0-53.fc14.noarch
> docbook-style-dsssl-1.79-11.fc14.noarch
> docbook-style-xsl-1.75.2-6.fc14.noarch
> docbook-utils-0.6.14-26.fc14.noarch
> libxml2-2.7.7-2.fc14.x86_64
> libxml++-2.32.0-1.fc14.x86_64
> libxml2-python-2.7.7-2.fc14.x86_64
> python-lxml-2.2.8-1.fc14.x86_64
> xml-common-0.6.3-33.fc14.noarch
> xmlto-0.0.23-3.fc13.x86_64
>
> (libxml is irrelevant)
>
> Are you sure you have no other xmlto (type -a xmlto)

  $ type -a xmlto
  xmlto is /usr/bin/xmlto

  $ rpm -qf /usr/bin/xmlto
  xmlto-0.0.23-3.fc13.x86_64

> and no tinkering with the default style sheet config?

Well I've never played with that since I've no idea of what it's.

Thanks
-- 
Francis
