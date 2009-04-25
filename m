From: Gregory Petrosyan <gregory.petrosyan@gmail.com>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Sat, 25 Apr 2009 16:04:29 +0400
Message-ID: <20090425120429.GA417@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 14:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxghV-0000Hx-Dd
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 14:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbZDYMEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 08:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbZDYMEe
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 08:04:34 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:42709 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZDYMEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 08:04:34 -0400
Received: by bwz7 with SMTP id 7so1494419bwz.37
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=9zeyrZPVHqANJTD+JQosgIxUR0WeSAkRGHQTISQCRsc=;
        b=GnUfYtSDivGqU2YkATTWgQIFnEQ5+NkyB97FCUo+ID5iaZGZu6PSszJrB0L2TVD6GV
         pOspBnaTlND6gYe5l1ldnCtTL5f8mrwCdrLYRHh3FmiAFK/phKQpgY8qZKTfkJteCBut
         wZLb5avZnY3jKUSV38VRi45t8PSx6H1OF3KpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=TsMl895UAyqLtqynyJDTVyxkEewQpeHHFkgD7MhSybpCDDuxz4wVccanZak5R0zHEw
         bgondqEQcd4uNCKB2HSdHqN79CfbDkFlhMhCHFmu+un/Ok43vMKh3Rq0AjISNQxEvnme
         z9nSGsKwdfrFoPJnZPlvGgpXNGNbtbvMag6OU=
Received: by 10.103.105.1 with SMTP id h1mr1905856mum.13.1240661072551;
        Sat, 25 Apr 2009 05:04:32 -0700 (PDT)
Received: from home ([78.111.87.108])
        by mx.google.com with ESMTPS id y37sm4911349mug.19.2009.04.25.05.04.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Apr 2009 05:04:32 -0700 (PDT)
Mail-Followup-To: Matthias Andree <matthias.andree@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-04-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117551>

> git-svn on Cygwin works well with svn+ssh://, but needs some fixes
> around tempfile and/or subprocess handling for https:// - please help.

This problem is triggered by updating Cygwin's SVN to 1.6. Downgrading
it back to 1.5 make git-svn work for me again.

	Gregory
