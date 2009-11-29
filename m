From: Dan Carpenter <error27@gmail.com>
Subject: does clone --depth work?
Date: Sun, 29 Nov 2009 18:03:52 +0200
Message-ID: <20091129160352.GO10640@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 17:04:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEmFy-0006oa-3L
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZK2QDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 11:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbZK2QDx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:03:53 -0500
Received: from mail-ew0-f215.google.com ([209.85.219.215]:52141 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZK2QDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:03:52 -0500
Received: by ewy7 with SMTP id 7so3535229ewy.28
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=tW2ssR3DIhwtvE57+pGJyBmk5XG0oagu2snWKr2mfoA=;
        b=IR9BzRFlYkcrOn0UZfcxSybguX1gu1DxSpbLDADrjvWRMXnUACIkEOeOU/T2Ty53of
         ZgZi5P+Dpq2AvptllV+ey0pie2vdbuQQGikdcRmXf2t75XWPI5H+oJbxIK1Z2YhstnaU
         XIYManrCoExyDgl63IiwYO3v70jX4ZX8aNNZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=E5MBzuSWup30jeDyIjzC7TeO0N9imuWHQulG4RaL6HJ59onTwgAycTJxatByJ5m29u
         ODK3MNYf5Xgg9Rg4Wrd39G+4mEoR/Y6cywnZkRC3UgB/7hEVAybagD0nyZjv7lFpCJ/+
         3/DLhcG+PB7wNeESMrQlf5J+OZkJm8eAMI3No=
Received: by 10.213.2.84 with SMTP id 20mr3764825ebi.46.1259510637815;
        Sun, 29 Nov 2009 08:03:57 -0800 (PST)
Received: from bicker ([41.222.20.196])
        by mx.google.com with ESMTPS id 16sm2109426ewy.6.2009.11.29.08.03.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 08:03:56 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134019>

I do: `git clone --depth 0 ./repo1/ repo2`  I expected that 
"git log" in repo2 wouldn't show any revisions, but it does.

I'm using 1.6.5.3.171.ge36e.dirty (small unrelated modification).

Am I doing something incorrectly?

regards,
dan carpenter
