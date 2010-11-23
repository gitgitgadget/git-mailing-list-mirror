From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 08:50:02 +0100
Message-ID: <m2bp5glbrp.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Nov 23 08:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKndr-0006hb-RE
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 08:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab0KWHuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 02:50:11 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33088 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab0KWHuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 02:50:10 -0500
Received: by wwc33 with SMTP id 33so492764wwc.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 23:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=d0JSBp0dVnF9X8AXWGg17LqvcljZ3Cd8SteOueCbaNU=;
        b=IzXDnTsUvPgtlxDDeelty+4Jpd7a9rWXAQOuSxYHVeG1VDak3AzlW+Z339AIz5qlKz
         LzB56vuALkxNcBvUuXVaSjojv7MwTLkyHkqNTrDqpXF8aQtzwXa0+WbhhqXyXBRmUdBS
         SWevNItVE3ChIY9cGIc9vQxG3gPpCqDS7t2Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=MYv/t1OedKNm0RRRPFjxDZr8kdagEo8CWR87uJ5Ye197+YUtifMJX3M81//JK23NoK
         M1lvz/QtQ2ZeXFRpRwnuWnWr3zk9e0SXsIQY8FyxMQAcD0Yg8XGDGqRp+Yfhj207wLxz
         hefDdR3vzuEDhpU9mppC1CiFQ96htYrl7dtmc=
Received: by 10.227.154.3 with SMTP id m3mr7142473wbw.119.1290498608514;
        Mon, 22 Nov 2010 23:50:08 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id w84sm2700340weq.44.2010.11.22.23.50.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 23:50:05 -0800 (PST)
In-Reply-To: <1290461070.5468.5.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Mon, 22 Nov 2010 16:24:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161929>

Drew Northup <drew.northup@maine.edu> writes:

[...]

> Supposedly docbook-dtds-1.0-53.fc14 contains the files needed. I would
> check to make sure that your /usr/share/sgml/docbook/xmlcatalog file is
> correct. If it is it will contain a line an awful lot like the
> following:
> <public publicId="-//OASIS//DTD DocBook XML V4.5//EN" uri="xml-dtd-4.5/docbookx.dtd"/>

It doesn't seem so:

  $ cat /usr/share/sgml/docbook/xmlcatalog
  <?xml version="1.0"?>
  <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
  <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog"/>

This file belongs to xml-common-0.6.3-33.fc14.noarch which sounds pretty
uptodate for a Fedora distribution.

Here's a list of some packages installed on my system that might be
relevant:

  asciidoc-8.4.5-5.fc14.noarch
  docbook-utils-0.6.14-26.fc14.noarch
  docbook-style-xsl-1.75.2-6.fc14.noarch
  docbook-style-dsssl-1.79-11.fc14.noarch
  docbook-dtds-1.0-53.fc14.noarch
  xml-commons-resolver-1.2-4.fc14.noarch
  xmlto-0.0.23-3.fc13.x86_64
  xmltex-20020625-16.fc13.noarch
  libxml2-devel-2.7.7-2.fc14.x86_64
  libxml2-python-2.7.7-2.fc14.x86_64
  libxml++-2.30.1-1.fc14.x86_64
  libxml2-2.7.7-2.fc14.i686
  libxml++-2.30.1-1.fc14.i686
  xml-common-0.6.3-33.fc14.noarch
  xml-commons-apis-1.4.01-1.fc13.noarch

-- 
Francis
