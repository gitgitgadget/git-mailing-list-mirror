From: Severin Gehwolf <jerboaa@gmail.com>
Subject: [Bug] Gitweb corrupting files?
Date: Wed, 12 Jan 2011 11:05:27 -0500
Message-ID: <AANLkTim84sSWr=WRgjiY=Y3Mq7Tgojv9CpLrNjQMJfHR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 12 17:05:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd3Ca-00037D-TS
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 17:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab1ALQFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 11:05:30 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35987 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab1ALQF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 11:05:28 -0500
Received: by ewy5 with SMTP id 5so317004ewy.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=NAWTYUQCgSD83nB1QAisJNXD5Xerj8cWua8rE0qP2wo=;
        b=h13kNyLwc61ZgJ+pVQca8E7DszMIKZcyNZh29kODLGn4ato0PX8GdLwuqAiGqwGayw
         N0aNIcrTeUjUHHOBjKKMwm2NPRBGrr8Z2hlPboXUPC8RzpI2W2sm4o5NOfsPErzIS7DX
         PIDqIMoE6/L7Yy+Ztyv2Ylf/IpxO1ilWYVoAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=sYIzGm2ho811tjzx9mTSNbqhbuv/ZVNtUKMfxVaVr9lk9Lz0/GNftl7KYzLL7f6VBL
         vLrRMalWhzovTxwEws0jpFsYtL1lcWXnB6IIdLIwoEd+ML5lIjTb8KIJAMS8kslDtNBp
         A9XBVo6OyWxjwziim1u6oCIGjyCPJeH+JsR2Y=
Received: by 10.14.48.2 with SMTP id u2mr851472eeb.30.1294848327250; Wed, 12
 Jan 2011 08:05:27 -0800 (PST)
Received: by 10.14.124.15 with HTTP; Wed, 12 Jan 2011 08:05:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165017>

Hi,

It appears that Gitweb corrupts files when it is being used for
creating compressed tarballs of sources.

A more precise description of the behaviour I'm experiencing is here:
https://bugs.eclipse.org/bugs/show_bug.cgi?id=317882

Unfortunately I have no knowledge about the version in use at eclipse.org.

Thanks,
Severin
