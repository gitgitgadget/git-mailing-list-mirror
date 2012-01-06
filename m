From: "Jonathan \"Duke\" Leto" <jonathan@leto.net>
Subject: Managing signed git tags and expiring keys
Date: Fri, 6 Jan 2012 00:13:00 -0800
Message-ID: <CABQG1aSY53-Z73CiUf2kstfaKLJ8zBGzu51CFdWHGiVR16JJ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 06 09:13:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj4vC-0007PX-K2
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 09:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab2AFINB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 03:13:01 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56654 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab2AFINA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 03:13:00 -0500
Received: by yenm11 with SMTP id m11so569130yen.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=EsgbSEEDO/IyfzxcmDsGFADlVSF1tqCInJ61/HXhQf4=;
        b=Xqp6L7VzrG8VM4xgvTEfQVmEgaA/WNPV/lj0txurWXctr8i+n7U4d3g8mNht8PSeB9
         mExq/+1svcn3AwLR8Uodgb69YIAW7bS4UJNiPXmpvVRCOGgOU/iedJth5DQUrS2b1/ro
         F6IsC/zzInjOOdaXl6UzM5sPtT9E7cfA5aic0=
Received: by 10.236.91.84 with SMTP id g60mr5779138yhf.90.1325837580144; Fri,
 06 Jan 2012 00:13:00 -0800 (PST)
Received: by 10.236.123.113 with HTTP; Fri, 6 Jan 2012 00:13:00 -0800 (PST)
X-Google-Sender-Auth: IMiWVA7rnxSY8Nuws6gZ9AY6FAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188019>

Howdy,

My question is about the Git workflow in a repository which has signed
tags and uses expiring keys in a chain of trust.

When the key changes, all existing tags are signed with the previous
key in the chain of trust.

Do people:
1) resign all the tags, causing people to overwrite their local tags
2) keep all versions of the keys in the chain of trust
3) something else more involved?

Is anybody doing this currently?

Thanks!

Duke

-- 
Jonathan "Duke" Leto <jonathan@leto.net>
Leto Labs LLC
209.691.DUKE // http://labs.leto.net
NOTE: Personal email is only checked twice a day at 10am/2pm PST,
please call/text for time-sensitive matters.
