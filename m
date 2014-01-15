From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page (web version)
Date: Wed, 15 Jan 2014 03:29:57 -0800
Message-ID: <E942D642-562F-43E3-B896-A38CC5FCBDB9@gmail.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu> <xmqqwqk37kdy.fsf@gitster.dls.corp.google.com> <CAEjxke-fPwTctUt9x_o1YwTKK2fX5TOPA7LStXUh+ejUVxZtpg@mail.gmail.com> <xmqq8uuj7olt.fsf@gitster.dls.corp.google.com> <CAEjxke9NACjYWP+v1-ZB0epJk9Hwo4g15qBPZexxVNRaKPC3Nw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Jason St. John" <jstjohn@purdue.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 12:30:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Ofe-0006MH-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbaAOLaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:30:02 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59505 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaAOLaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 06:30:00 -0500
Received: by mail-pa0-f45.google.com with SMTP id ld10so1021555pab.4
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 03:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=ndIg5NxNxyFtOXXaU061J6yZQsZistYZ3byURp4SSIY=;
        b=Zs8j9wOfaIgAo2m/PTRjDC8LT7vGr/LBVhSVjfB5C32KkcgHgSbvb/XMNSHdZyAdJC
         W/J4qGyJhKbrRqLznsowf/OR7ZftzgvsZarpvztXCaF4gn+eUquqWPhyrTz4pZdQtbQf
         dc2lzRUrj6FomPy85hRN82yXqpU6pD30IJzjyx5lMRyK5/BVPZ0/S+V5xgBZZU+Jk6Kn
         k6suMVCb94mq5XPFIcwO65L8skjyjkDxIGAeZ+e8L8DDVkzXvAGQhjr7qGmNqCZNjF3O
         qpPt11oQ3YPsU9MVcZ3pbsddCTkdPKN8W+eW+idzHpgyBqTXOoEdH109RlBqwo5mjiyl
         9yBA==
X-Received: by 10.68.75.9 with SMTP id y9mr2021171pbv.61.1389785399917;
        Wed, 15 Jan 2014 03:29:59 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id sq7sm7496918pbc.19.2014.01.15.03.29.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 03:29:59 -0800 (PST)
In-Reply-To: <CAEjxke9NACjYWP+v1-ZB0epJk9Hwo4g15qBPZexxVNRaKPC3Nw@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240463>

On Jan 14, 2014, at 21:36, Jason St. John wrote:
> On Mon, Jan 13, 2014 at 12:55 PM, Junio C Hamano <gitster@pobox.com>  
> wrote:
>> "Jason St. John" <jstjohn@purdue.edu> writes:
>>
>>> What AsciiDoc formatter (and version) do you use?
>>
>>    $ asciidoc --version
>>    asciidoc 8.6.8
>>
>> Checking with www.methods.co.nz/asciidoc, I am behind by about 2
>> months, it seems, though.
>
> I just went through git-scm.com's GitHub issue tracker, and I found
> that git-scm.com is, in fact, using their own AsciiDoc parser[1].
>
> This issue, along with the other formatting issues found in
> git-svn.txt and gitweb.txt, will hopefully be resolved soon, as one of
> the GitHub maintainers opened an issue to update their AsciiDoc
> parser[2].
>
> [1] https://github.com/git/git-scm.com/issues/ 
> 134#issuecomment-27539970
> [2] https://github.com/git/git-scm.com/issues/350

Hmmm.  I've also had some problems as well getting a correct man page  
build although it's the non-web version.  In my case I use the git- 
config.1 man page to detect the problem.  Uninteresting lines have  
been replaced with "[...]" for brevity in the following samples.   
Using 'MANWIDTH=65 man -c ./git-config.1' the bad man page has a  
section that looks like this:

     http.<url>.*
        Any of the http.* options above can be applied
        selectively to some urls. For a config key to
        match a URL, each element of the config key is
        compared to that of the URL, in the following
        order:

	1. Scheme (e.g., https in
	   https://example.com/). This field must
	   match exactly between the config key and
	   the URL.
            [...]
	5. User name (e.g., user in
	   https://user@example.com/repo.git). If the
            [...]
	   precedence than a config key with a user
	   name.
	   The list above is ordered by decreasing
	   precedence; a URL that matches a config
            [...]
	   be preferred over a config key match of
	   https://user@example.com.

	   All URLs are normalized before attempting
	   any matching (the password part, if
            [...]
	   any URLs visited as a result of a
	   redirection do not participate in matching.

        i18n.commitEncoding
	   Character encoding the commit messages are
	   stored in; Git itself does not care per se,

The rest of the man page continues to be incorrectly indented too far,  
but I've omitted it for brevity.

The good output for the same section looks like this:

     http.<url>.*
        Any of the http.* options above can be applied
        selectively to some urls. For a config key to
        match a URL, each element of the config key is
        compared to that of the URL, in the following
        order:

	1. Scheme (e.g., https in
	   https://example.com/). This field must
	   match exactly between the config key and
	   the URL.
            [...]
	5. User name (e.g., user in
	   https://user@example.com/repo.git). If the
            [...]
	   precedence than a config key with a user
	   name.

        The list above is ordered by decreasing
        precedence; a URL that matches a config key's
        [...]
        preferred over a config key match of
        https://user@example.com.

        All URLs are normalized before attempting any
        matching (the password part, if embedded in the
        [...]
        URLs visited as a result of a redirection do
        not participate in matching.

    i18n.commitEncoding
        Character encoding the commit messages are
        stored in; Git itself does not care per se, but

I have two different systems to build these pages on:

System A:
   OS X + Mac Ports
   asciidoc --version
     asciidoc 8.6.6
   xmlto --version
     xmlto version 0.0.24
   docbook-xsl is 1.75.2_0
   produces bad git-config.1

System B:
   Ubuntu
   asciidoc --version
     asciidoc 8.5.2
   xmlto --version
     xmlto version 0.0.23
   docbook-xsl is 1.75.2+dfsg-3
   produces good git-config.1

The git-config.1 file is built like so:

1. asciidoc produces git-config.xml from git-config.txt

2. xmlto produces git-config.1 from git-config.xml

System A:
   git-config.txt: md5=c63cbafddb1bc3d6c38b6b2941f8cbce
   git-config.xml: md5=99c0caa45ec02e8712c346e8842a7ce6
   git-config.1:   md5=812f8d180ec82c2786b95e986219a5d0

System B:
   git-config.txt: md5=c63cbafddb1bc3d6c38b6b2941f8cbce
   git-config.xml: md5=99c0caa45ec02e8712c346e8842a7ce6
   git-config.1:   md5=7298467bedd0225d5edefa8700bc9b2a

So actually the problem here is not the asciidoc step, it's actually  
the xmlto step.

And, if I make the following changes to the git-config.1 file produced  
on system A:

     diff --git git-config.1 git-config-fix.1
     --- git-config.1
     +++ git-config-fix.1
     @@ -3299,7 +3299,7 @@ user
      in
      https://user@example\&.com/repo\&.git)\&. If the config key  
has[...]
      .RE
     -.RS 4
     +.sp
      The list above is ordered by decreasing precedence; a URL that  
[...]
      https://user@example\&.com/foo/bar
      a config key match of
     @@ -4460,7 +4460,7 @@ normal
      all
      \- Show also individual files in untracked directories\&.
      .RE
     -.RS 4
     +.sp
      If this variable is not specified, it defaults to
      \fInormal\fR\&. This variable can be overridden with the [...]
      \fBgit-status\fR(1)

Then it will format properly again (and in fact the $googlecode/git- 
manpages-*.tar.gz files have the same correct ".sp" instead of ".RS 4"  
lines).

Trying xmlto versions 0.0.23 and 0.0.25 on System A still produce the  
same wrong output, so while it appears to be the xmlto step that's the  
problem, it's not xmlto itself.

After much gnashing of teeth and digging it turns out the problem is  
in the docbook-xsl sources.  Debian includes a patch file  
"8530_manpages_lists_indentation_fix.dpatch" in [1]:

---- BEGIN PATCH ----
#! /bin/sh /usr/share/dpatch/dpatch-run
## 8530_manpages_lists_indentation_fix.dpatch by Daniel Leidert (dale)  
<daniel.leidert@wgdd.de>
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: Upstream fix from revision 8530 ( dleidert ):
## DP:   Fix two indentation issues: In the first case there is no  
corresponding
## DP:   .RS macro (Debian #519438, sf.net 2793873). In the second  
case an .RS
## DP:   instead of the probably intended .sp leads to an indentation  
bug
## DP:   (Debian #527309, sf.net #2642139).
## DP:
## DP: <URL:http://docbook.svn.sourceforge.net/docbook/?rev=8530&view=rev 
 >
## DP: <URL:http://sourceforge.net/search/?type_of_search=artifact&group_id=21935&words=2642139 
 >
## DP: <URL:http://bugs.debian.org/519438>
## DP: <URL:http://bugs.debian.org/527309>

@DPATCH@
diff -urNad trunk~/manpages/lists.xsl trunk/manpages/lists.xsl
--- trunk~/manpages/lists.xsl	2009-03-27 02:25:08.000000000 +0100
+++ trunk/manpages/lists.xsl	2009-11-04 00:54:35.000000000 +0100
@@ -259,8 +259,8 @@
    <!-- * it, within the same para, then add a blank line and move -->
    <!-- * the left margin back to where it was -->
    <xsl:if test="parent::para and following-sibling::node()">
-    <xsl:text>.sp&#10;</xsl:text>
-    <xsl:text>.RE&#10;</xsl:text>
+    <xsl:text>.sp</xsl:text>
+    <xsl:text>&#10;</xsl:text>
    </xsl:if>
  </xsl:template>

@@ -280,11 +280,7 @@
      parent::para[following-sibling::node()] or
      parent::simpara[following-sibling::node()] or
      parent::remark[following-sibling::node()]">
-    <xsl:text>.RS</xsl:text>
-    <xsl:if test="not($list-indent = '')">
-      <xsl:text> </xsl:text>
-      <xsl:value-of select="$list-indent"/>
-    </xsl:if>
+    <xsl:text>.sp</xsl:text>
      <xsl:text>&#10;</xsl:text>
    </xsl:if>
  </xsl:template>
---- END PATCH ----

And once I have applied that I suddenly get a correct git-config.1  
file on System A.  On System A that file is found at:

   /opt/local/share/xsl/docbook-xsl/manpages/lists.xsl

and on System B it's found at:

   /usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/lists.xsl

So while this is not exactly the same problem you describe, I thought  
I'd point out the fix for others and also that the issue can end up  
not being in asciidoc at all especially since "System B" produces a  
correct git-config.1 file out-of-the-box and is running an asciidoc  
version released over four years ago (2009-12-07).

FYI, I did build git-rebase.html on "System B" (with its 4-year-old  
asciidoc version 8.5.2) and it looks correct (i.e. it has correct  
formatting in the BUGS section).

--Kyle

[1] http://ftp.de.debian.org/debian/pool/main/d/docbook-xsl/docbook-xsl_1.75.2+dfsg-5.diff.gz
