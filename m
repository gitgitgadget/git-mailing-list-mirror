From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] Documentation/git: add missing info about --git-dir command-line
 option
Date: Thu, 13 Dec 2012 19:00:54 +0100
Message-ID: <50CA17D6.2050700@gmail.com>
References: <50C8B92F.8020408@gmail.com> <7vmwxj3vxx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:01:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjD60-0006QZ-18
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab2LMSBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 13:01:01 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34768 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab2LMSBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 13:01:00 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1259783bkw.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 10:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=kEYczVYA4uNnFrBTreadxvEX0/BwpWgMS6+YFD7YekA=;
        b=OI1e3Itg50WBLw3jYqnJbedACOwZweq3tOH104OiE72DWlTAIULfwGhUJqb9qIqorz
         qL7m26+wP5byAPGyvE2ihSjo+YB5vigvoudcQGtC7q3h0pv4YZUuQPtQnk5czw4ae4T0
         y3PZeCYrOB6tG5znKtE79ENRlx4RALBnHMtauVweL8DBQYr5GIw+PPO+eszxQRzCJMfg
         t07UkwhMiM61CiD6yBI0a6QZ62tUEHOE170lSfr1UlvaKbDjyvpFPwFEYz7Erfi9Svwo
         5wXfeYlfHQn0dei1Sqlz1XSgEH8cHVXNzKV6PqOQXB392UyRDRQhxGIIHcol7eoFhKYg
         GAdg==
Received: by 10.204.136.207 with SMTP id s15mr1481611bkt.5.1355421659550;
        Thu, 13 Dec 2012 10:00:59 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id y11sm2229724bkw.8.2012.12.13.10.00.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Dec 2012 10:00:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121027 Icedove/3.0.11
In-Reply-To: <7vmwxj3vxx.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211460>

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
> somewhere in the description.
> 
> Please sign-off your patch (see Documentation/SubmittingPatches).
> 
> Thanks.
> 

Thanks to you.

I have sent the updated patch, let me know if is ok.



Manlio Perillo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDKF9YACgkQscQJ24LbaUQyHwCcDiaJjFZ5vwHzxjHyhEBCyFdd
GnIAn34MjoWmQOcLKJEl/EpE0ImeQBLG
=yrux
-----END PGP SIGNATURE-----
