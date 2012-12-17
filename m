From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git-completion.bash: update obsolete code.
Date: Mon, 17 Dec 2012 17:53:25 +0100
Message-ID: <50CF4E05.7050103@gmail.com>
References: <1355694602-8771-1-git-send-email-manlio.perillo@gmail.com> <7vtxrlnuqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:53:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkdwr-0001al-6p
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 17:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab2LQQxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 11:53:31 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65207 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab2LQQxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 11:53:30 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2892603bkw.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=DmzO7CZWjmMNpK40XlKba3ONE0uNbgZXgvorQ7Xp4Ag=;
        b=dhYvUJA8Y3eTberaNhi3Uf/lqVKhTuz3gYzoIpeYP2skY3k7b4NS6XgJ27M228KHZ+
         k6YrowTF37tSpaRsmFddSfRVsnI//tQlyEeTLOZS1aL5DHumL/3z+3me1xsVBAolEuT1
         17j2WCsI57Wq2VFH4TueirG/bppciVw2dTorJGmvzoFMY3pD0ZXGx5tnWZ4g65xtvjNh
         OnqBcyAHLjLX9V3xcy9qnhK5yR9V5oP1+jyhHdM+UDj8nuihbsld6P7XLKAvUlSmGD9j
         c3pDydf7TIx7XZXUD5p27Jz4uxBJpyu6h6xjtmGSzTcrUgII9YhWyCDDqzdOsX+vjeCC
         D0Fg==
Received: by 10.204.130.87 with SMTP id r23mr6109943bks.90.1355763209183;
        Mon, 17 Dec 2012 08:53:29 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id f24sm9978169bkv.7.2012.12.17.08.53.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 08:53:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vtxrlnuqr.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211690>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 17/12/2012 05:54, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> The git-completion.bash script was using the git ls-tree command
>> without the --name-only option, with a sed filter to parse path names;
>> use the --name-only option, instead.
>>
>> Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
>> ---
> 
> Did you miss the different handling between blobs and trees the
> latter gets trailing slash in the completion)?
> 

Yes, I totally missed it, sorry.
I was assuming the bash completion script was written before --name-only
option was added to ls-tree.

By the way, IMHO there should be an option for adding a slash to
directory names in ls-tree.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAlDPTgUACgkQscQJ24LbaUSkKgCePH2NFHf/qp2ZrgI9eD9D0D3G
zOwAmL8Dc8r9DevyV1ZhaCb2G9MPZxU=
=QJEy
-----END PGP SIGNATURE-----
