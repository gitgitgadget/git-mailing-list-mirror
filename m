From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 17:30:46 +0100
Message-ID: <m2ipzoj93d.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<1290517990.10366.17.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Nov 23 17:31:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKvlm-0004x0-7o
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 17:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab0KWQaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 11:30:55 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62803 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0KWQaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 11:30:55 -0500
Received: by wyb28 with SMTP id 28so8447336wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=vUWw/r2AqWQr24eBdYzEljIx+jViIvZ2Z7ujeyiGEss=;
        b=KCb8ue2Yd0FeAkHgzM4e/LZG1TUUZRwRY8RElkVSjQG3KdCFQ0GC/p0K3giWIuK85x
         Plc3nGygnMNfsRmdhUjU6d7nA3UTkvTBEhsgNgCsLcHi0KXYlb9T/60ISOhYO8Tfgq1w
         8zeTZa0EqoUS6T734OgUTW6kgPcZlJL4XJPbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=RGZCcnTE2ga/a4zej7hDZHYbDCqY/VcW4Ix+PueTr5/PwhdRwQNxPnCL2kErFBi+2T
         nxsiHHyE8uOCQmiabJM5MVO6WHbF4FrUe7WajCkSb/nNt93Xd31rf9Wcq8xdO05v8wCo
         6FCD1OlptDiK5sCQVmtD/6eifyoH01T0xJNSI=
Received: by 10.227.145.70 with SMTP id c6mr7890436wbv.106.1290529851648;
        Tue, 23 Nov 2010 08:30:51 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id f14sm4229626wbe.2.2010.11.23.08.30.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 08:30:49 -0800 (PST)
In-Reply-To: <1290517990.10366.17.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Tue, 23 Nov 2010 08:13:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161980>

Drew Northup <drew.northup@maine.edu> writes:

> On Tue, 2010-11-23 at 09:45 +0100, Michael J Gruber wrote:
>> Francis Moreau venit, vidit, dixit 23.11.2010 08:50:
>> > Drew Northup <drew.northup@maine.edu> writes:
>> > 
>
>> > [...]
>> > 
>> >> Supposedly docbook-dtds-1.0-53.fc14 contains the files needed. I would
>> >> check to make sure that your /usr/share/sgml/docbook/xmlcatalog file is
>> >> correct. If it is it will contain a line an awful lot like the
>> >> following:
>> >> <public publicId="-//OASIS//DTD DocBook XML V4.5//EN" uri="xml-dtd-4.5/docbookx.dtd"/>
>> > 
>> > It doesn't seem so:
>> > 
>> >   $ cat /usr/share/sgml/docbook/xmlcatalog
>> >   <?xml version="1.0"?>
>> >   <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
>> >   <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>
>
> Ok, before we get too far down the rabbit hole, is that EVERYTHING in
> your xmlcatalog?

yes it is.

> If it is then you have an install error (I downloaded the spec file
> and read it extra closely just to be sure). In FC14 the xmlcatalog
> file is not provided as whole cloth but it is built by the
> post-install script. If that script failed to run to completion you
> will have missing parts to your docbook-dtds package installation.

ah that may explain why mine is incomplete.

>> > This file belongs to xml-common-0.6.3-33.fc14.noarch which sounds
>> > pretty uptodate for a Fedora distribution.
>
> Yes, it is the latest in the FC git repo collection for that package as
> well.
>
>> > 
>> > Here's a list of some packages installed on my system that might be
>> > relevant:
>> > 
>> >   asciidoc-8.4.5-5.fc14.noarch
>> >   docbook-utils-0.6.14-26.fc14.noarch
>> >   docbook-style-xsl-1.75.2-6.fc14.noarch
>> >   docbook-style-dsssl-1.79-11.fc14.noarch
>> >   docbook-dtds-1.0-53.fc14.noarch
>> >   xml-commons-resolver-1.2-4.fc14.noarch
>> >   xmlto-0.0.23-3.fc13.x86_64
>> >   xmltex-20020625-16.fc13.noarch
>> >   libxml2-devel-2.7.7-2.fc14.x86_64
>> >   libxml2-python-2.7.7-2.fc14.x86_64
>> >   libxml++-2.30.1-1.fc14.x86_64
>> >   libxml2-2.7.7-2.fc14.i686
>> >   libxml++-2.30.1-1.fc14.i686
>> >   xml-common-0.6.3-33.fc14.noarch
>> >   xml-commons-apis-1.4.01-1.fc13.noarch
>> > 
>> 
>> I have no problems building the doc on F14 with
>> 
>> ASCIIDOC8=y
>> ASCIIDOC_NO_ROFF=y
>> DOCBOOK2X_TEXI=db2x_docbook2texi
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
>> Are you sure you have no other xmlto (type -a xmlto) and no tinkering
>> with the default style sheet config?
>> 
>> Michael
>
> Before you get too much further along chasing phantoms, please have a
> look back into the mailing list at the problems I had just enumerated
> with respect to building the man pages when missing the docbook 4.5
> declarations and files in my local xmlcatalog. I got EXACTLY THE SAME
> ERRORS ORIGINALLY NOTED. That's why I answered the original query to the
> list.

Could you give me the message-id ?

> I recommend re-installing the docbook-dtds package alone and in
> isolation from other Yum/RPM transactions. If the xmlcatalog file is
> correctly regenerated AND the docbook files are there AND you have
> (re)run ./configure prior to running make AND you don't have filesystem
> errors THEN you should have a successful build. (Barring something that
> crawls up out of the rabbit hole--other than a rabbit.)

Ok I'll try.

> Fix the most obvious possible problems first before seeking
> off-the-beaten-path solutions or worse blaming somebody.

Well that wasn't obvious for me that the catalog was not complete. I
also hope that I haven't blamed anyone so far for the trouble I'm
having...

-- 
Francis
