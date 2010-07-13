From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] format-patch: document the format.to configuration
 setting
Date: Tue, 13 Jul 2010 01:05:51 -0500
Message-ID: <20100713060551.GC2425@burratino>
References: <20100712185838.GR31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 13 08:06:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYYdk-0005mj-VG
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 08:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0GMGGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 02:06:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50956 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab0GMGGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 02:06:43 -0400
Received: by iwn7 with SMTP id 7so5496749iwn.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 23:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YedouOyBCynSvaTFuycLZvM4Bt+QrtJd/VHfcxKu7wc=;
        b=O4rHrMo5sCnv1m3eHdkogTbsr5I8rJBPG5qkp/qaCa0HmxJ/1JP9dyoZsGz1pSi5FT
         PFlgnJBNlxVKikywJqYz3jOPk9jzG4UKzW+PZGHk/LA4DU35AQNQVZNOcLbhQa7Zb15h
         0I8zC6zdYGX29gQkZEtYdbrkH3yzquSj1xWwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EkfXCM728Jj4/hhIxhvOrhEeZroObuomubbvv6YsqvEKUqQyiPFtK/p/sA3gf1fUn6
         zeMHCQ02pkRmY+Vaz/rTTuvgmBGXm8xGoqzgohHj3FW5h63XieoKnE+YJikYSKhkZ0Vv
         Ebp1SnMPXfwst30GuzIxnu6sSgJeJl9PxTcNs=
Received: by 10.231.146.134 with SMTP id h6mr2955061ibv.170.1279001196953;
        Mon, 12 Jul 2010 23:06:36 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm23407516ibi.12.2010.07.12.23.06.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Jul 2010 23:06:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100712185838.GR31048@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150878>

Hi Miklos,

Miklos Vajna wrote:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -886,6 +886,10 @@ format.headers::
>  	Additional email headers to include in a patch to be submitted
>  	by mail.  See linkgit:git-format-patch[1].
>  
> +format.to::
> +	Additional "To:" headers to include in a patch to be submitted
> +	by mail.  See the --to option in linkgit:git-format-patch[1].
> +
>  format.cc::
>  	Additional "Cc:" headers to include in a patch to be submitted
>  	by mail.  See the --cc option in linkgit:git-format-patch[1].

Maybe something like this would make sense on top?

Your patch looks good, of course.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877f78d..79d54e5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -887,12 +887,10 @@ format.headers::
 	by mail.  See linkgit:git-format-patch[1].
 
 format.to::
-	Additional "To:" headers to include in a patch to be submitted
-	by mail.  See the --to option in linkgit:git-format-patch[1].
-
 format.cc::
-	Additional "Cc:" headers to include in a patch to be submitted
-	by mail.  See the --cc option in linkgit:git-format-patch[1].
+	Additional recipients to include in a patch to be submitted
+	by mail.  See the --to and --cc options in
+	linkgit:git-format-patch[1].
 
 format.subjectprefix::
 	The default for format-patch is to output files with the '[PATCH]'
-- 
