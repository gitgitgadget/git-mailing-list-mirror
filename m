From: Jeff S <acornblue@gmail.com>
Subject: Re: OS X Yosemite make all doc fails
Date: Tue, 25 Aug 2015 17:20:02 -0700
Message-ID: <CAJD5XBze8S23umS5enPaOKF6RFKwqkY-ZyuAfLG4SBp8CbCeRg@mail.gmail.com>
References: <CAJD5XByPQASzYpyTFdKo83RJ0QwPFHg-nPWyusDCucMRFbor4g@mail.gmail.com>
	<CAJD5XBy=skwogN+kbqHipa3poUt-EjSxMABxRZKoEk0J+2TM3w@mail.gmail.com>
	<CAJD5XBy+RnM7ZYt9_SGXgoE2gOKaiM=rmUv=Tkn3Ndi4S4-atQ@mail.gmail.com>
	<20150825010428.GA428718@vauxhall.crustytoothpaste.net>
Reply-To: acornblue@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 02:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUOTM-00029y-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 02:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388AbbHZAUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 20:20:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35454 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbbHZAUD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2015 20:20:03 -0400
Received: by iodt126 with SMTP id t126so323462iod.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=d+83a9ukKVVR6yb1gF9MeDodORKEI3eQiNB55C6R4es=;
        b=BtSiSRidFV06kSSP/fWMgK2PRCULfjMks5SMOXbK576l/QdjQ+Dp92bLCKQ1e6xpSY
         XkXAKThQKuB9gYzfXBz8f7dXMYKr6pdP1c/3SJCd05kPZtPT4PNlyRMfecbfkxuevEZ+
         TV0qsLjlpHrlkxNYiJkjcOSUfTwfGFTdn9JwJgWu2zIpjqmGa+4WKEKarrxxqIAZZxZ+
         cakl1IGEu5uI7azW+0c1heSHg8Q6SIU+rhCjMc5AcL9ROzQAHT9bt11h0le1XYqoBbSP
         nLwJghs+ClmA2OiByUvdgXBIdVWNlvpH+wUjjbKzig55GusiJhqgbQWr6/vWwWRLLnFs
         gBXw==
X-Received: by 10.107.170.139 with SMTP id g11mr19009ioj.85.1440548402895;
 Tue, 25 Aug 2015 17:20:02 -0700 (PDT)
Received: by 10.79.24.196 with HTTP; Tue, 25 Aug 2015 17:20:02 -0700 (PDT)
In-Reply-To: <20150825010428.GA428718@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276588>

Brian thanks for responding! I'm finally able to build git completely.
Would it be possible to add the OS X dependency to the git/INSTALL
file?

Jeff

OSX Yosemite 10.10.5
Xcode 6.4 (6E35b)
=E2=80=A6
$ brew install autoconf
$ brew install asciidoc
$ brew install xmlto
$ brew install docbook
$ export XML_CATALOG_FILES=3D/usr/local/etc/xml/catalog
$ brew install docbook-xsl

http://stackoverflow.com/questions/13519203/git-compilingdocumentation-=
git-add-xml-does-not-validate
Jeff

--- sent via the nexus ---


On Mon, Aug 24, 2015 at 6:04 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Aug 24, 2015 at 02:30:39AM -0700, Jeff S wrote:
>> XSLTPROC user-manual.html
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 29
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/common/l10n.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/common/utility.x=
sl"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 31
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/common/utility.xs=
l
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/common/labels.xs=
l"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 32
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/common/labels.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/html/autotoc.xsl=
"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 39
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/html/autotoc.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/html/verbatim.xs=
l"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 43
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/html/verbatim.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/html/formal.xsl"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 46
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/html/formal.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/common/table.xsl=
"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/table.xsl li=
ne 11
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/common/table.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/html/footnote.xs=
l"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 51
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/html/footnote.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/html/block.xsl"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 65
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/html/block.xsl
>> warning: failed to load external entity
>> "http://docbook.sourceforge.net/release/xsl/current/common/stripns.x=
sl"
>> compilation error: file
>> http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl =
line 76
>> element include
>> xsl:include : unable to load
>> http://docbook.sourceforge.net/release/xsl/current/common/stripns.xs=
l
>> make[1]: *** [user-manual.html] Error 5
>> make: *** [doc] Error 2
>
> It's clear from the message that your catalogs are not properly set u=
p.
> Once you get that working, the documentation should build correctly.
>
>> <nextCatalog
>> catalog=3D"file:///usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl/c=
atalog.xml"/>
>> <nextCatalog
>> catalog=3D"file:///usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl-n=
s/catalog.xml"/>
>> </catalog>
>
> Unfortunately, this doesn't tell us much, since these are all referen=
ces
> to other catalogs.  You need to look in the other catalogs, specifica=
lly
> the two mentioned above, and ensure that there are appropriate
> rewriteURI and rewriteSystem entries pointing to the right place.  On=
 my
> system, that looks like the following:
>
>   <rewriteURI uriStartString=3D"http://docbook.sourceforge.net/releas=
e/xsl/current/" rewritePrefix=3D"./"/>
>   <rewriteSystem systemIdStartString=3D"http://docbook.sourceforge.ne=
t/release/xsl/current/" rewritePrefix=3D"./"/>
>
> I don't know how your system is configured, so I can't tell you what
> entries would be correct.  You might ask in an appropriate user forum
> for Homebrew.
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> +1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion o=
nly
> OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B=
187
