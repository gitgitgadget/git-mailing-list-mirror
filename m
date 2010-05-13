From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Re: git-svn uses uninitialized value $lc_rev at line 1141
Date: Thu, 13 May 2010 11:58:07 -0300
Message-ID: <4BEC137F.1020200@gmail.com>
References: <4BEB88ED.3080609@gmail.com> <20100513084015.GA20917@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
X-From: git-owner@vger.kernel.org Thu May 13 17:06:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZzK-0006Gm-JL
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 17:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939Ab0EMPFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 11:05:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45731 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822Ab0EMPFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 11:05:53 -0400
Received: by vws16 with SMTP id 16so2039vws.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=7bn0fSe4d7HXKnfXdXUz7lMzmQg2ytrQ+Jrx+hkfB8Y=;
        b=ZJaHXJ2fJCGcheHD2HvhoI0OycSF7eWVjGhTBOZYjgGKvZMvBZWwTKz01jvqFiT8xs
         dB9ML97wP2EbDKjZVm009e4qhLGn3jIwHX7u/P0gMgcl+KmOIBYttulgci+X23ZTVJ83
         oRQ4Rx/6y22RX3YxLScTIuFOiyyaz1e/AUzek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Ou5TstYOi69gagmpVwyhvXw44po8uzXhWDNOSJ8zlalOHjy6TzDhm3qJjwSBbVNyJv
         GCaofSPQuXkbn+mmOCmp9gyL10vFDsPJP5Hr6lhYP7qPnLKmdqU9azbU78V5H21kHngr
         2QpUUbsnTHeGjZkdMC/OUn4Dv+Rpc7gTJ0cqI=
Received: by 10.220.122.37 with SMTP id j37mr2333936vcr.234.1273762692783;
        Thu, 13 May 2010 07:58:12 -0700 (PDT)
Received: from [192.168.0.2] (hlfxns0169w-142177058040.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.177.58.40])
        by mx.google.com with ESMTPS id g3sm5980173vcp.4.2010.05.13.07.58.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 07:58:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
In-Reply-To: <20100513084015.GA20917@sajinet.com.pe>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147015>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10-05-13 05:40 AM, Carlo Marcelo Arenas Belon wrote:
> this shouldn't happen unless you are doing git svn info in a tree 
> that has no metadata (or lost it somehow).

Even if your tree has no SVN metadata, perl shouldn't be sending me
errors. Maybe you want to catch the error and git-svn can give me the error.

> does git log show any git-svn-id tags?

Yes, it did... though I've since re-cloned the SVN repo since I needed
to include stuff I had skipped with --ignore-paths. The top commit was
made to something I had ignored in that way. I don't know if git would
have lc_rev data in that case.

- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvsE3wACgkQst0AR/DaKHvEuwCgkUZ/DF5GAQzwM38ICrkLaDkY
qWMAn28fO1Jzu2LHVnG7mrKRIM8ZIb+h
=eG8N
-----END PGP SIGNATURE-----
