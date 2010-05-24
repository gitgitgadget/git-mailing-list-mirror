From: Peng Yu <pengyu.ut@gmail.com>
Subject: git support for symbolic link?
Date: Mon, 24 May 2010 14:26:18 -0500
Message-ID: <AANLkTinZQSbuwsniwAmcq28RFqFj9rkN5lXRAjf5ndKO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 24 21:26:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGdIO-0000db-G7
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 21:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab0EXT0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 15:26:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64190 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0EXT0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 15:26:19 -0400
Received: by gyg13 with SMTP id 13so1638517gyg.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=gKU1PS1NaJtszzLANZ8QiYCIS0c8eAu0QxeXxxHZeoI=;
        b=Zegn5Mb5+XfQHaUfIXyKOcubnCDN9C0InA+0dRvtkYMHJ2bnwGOaP/RHuKdD/JiU2r
         1te8bz4Ql7rtHeJKEGB62VTsAQ7Q/+4ChmlA71hn6/4FoS/Zy9xqmg91GBZ9A7f7BNsi
         SDNnIcps37a6YPNuHt2knAIOwZz1ACq4QAt64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=F5QJmqiasDIxPI+R0IXE5Kh9fa0Tm+l+pa6+FYhcx808/DeRHQR7k3KUYcJjymDHka
         CHXkPQzsTPdBVKBSKRJrTnPMKE9gbar0c4PtIVi7jftVCU9bc8l7xjHe8n8RFEbGv8Wc
         B6t0CJ8/t7rKVjjU1d+zyqlxl4YBJOozoiwNo=
Received: by 10.150.187.18 with SMTP id k18mr6564063ybf.362.1274729178713; 
	Mon, 24 May 2010 12:26:18 -0700 (PDT)
Received: by 10.150.190.8 with HTTP; Mon, 24 May 2010 12:26:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147643>

For some reason, I need to create symbolic link in my source
directory. When the directory structure is changed, I have some tools
to fix broken links.

I'm wondering if git support symbolic links.

-- 
Regards,
Peng
