From: Gurjeet Singh <singh.gurjeet@gmail.com>
Subject: Having some problem with instaweb
Date: Wed, 22 Jun 2011 21:06:41 -0400
Message-ID: <BANLkTim6gLg_-UdG36TXWS0Mfj3MOAQ_3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 03:07:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZYOI-00047W-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 03:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758371Ab1FWBHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 21:07:03 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50342 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab1FWBHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 21:07:01 -0400
Received: by iyb12 with SMTP id 12so1146399iyb.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 18:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=jqdLi+y6YJL3GdFl1F8NQu/7DOufXeF9/Ub2HCoKL6Y=;
        b=x/y1IyVXFZJdDmFUqWJexyoJBeGdQXfwJfsv8t3rPJ95mxtfsDNe92IDHAJ7NvqUG5
         AxTKP9Vgmd5/WOUvgrZkWONxB45zIPRK5FUcEKjLzazrJyRkSnSmPxeHgC2hYSDkjTQH
         DZcUWVAv3SR1p5zADLfbaG1tnrs34bHuTgKd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=YC6Q69r8FqOLRsITJ+5scCyEe7YxP8Ri0D/16xwSNFnvVtbJuS4X6Dn5YrLdafs/1A
         c3CtormI/sdklgBvzzCYTpLmHyr8mT/VRA7oGQ3nN2xVDEOIHlyZaHiKBEzHiHOtl5pR
         NnwPOpJk+1YFhGoro1xO4VcnMKojQMDuc14pU=
Received: by 10.231.114.72 with SMTP id d8mr1083664ibq.105.1308791221075; Wed,
 22 Jun 2011 18:07:01 -0700 (PDT)
Received: by 10.231.191.20 with HTTP; Wed, 22 Jun 2011 18:06:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176259>

I am on Linux Mint 10 and I tried the following command:

$ git instaweb -d apache2 -p 1234 --start
Syntax error on line 1 of /mnt/storage/gurjeet/.git/gitweb/httpd.conf:
Invalid command 'server.document-root', perhaps misspelled or defined
by a module not included in the server configuration
Could not execute http daemon apache2 -f.


/mnt/storage/gurjeet/ is my $HOME.

I have tried commenting out that first line, but then the error
complains about line 2 'server.port = 1234'

Any help appreciated.

Thanks in advance.

PS: I am told that no subscription is required on this mailing list,
since people usually do reply-all; so relying on that.
--
Gurjeet Singh
EnterpriseDB Corporation
The Enterprise PostgreSQL Company
