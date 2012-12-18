From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Tue, 18 Dec 2012 21:29:50 +0100
Message-ID: <50D0D23E.3010104@gmail.com>
References: <1355851510-13438-1-git-send-email-manlio.perillo@gmail.com> <7v1uengsbm.fsf@alter.siamese.dyndns.org> <50D0BC32.2020401@gmail.com> <7vpq27f9m7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl3nw-0004Sa-0a
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 21:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab2LRU37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 15:29:59 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:56825 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab2LRU37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 15:29:59 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so591594bku.17
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=zbgB3G1ScIfZVhbPNJS6UvnqTRPRRJNkZzWaOTMdam8=;
        b=o8bvjKolzCIJyfhBIR9OP4nfLxqJmLJTMx0VIxasRiokSt3wPIUh6Pil55wkPVhe8s
         dDIF4jhq6y69Y3KbZkeHB0lo8Od3OjUiyfvm6MsaUhhYZvLMOfqJuhPPQTfPd/x72Y/m
         2O6oNDHju1teVmV6iJGi2HFDZyQi1MEHidxg7PO1J89G9sYl2gVALI8XR+XdZLNkUBjf
         yEpVQaX8GQq9NBP8UuRQsT7so61uEj0H3mG/TWa3VLULjVD3Teun5LCjgc//ULYV8idb
         RJsOW9qTxH3yHN1sPk1v2u/d/OXO/xbxppNsM8dykN7S4LiioMER17Xuy7MwQv+HZR9H
         nQYw==
X-Received: by 10.204.152.28 with SMTP id e28mr1395682bkw.3.1355862597568;
        Tue, 18 Dec 2012 12:29:57 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id i20sm2521416bkw.5.2012.12.18.12.29.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 12:29:56 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vpq27f9m7.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211782>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 18/12/2012 20:22, Junio C Hamano ha scritto:
> [...]
>> Note that the performance is the reason why I suggested, in a previous
>> email, that git should have some more options to format data in custom ways.
>> As an example, there is no way to tell ls-files to not recurse
>> directories, and there is no way to also get the file type.
> 
> To ls-files, no-recurse is an idiotic thing to ask.  The index is a
> flat structure that is read as a whole.  There is no recursion
> involved.

What about an option like --as-tree, so that ls-files will list the
files as they were in a tree, instead of a flat structure ?


Thanks  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDQ0j4ACgkQscQJ24LbaURXoACffQ4iz6MsoeffEZEBib1b1KF8
NZsAoIUXa7OonWyFxfJ35mukBK/sddGr
=0nO7
-----END PGP SIGNATURE-----
