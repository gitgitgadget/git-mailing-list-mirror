From: "Ping Yin" <pkufranky@gmail.com>
Subject: Why very small repository has 2.7M size
Date: Sat, 19 Jan 2008 17:43:49 +0800
Message-ID: <46dff0320801190143h471e6d70ve5bf114335e1534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 10:44:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGAFV-0006OA-Jx
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 10:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYASJnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 04:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYASJnv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 04:43:51 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:64494 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYASJnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 04:43:50 -0500
Received: by py-out-1112.google.com with SMTP id u52so1935890pyb.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 01:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jOtBA2ui3jP1mOOOlC9d/iT45sG2OBqNRlmhTMUS/+E=;
        b=BMG5J4X9f8WFgJEcP8F6v9RalcidlhEs23kApShC+puj4xiE8YiArjyADTOSwWXNPjUNfQnG0Fergi2ULNEhSmFjmTmxVsXR2GqvPKDWFL6vKT4MCA5lVZPKLhBscG1/GLv5HORR3ZicPiuyC9KDH8vJ8PcNO3O+C6F7gfXa4DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MlsXKpVGi2nkr7FCXIEjumPQJb4VUTVo3NJ2ccJWR26EZJfUIQ14jHxQYT1QSSsgcLG1MbbIopeLKdL8t/iODMMoKxeF8AC8lDdIo3yf6bL2ig7TidTcCjLhQckRNNPUnCEen8QHoOEnaAMRbp4WPniALTH+IHIAnJwe42XY4xA=
Received: by 10.35.26.14 with SMTP id d14mr4992864pyj.8.1200735829495;
        Sat, 19 Jan 2008 01:43:49 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 19 Jan 2008 01:43:49 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71092>

$ ~/test/bar$ ll -h && git gc
total 8.0K
-rwxr-xr-x 1 yinping yinping 131 2008-01-19 17:35 Makefile.crawler
-rwxr-xr-x 1 yinping yinping 131 2008-01-19 17:37 Makefile.search
Counting objects: 87, done.
Compressing objects: 100% (78/78), done.
Writing objects: 100% (87/87), done.
Total 87 (delta 8), reused 87 (delta 8)

$ ~/test/bar$ du -h . | tail -10
8.0K    ./.git/objects/info
2.5M    ./.git/objects/pack
2.5M    ./.git/objects
8.0K    ./.git/logs/refs/heads
20K     ./.git/logs/refs/remotes/origin
24K     ./.git/logs/refs/remotes
36K     ./.git/logs/refs
44K     ./.git/logs
2.7M    ./.git
2.7M    .

-- 
Ping Yin
