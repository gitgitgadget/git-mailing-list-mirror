From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Documentation/git-commit.txt: correct a few minor
 grammatical mistakes
Date: Mon, 18 Feb 2013 22:43:04 -0800
Message-ID: <20130219064304.GG19757@elie.Belkin>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <1361247427-438-4-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 07:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7gvS-0004Iu-3q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 07:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695Ab3BSGnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 01:43:11 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62727 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab3BSGnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 01:43:10 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so2066232pbc.12
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 22:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=j9IuSypGDVVs9CeGUwQg87ZGw8EIx9H5uxFSQTa6aY8=;
        b=XwRo5YDu7CwHSUBLmtpwLDLNSRiqvT0NgRWiNzwOWdM6adAbbPHtEvqi0yY4jlitW9
         FZzpImrXlHHI/Ng84VXawP1+83r0afGBVQ5fqmQ5qsWXgdxdxjQduYelhsScq5BxcgHJ
         v1SpTEQ0OKYNUfomHCbv41Sro2WtastXNm5hfjRTIwjkoQgj4r79KOWmgeQ7XTWXmKH3
         cZwiHk2inVOzwcIaAyaKaevq4QuTVmYCN8jtmPWcZgdYPcOWDey3TZF+aLcbsgETOosZ
         OhP59l6p0kKID0i5d63i7+1C0RMXoKe3mCoJNs80x3Z5spR5Z1RCv50dX8elfY853I42
         41Eg==
X-Received: by 10.68.189.234 with SMTP id gl10mr36772477pbc.148.1361256190219;
        Mon, 18 Feb 2013 22:43:10 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id q4sm106396504paz.20.2013.02.18.22.43.07
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 22:43:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361247427-438-4-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216566>

Brandon Casey wrote:

> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -174,10 +174,10 @@ OPTIONS
>  --cleanup=<mode>::
>  	This option sets how the commit message is cleaned up.
>  	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
> -	and 'default'. The 'default' mode will strip leading and
> +	or 'default'. The 'default' mode will strip leading and
>  	trailing empty lines and #commentary from the commit message
> -	only if the message is to be edited. Otherwise only whitespace
> -	removed. The 'verbatim' mode does not change message at all,
> +	only if the message is to be edited. Otherwise only whitespace is
> +	removed. The 'verbatim' mode does not change the message at all,
>  	'whitespace' removes just leading/trailing whitespace lines
>  	and 'strip' removes both whitespace and commentary. The default
>  	can be changed by the 'commit.cleanup' configuration variable

Yeah, the current text is a bit choppy.  How about this?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

--- i/Documentation/git-commit.txt
+++ w/Documentation/git-commit.txt
@@ -172,16 +172,25 @@ OPTIONS
        linkgit:git-commit-tree[1].
 
 --cleanup=<mode>::
-	This option sets how the commit message is cleaned up.
-	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
-	and 'default'. The 'default' mode will strip leading and
-	trailing empty lines and #commentary from the commit message
-	only if the message is to be edited. Otherwise only whitespace
-	removed. The 'verbatim' mode does not change message at all,
-	'whitespace' removes just leading/trailing whitespace lines
-	and 'strip' removes both whitespace and commentary. The default
-	can be changed by the 'commit.cleanup' configuration variable
-	(see linkgit:git-config[1]).
+	This option determines how the supplied commit message should be
+	cleaned up before committing. The '<mode>' can be `verbatim`,
+	`whitespace`, `strip`, or `default`.
++
+--
+default::
+	Strip leading and trailing empty lines and #commentary from
+	the commit message only if the message is to be edited.
+	Otherwise only remove whitespace.
+verbatim::
+	Do not change the message at all.
+whitespace::
+	Remove only leading and trailing whitespace lines.
+strip::
+	Remove both whitespace and commentary.
+--
++
+The default can be changed using the 'commit.cleanup' configuration
+variable (see linkgit:git-config[1]).
 
 -e::
 --edit::
