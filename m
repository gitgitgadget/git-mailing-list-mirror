From: Jeff S <acornblue@gmail.com>
Subject: Re: OS X Yosemite make all doc fails
Date: Mon, 24 Aug 2015 02:30:39 -0700
Message-ID: <CAJD5XBy+RnM7ZYt9_SGXgoE2gOKaiM=rmUv=Tkn3Ndi4S4-atQ@mail.gmail.com>
References: <CAJD5XByPQASzYpyTFdKo83RJ0QwPFHg-nPWyusDCucMRFbor4g@mail.gmail.com>
	<CAJD5XBy=skwogN+kbqHipa3poUt-EjSxMABxRZKoEk0J+2TM3w@mail.gmail.com>
Reply-To: acornblue@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 11:30:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTo5X-0006vO-L7
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 11:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928AbbHXJal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 05:30:41 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:32795 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932780AbbHXJak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 05:30:40 -0400
Received: by igfj19 with SMTP id j19so56823672igf.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=kZRrt2SmUt9Cm0cfosRtvOmEyAKsgGhQSMHiDhvL85I=;
        b=AOR+s3/znGf0abJs4RQHAgNUIiUq9HRfVp+B5D0CqQyl8/BfDKRctS9ROtPyJo2MPk
         llIAdkhyXefFS4CcZlTS2Q6nisKHnGbmer8hD0xNJrHSfzDscHqYhWkT+7UwaY0cC8FU
         XSVhsmRVKG/3y/UCbuUcxb8FZmpOTJtNJbESuBNLL3T5KAo4z315AqOdYwa3pU/WRy05
         KOe2Jxx++4vr5BVFCMkPW6zJAHMxovOPeqTtq0XF/GfPtF0X3Eb2xTU34M8Ji1qwsOgK
         t7vktbza39t3SZJwEFd1Y8uCM6C8VS6iMIj4ttE5gX8dbPpxZvkHPMmeZtf+CKQQUqxw
         X4Sw==
X-Received: by 10.50.73.168 with SMTP id m8mr13109326igv.25.1440408639853;
 Mon, 24 Aug 2015 02:30:39 -0700 (PDT)
Received: by 10.79.24.196 with HTTP; Mon, 24 Aug 2015 02:30:39 -0700 (PDT)
In-Reply-To: <CAJD5XBy=skwogN+kbqHipa3poUt-EjSxMABxRZKoEk0J+2TM3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276441>

I tried building git on a fresh install of OS X Yosemite. Unfortunately it
errors out. I've attached the error below as well as cat the xml/catalog
file. Please let me know if there is anything else needed. Thanks in
advance.

Jeff

OS X Yosemite 10.10.5
Xcode 6.4 (6E35b)
git

commit ff86faf2fa02bc21933c9e1dcc75c8d81b3e104a
Merge: 8f8d0ec 552a736
Author: Junio C Hamano <gitster@pobox.com>
Date: Wed Aug 19 14:49:37 2015 -0700

Sync with maint

* maint:
Start preparing for 2.5.1

$ brew install autoconf
$ brew install asciidoc
$ brew install docbook
$ brew docbook-xsl
$ git clone https://github.com/git/git
$ cd git
$ make configure
$ ./configure --prefix=/usr
$ make all doc

XSLTPROC user-manual.html
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 29
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/common/utility.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 31
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/common/utility.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/common/labels.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 32
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/common/labels.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/html/autotoc.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 39
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/html/autotoc.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/html/verbatim.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 43
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/html/verbatim.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/html/formal.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 46
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/html/formal.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/common/table.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/table.xsl line 11
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/common/table.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/html/footnote.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 51
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/html/footnote.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/html/block.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 65
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/html/block.xsl
warning: failed to load external entity
"http://docbook.sourceforge.net/release/xsl/current/common/stripns.xsl"
compilation error: file
http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl line 76
element include
xsl:include : unable to load
http://docbook.sourceforge.net/release/xsl/current/common/stripns.xsl
make[1]: *** [user-manual.html] Error 5
make: *** [doc] Error 2





$ cat /usr/local/etc/xml/catalog
<?xml version="1.0"?>
<!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog
V1.0//EN"
"http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
<nextCatalog
catalog="file:///usr/local/Cellar/docbook/5.0/docbook/xml/4.2/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook/5.0/docbook/xml/4.1.2/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook/5.0/docbook/xml/4.3/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook/5.0/docbook/xml/4.4/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook/5.0/docbook/xml/4.5/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook/5.0/docbook/xml/5.0/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl/catalog.xml"/>
<nextCatalog
catalog="file:///usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl-ns/catalog.xml"/>
</catalog>
