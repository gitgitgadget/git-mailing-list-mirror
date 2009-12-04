From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Fri, 4 Dec 2009 14:33:55 -0500
Message-ID: <20091204193355.GC4629@inocybe.localdomain>
References: <m2d42w5fqq.fsf@igel.home>
 <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
 <7vbpif4rn2.fsf@alter.siamese.dyndns.org> <m2r5rb9hes.fsf@igel.home>
 <7vzl5ysm11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 20:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGdux-00079c-Do
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 20:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbZLDTeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 14:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZLDTeD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 14:34:03 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbZLDTeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 14:34:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1938591E;
	Fri,  4 Dec 2009 14:34:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=w6t7ACnF3ZQeuAR20myGELIeFs0=; b=Ah5EBDM
	bBx92n1VSMhcFDzIoVxvTXgJSfH3fblx2KuDcCXIOHLpRpcuwx5MPqD1+hqKxqVA
	VmKQGhkfATw9mlLRTj21VEUNgTmVmNHdy6EoH4JfD12Xip7CxLiSXsahdaAFcdtq
	KDNaULY826LfHVopsVgkIbPHJiMb1t8v6n94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=RrTbYQGOsExJwWxwe0PWH6qiT6XePHiNE
	KraO3viXcC60RnW/v1V6lb3m51WdS64zWjvFT2bo69/PNQxIvUjhErYKhxb3StC5
	q4mcC9m6bteGZW6x8ZTfn6w+zoEOZJoRV8P7EjHkzsvMGbgzm8r1EOOIdnT5LQLA
	SsH9a5sTa8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC65B8591C;
	Fri,  4 Dec 2009 14:34:02 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6482D85917; Fri,  4 Dec
 2009 14:33:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vzl5ysm11.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: FA3A0E18-E10B-11DE-A1F9-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134567>

Junio C Hamano wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I think it depends on the likelihood that a distro has xmlto so old that
>>> it does not understand --stringparam yet it uses stylesheet so new that
>>> setting the parameter makes a positive difference (either it gives the
>>> full URL or at least squelches the "You should define the parameter"
>>> noise) in the output.
>>
>> openSUSE 11.2, for example.  Its xmlto has a non-standard --xsltopts
>> option that passes its argument down to xsltproc.
>
> Ok, as I said that I've been wrong before in this area ;-)
>
> I don't think I will have much time for git today, and it would be
> appreciated if somebody can work on this and send a tested patch that
> applies cleanly on top of 'maint' to implement the @@MAN_BASE_URL@@
> replacement from manpage-base.xsl.in to manpage-base.xsl as Todd suggested
> earlier.

Something like this perhaps?  I tested it with 1.6.5.4 on Fedora 10,
12 and CentOS 5.4 but it could surely use more eyes and testing to
ensure it works as it should and doesn't have unintended negative
effects on make clean and such.

This does set MAN_BASE_URL unconditionally, pointing to kernel.org.
That way anyone building with recent DocBook and taking no new action
will have something useful in the man page links.

I noticed on Fedora 12 that email addresses get added to the NOTES
section.  For example, git-branch(1) has:

Documentation by Junio C Hamano and the git-list <git@vger.kernel.org[4]>.
...
NOTES
...
4. git@vger.kernel.org
   mailto:git@vger.kernel.org

That must be something new in DocBook, as it doesn't occur in the
Fedora 10 builds.  It's a little extraneous, but not harmful I guess.

--- >8 ---
From: Todd Zullinger <tmz@pobox.com>
Date: Fri, 4 Dec 2009 12:53:21 -0500
Subject: [PATCH] Documentation: Avoid use of xmlto --stringparam

The --stringparam option is not available on older xmlto versions.
Instead, set man.base.url.for.relative.links via a .xsl file.  Older
docbook versions will ignore this without causing grief to users of
older xmlto versions.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/.gitignore              |    1 +
 Documentation/Makefile                |   23 ++++++++++++-----------
 Documentation/manpage-base-url.xsl.in |   10 ++++++++++
 3 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/manpage-base-url.xsl.in

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d8edd90..1c3a9fe 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -8,3 +8,4 @@ gitman.info
 howto-index.txt
 doc.dep
 cmds-*.txt
+manpage-base-url.xsl
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1c9dfce..1c867fa 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -104,18 +104,15 @@ XMLTO_EXTRA += -m manpage-suppress-sp.xsl
 endif
 
 # Newer DocBook stylesheet emits warning cruft in the output when
-# this is not set, and if set it shows an absolute link.  We can
-# use MAN_BASE_URL=http://www.kernel.org/pub/software/scm/git/docs/
-# but distros may want to set it to /usr/share/doc/git-core/docs/ or
-# something like that.
+# this is not set, and if set it shows an absolute link.  Older
+# stylesheets simply ignore this parameter.
 #
-# As older stylesheets simply ignore this parameter, it ought to be
-# safe to set it to empty string when the base URL is not specified,
-# but unfortunately we cannot do so unconditionally because at least
-# xmlto 0.0.18 is reported to lack --stringparam option.
-ifdef MAN_BASE_URL
-XMLTO_EXTRA += --stringparam man.base.url.for.relative.links=$(MAN_BASE_URL)
+# Distros may want to use MAN_BASE_URL=file:///path/to/git/docs/
+# or similar.
+ifndef MAN_BASE_URL
+MAN_BASE_URL = http://www.kernel.org/pub/software/scm/git/docs/
 endif
+XMLTO_EXTRA += -m manpage-base-url.xsl
 
 # If your target system uses GNU groff, it may try to render
 # apostrophes as a "pretty" apostrophe using unicode.  This breaks
@@ -244,6 +241,7 @@ clean:
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
+	$(RM) manpage-base-url.xsl
 
 $(MAN_HTML): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
@@ -251,7 +249,10 @@ $(MAN_HTML): %.html : %.txt
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
 
-%.1 %.5 %.7 : %.xml
+manpage-base-url.xsl: manpage-base-url.xsl.in
+	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
+
+%.1 %.5 %.7 : %.xml manpage-base-url.xsl
 	$(QUIET_XMLTO)$(RM) $@ && \
 	xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
diff --git a/Documentation/manpage-base-url.xsl.in b/Documentation/manpage-base-url.xsl.in
new file mode 100644
index 0000000..e800904
--- /dev/null
+++ b/Documentation/manpage-base-url.xsl.in
@@ -0,0 +1,10 @@
+<!-- manpage-base-url.xsl:
+     special settings for manpages rendered from newer docbook -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
+		version="1.0">
+
+<!-- set a base URL for relative links -->
+<xsl:param name="man.base.url.for.relative.links"
+	>@@MAN_BASE_URL@@</xsl:param>
+
+</xsl:stylesheet>
-- 
1.6.6.rc1

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The world keeps ending but new people too dumb to know it keep showing
up as if the fun's just started.
