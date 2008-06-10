From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 08:57:07 -0500
Message-ID: <484E8833.9030302@gmail.com>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <alpine.DEB.1.10.0806092335420.17180@swallowtail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 15:58:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K64MQ-0007gv-9t
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 15:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbYFJN5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 09:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbYFJN5M
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 09:57:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:9132 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbYFJN5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 09:57:11 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1517473wri.5
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=cn9bi49n2uD70qdzVUQyNPKEnr2H/6ttEQWm2OnUbBM=;
        b=TepoOcrDNh1tbAIb7Ic8rPlrJFUfTsEmSXTjZIXKE3oxq/e5mPv9fuc2Fh5EAzxSP0
         GM3jIfq0Nro/ER6Kl7hY4HGZqn0X9Kd3IgxGx7IcNyPYrJMnVRc1NUix+EeOwun1lbVJ
         giI9M5I3aA/YOslVmQpkMEN/IDn55PbnAr35s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Y3PmCNcBLF/okv9Vs6dVwO+X/4q6nG0Yete3/g5Q6YwydOaqGSWy1N/KgzcH3KBC8S
         OtEl9tru1NnWaEoCChFnv9IJXokSSAjr9oQjRWD9nSx3WAj2EMP3Qhk8IZcfEaC0myKs
         sGBNEkjq1KL6kg7DM5bxxs9G3QGhs3Lyu+fFg=
Received: by 10.100.215.14 with SMTP id n14mr5433746ang.148.1213106230162;
        Tue, 10 Jun 2008 06:57:10 -0700 (PDT)
Received: from ?192.168.2.37? ( [74.239.78.188])
        by mx.google.com with ESMTPS id 33sm7027540wra.37.2008.06.10.06.57.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 06:57:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <alpine.DEB.1.10.0806092335420.17180@swallowtail>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84503>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Asheesh Laroia wrote:
> 
> Peanut gallery question: Why not just always try these methods and catch
> some format exception if they fail, proceeding to the next possible
> decompressor (proceeding on to no decompressor)?
> 
> That way if a file is called .GZ, it will still be handled properly; in
> fact, all files would still be handled properly.  And these formats
> leave notes in the first few bytes of the file as to if they should be
> tried, so it's not as if it would come at some performance cost.

Interesting thought. Do all the decompressors throw an error if the input format
isn't recognized?

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhOiDMACgkQqA4JVb61b9fixACfZLtxY20tXyZA5oLHTBSm5JPj
ApQAnRsb6RkA2YKB5UXhXiEezMm1j1ZS
=Y7ZK
-----END PGP SIGNATURE-----
