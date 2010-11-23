From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 10:20:52 +0100
Message-ID: <4CEB8774.7050504@drmicha.warpmail.net>
References: <m2oc9hkurl.fsf@gmail.com>	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>	<m2k4k5ks0b.fsf@gmail.com>	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net> <m27hg4l8a3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 10:23:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKp5e-0003ku-Cw
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 10:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab0KWJXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 04:23:00 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34406 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752314Ab0KWJW6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 04:22:58 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 45E7718B0;
	Tue, 23 Nov 2010 04:22:58 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 23 Nov 2010 04:22:58 -0500
X-Sasl-enc: iktwIbYlduBltu5k18FcjDvc1yT2X1H0cI/lstDnA4cn 1290504177
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 788125E2F51;
	Tue, 23 Nov 2010 04:22:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <m27hg4l8a3.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161936>

Francis Moreau venit, vidit, dixit 23.11.2010 10:05:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Francis Moreau venit, vidit, dixit 23.11.2010 08:50:
>>> Drew Northup <drew.northup@maine.edu> writes:
>>>
>>> [...]
>>
>>>
>>>> Supposedly docbook-dtds-1.0-53.fc14 contains the files needed. I would
>>>> check to make sure that your /usr/share/sgml/docbook/xmlcatalog file is
>>>> correct. If it is it will contain a line an awful lot like the
>>>> following:
>>>> <public publicId="-//OASIS//DTD DocBook XML V4.5//EN" uri="xml-dtd-4.5/docbookx.dtd"/>
>>>
>>> It doesn't seem so:
>>>
>>>   $ cat /usr/share/sgml/docbook/xmlcatalog
>>>   <?xml version="1.0"?>
>>>   <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
>>>   <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>
>>>
>>> This file belongs to xml-common-0.6.3-33.fc14.noarch which sounds pretty
>>> uptodate for a Fedora distribution.
>>>
>>> Here's a list of some packages installed on my system that might be
>>> relevant:
>>>
>>>   asciidoc-8.4.5-5.fc14.noarch
>>>   docbook-utils-0.6.14-26.fc14.noarch
>>>   docbook-style-xsl-1.75.2-6.fc14.noarch
>>>   docbook-style-dsssl-1.79-11.fc14.noarch
>>>   docbook-dtds-1.0-53.fc14.noarch
>>>   xml-commons-resolver-1.2-4.fc14.noarch
>>>   xmlto-0.0.23-3.fc13.x86_64
>>>   xmltex-20020625-16.fc13.noarch
>>>   libxml2-devel-2.7.7-2.fc14.x86_64
>>>   libxml2-python-2.7.7-2.fc14.x86_64
>>>   libxml++-2.30.1-1.fc14.x86_64
>>>   libxml2-2.7.7-2.fc14.i686
>>>   libxml++-2.30.1-1.fc14.i686
>>>   xml-common-0.6.3-33.fc14.noarch
>>>   xml-commons-apis-1.4.01-1.fc13.noarch
>>>
>>
>> I have no problems building the doc on F14 with
>>
> 
> Yes I think it's related to my config otherwise a lot of users would
> have already complained.
> 
>>
>> ASCIIDOC8=y
>> ASCIIDOC_NO_ROFF=y
>> DOCBOOK2X_TEXI=db2x_docbook2texi
> 
> I tried with these options but still fails
> 
>>
>> in my config.mak (besides other stuff), with these versions:
>>
>> asciidoc-8.4.5-5.fc14.noarch
>> docbook2X-0.8.8-7.fc14.x86_64
>> docbook-dtds-1.0-53.fc14.noarch
>> docbook-style-dsssl-1.79-11.fc14.noarch
>> docbook-style-xsl-1.75.2-6.fc14.noarch
>> docbook-utils-0.6.14-26.fc14.noarch
>> libxml2-2.7.7-2.fc14.x86_64
>> libxml++-2.32.0-1.fc14.x86_64
>> libxml2-python-2.7.7-2.fc14.x86_64
>> python-lxml-2.2.8-1.fc14.x86_64
>> xml-common-0.6.3-33.fc14.noarch
>> xmlto-0.0.23-3.fc13.x86_64
>>
>> (libxml is irrelevant)
>>
>> Are you sure you have no other xmlto (type -a xmlto)
> 
>   $ type -a xmlto
>   xmlto is /usr/bin/xmlto
> 
>   $ rpm -qf /usr/bin/xmlto
>   xmlto-0.0.23-3.fc13.x86_64
> 
>> and no tinkering with the default style sheet config?
> 
> Well I've never played with that since I've no idea of what it's.

That's what they all say ;)

How successful is:

make XMLTO_EXTRA="--skip-validation" doc

This should avoid hitting the network for the dtd under all
circumstances. (Are you online when make'ing?) Normally, the catalogue
should take care of that but this seems to be failing for you.

Just to make sure: You're not building as root, are you?

You can also use the quick-install-doc target, of course, but we want
install-doc to work as well on a mainstream distro.

Michael
