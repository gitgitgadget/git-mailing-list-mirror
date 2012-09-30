From: Hugh Esco <hesco@yourmessagedelivered.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-config.xml:643: parser
 error
Date: Sun, 30 Sep 2012 03:28:01 -0400
Organization: YourMessageDelivered.com
Message-ID: <20120930032801.8ac4cddf.hesco@yourmessagedelivered.com>
Reply-To: hesco@yourmessagedelivered.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:29:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIDxV-0008RS-EY
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab2I3H2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:28:51 -0400
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:37631 "EHLO
	homiemail-a65.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752263Ab2I3H2u (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 03:28:50 -0400
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Sep 2012 03:28:50 EDT
Received: from homiemail-a65.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a65.g.dreamhost.com (Postfix) with ESMTP id 91C8C7E405D
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yourmessagedelivered.com;
	 h=date:from:to:subject:message-id:reply-to:mime-version
	:content-type:content-transfer-encoding; s=
	yourmessagedelivered.com; bh=ChzI9TQmlUGPRSyptdYTd3kFLx4=; b=lNc
	MSeBZ1vxfkwNAFt9vg114MuTkL26Izhe4PbDA6NIdVgV38xZf4K40ZN8+S3oeAo9
	rxtp+FxobvOzD2TnLnAMiW+PAvKXNsgaGqq4jDhQjt/FoMA247jR8qvlshIR3Fy0
	FFuKBFaXmkXVZK8bp+BriMPOzgT5FZL+mdXdnkL0=
Received: from debianmarcus9.campaignfoundations.com (c-174-48-250-91.hsd1.fl.comcast.net [174.48.250.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hesco@yourmessagedelivered.com)
	by homiemail-a65.g.dreamhost.com (Postfix) with ESMTPSA id 305AA7E4058
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:28:50 -0700 (PDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206672>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-config.xml:643: parser error : Opening and ending tag mismatch: subscript line 643 and literal
ude.path</literal> is subject to tilde expansion: <literal><subscript>/</literal
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:644: parser error : Opening and ending tag mismatch: literal line 644 and subscript
is expanded to the value of <literal>$HOME</literal>, and <literal></subscript>u
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:1354: parser error : Opening and ending tag mismatch: subscript line 1354 and literal
   of files which are not meant to be tracked.  "<literal><subscript>/</literal>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:1355: parser error : Opening and ending tag mismatch: literal line 1355 and subscript
        to the value of <literal>$HOME</literal> and "<literal></subscript>user/
                                                                           ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:2304: parser error : Opening and ending tag mismatch: subscript line 2304 and literal
        "<literal><subscript>/</literal>" is expanded to the value of <literal>$
                                        ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:2304: parser error : Opening and ending tag mismatch: literal line 2304 and subscript
 is expanded to the value of <literal>$HOME</literal> and "<literal></subscript>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4609: parser error : Opening and ending tag mismatch: emphasis line 4609 and literal
oes not understand the version 2 <literal><emphasis role="strong">.idx</literal>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4611: parser error : Opening and ending tag mismatch: literal line 4611 and emphasis
that will copy both <literal></emphasis>.pack</literal> file and corresponding <
                                        ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4611: parser error : Opening and ending tag mismatch: emphasis line 4611 and literal
/literal> file and corresponding <literal><emphasis role="strong">.idx</literal>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4613: parser error : Opening and ending tag mismatch: literal line 4613 and emphasis
older version of git. If the <literal></emphasis>.pack</literal> file is smaller
                                                 ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4617: parser error : Opening and ending tag mismatch: literal line 4617 and emphasis
the <literal></emphasis>.idx</literal> file.</simpara>
                        ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4617: parser error : Opening and ending tag mismatch: emphasis line 4616 and literal
the <literal></emphasis>.idx</literal> file.</simpara>
                                      ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4666: parser error : Opening and ending tag mismatch: emphasis line 4666 and literal
ral>git config pretty.changelog "format:<emphasis role="strong"> %H %s"</literal
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-config.xml:4668: parser error : Opening and ending tag mismatch: literal line 4668 and emphasis
       to be equivalent to running <literal>git log "--pretty=format:</emphasis>
                                                                               ^
make[1]: *** [git-config.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

643,644c643,644
< found. The value of <literal>include.path</literal> is subject to tilde expansion: <literal>/</literal>
< is expanded to the value of <literal>$HOME</literal>, and <literal>user/</literal> to the specified
---
> found. The value of <literal>include.path</literal> is subject to tilde expansion: <literal><subscript>/</literal>
> is expanded to the value of <literal>$HOME</literal>, and <literal></subscript>user/</literal> to the specified
1354,1355c1354,1355
<         of files which are not meant to be tracked.  "<literal>/</literal>" is expanded
<         to the value of <literal>$HOME</literal> and "<literal>user/</literal>" to the specified user's
---
>         of files which are not meant to be tracked.  "<literal><subscript>/</literal>" is expanded
>         to the value of <literal>$HOME</literal> and "<literal></subscript>user/</literal>" to the specified user's
2304c2304
<         "<literal>/</literal>" is expanded to the value of <literal>$HOME</literal> and "<literal>user/</literal>" to the
---
>         "<literal><subscript>/</literal>" is expanded to the value of <literal>$HOME</literal> and "<literal></subscript>user/</literal>" to the
4609c4609
< <simpara>If you have an old git that does not understand the version 2 <literal>.idx</literal> file,
---
> <simpara>If you have an old git that does not understand the version 2 <literal><emphasis role="strong">.idx</literal> file,
4611c4611
< that will copy both <literal>.pack</literal> file and corresponding <literal>.idx</literal> file from the
---
> that will copy both <literal></emphasis>.pack</literal> file and corresponding <literal><emphasis role="strong">.idx</literal> file from the
4613c4613
< older version of git. If the <literal>.pack</literal> file is smaller than 2 GB, however,
---
> older version of git. If the <literal></emphasis>.pack</literal> file is smaller than 2 GB, however,
4616,4617c4616,4617
< </citerefentry> on the .pack file to regenerate
< the <literal>.idx</literal> file.</simpara>
---
> </citerefentry> on the <emphasis role="strong">.pack file to regenerate
> the <literal></emphasis>.idx</literal> file.</simpara>
4666c4666
<         running <literal>git config pretty.changelog "format: %H %s"</literal>
---
>         running <literal>git config pretty.changelog "format:<emphasis role="strong"> %H %s"</literal>
4668c4668
<         to be equivalent to running <literal>git log "--pretty=format: %H %s"</literal>.
---
>         to be equivalent to running <literal>git log "--pretty=format:</emphasis> %H %s"</literal>.

-------------------------------------------
-------------------------------------------

The next bug relates to:
Documentation/git-fast-import.xml
another patch coming under separate cover.

-- 
Hugh Esco 
404-424-8701
YourMessageDelivered.com
Keeping Your Group in the Loop
No Matter How Large or How Small
