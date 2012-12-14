From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] Documentation/git: add missing info about --git-dir command-line
 option
Date: Fri, 14 Dec 2012 18:26:27 +0100
Message-ID: <50CB6143.4040505@gmail.com>
References: <50C8B92F.8020408@gmail.com> <7vmwxj3vxx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 18:27:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjZ2K-0003tI-MO
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 18:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab2LNR0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 12:26:46 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37403 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137Ab2LNR0o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 12:26:44 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1887949bkw.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 09:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=g1LC85i2j9x/dPYTvLqk/VayHL0cXqLMt+J8tGEH0y0=;
        b=s72IUYtJ3jaJFE/AchsFzbyhlIP8mJ2jA68bR4tZT5mcXN53tngyM9Cx+zqoiM+yvW
         r3hc49CCR32g5aTAGFWbOjzAJEEuNenE6WqvA2ksyQf7r3brYiGVARIkLni5w9/TjdVp
         Z6R8R7Ny1a9/p4IF4fqQ6nom3rDOM/REotm3IPe81smUPHMpzAW7qKaeV6N8Zkcks+fV
         wjxid8lyHKjus4Gw8cAMR/38VsA1NYZiS5ucvt6tItSUTDrr+xVIBLY9XytKugIthDiR
         PZ311jhhMbL4/fdkxFHKMG1+U7P6rQgAUmY96o6t36tvzBvv6SpzI6Eqax3Ey8iYTl40
         pW4g==
Received: by 10.204.156.139 with SMTP id x11mr2985905bkw.128.1355506002835;
        Fri, 14 Dec 2012 09:26:42 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id z5sm5256931bkv.11.2012.12.14.09.26.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2012 09:26:41 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <7vmwxj3vxx.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211495>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 12/12/2012 20:35, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> The Documentation/git.txt file, in the GIT_DIR environment variable
>> section, did not mentioned that this value can also be set using the
>> --git-dir command line option.
>> ---
> 
> s/mentioned/mention/; Also it may help to say
> 
> 	Unlike other environment variables (e.g. GIT_WORK_TREE,
> 	GIT_NAMESPACE),
> 

I'm sorry, I just copied this text "as is" (I'm lazy) in the commit
message failing to notice the use of the tab character.

When I checked the patch email message, my editor rendered the tab
character as a single space...


That's the reason why I have all my editors configured to never ever use
tabs.


Manlio Perillo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDLYUMACgkQscQJ24LbaUTUPACcDhufXkawZZPBV0p/af1GFu1D
/BcAnjPARpeTi4EdyM/3wV0eI9U9Fu51
=rSfl
-----END PGP SIGNATURE-----
