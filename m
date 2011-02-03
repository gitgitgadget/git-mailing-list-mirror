From: Endre Czirbesz <endre@czirbesz.hu>
Subject: git to p4 conversion
Date: Thu, 3 Feb 2011 13:52:33 +0000
Message-ID: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 14:52:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkzbz-0004CF-JY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 14:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170Ab1BCNwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 08:52:34 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55860 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399Ab1BCNwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 08:52:33 -0500
Received: by qwa26 with SMTP id 26so933792qwa.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=PYR22eArbkBED+FxaGoLAVEcM6GCuMGmkqre7aW8Wt0=;
        b=qyXXEdT2ewfpQf7SvsAbfXTBY/bkKHT9AWghDownZbqJ097vtmjE8NqvXglQ1uCJwi
         mDLfNqjbmlrz5hW59uX/jb0zAkSqCpChVp6ELj0ve8b58DvpjPQ3AXF/Zbn3nTBCLNBd
         7TXYhkFv/h6ydMdr0Nag7vwHw6t3nBqSc7tXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=KKsB/aVTfYck3YN3lMoxnQucappaeDY4NdE1AAiwlKBCy2UzSkQEOK5wMkCZSPZCM5
         hQLioTuH3g/lJcQ1Z1PDFBcwCSm16YaI2qD9GtA/afuxQPSDV85oo6z0tn1sdXDTIUp0
         OSCfGdcFmW9qLb4Vv/YXD9+T6qlzbM/oCapw0=
Received: by 10.224.20.81 with SMTP id e17mr9768508qab.135.1296741153351; Thu,
 03 Feb 2011 05:52:33 -0800 (PST)
Received: by 10.229.67.26 with HTTP; Thu, 3 Feb 2011 05:52:33 -0800 (PST)
X-Google-Sender-Auth: piLvH3bvpGdmgzSaDfheoWLAgqM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165972>

Hi,

My company is introducing perforce, and the policy is that all source
codes should be kept there.

I have some small (and flat) git repos, which I would like to migrate
into a perforce depot keeping their histories. I tried git-p4 without
any success, and I did not find a good manual for it.

Is there any step-by-step tutorial out there? Is there any living human
who ever made a successful conversion in this direction?

Thanks for your help in advance.

Endre Czirbesz
