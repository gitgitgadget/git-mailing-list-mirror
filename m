From: Jan III Sobieski <jan3sobi3ski@gmail.com>
Subject: git diff - howto exclude dir from diff?
Date: Mon, 6 Sep 2010 13:13:03 +0200
Message-ID: <AANLkTikUadS+tj3ARdRqo=PSBVhTsJaUxaJv+=4hMf4s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 13:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsZdP-0001JG-Uc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 13:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab0IFLNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 07:13:06 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33656 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0IFLNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 07:13:05 -0400
Received: by qwh6 with SMTP id 6so3707033qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jJ5mqG1QZytRLp26W2e92lF6i+CzMLIux3MGkpBEqWQ=;
        b=wTfhe6gWZP6F2+7bdTbBoX58pvAYsIgkUxLAkVmGq68k/OvmCHSRUUA0KnpGQ+v/jI
         wnHz15Jgefw2KvEm2yQIGs7MIxci4B4F0mYwfJH2cfKsDr7INqez2Bv4pfoKmQjxGoTI
         uthRIgGhpVihEpnpgI+WMHv6LJKbPG9a6mEos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=j5lB3883IZYtZ/6Ja4G2FynYzxOzJxBVNHqGBpIrTAK3jqqT+S3NgJ3Uoaz+S54xTC
         yN1ve0qw7JlcPbjAStsKXmq2+O43ABdI6f/fVk62gtcBSL2yCdBEM8bMBrqVR3PlAA66
         GBzwqlAimAY6/sYDKSz9thUcvKujuqh1RM1nU=
Received: by 10.224.6.145 with SMTP id 17mr854726qaz.140.1283771583656; Mon,
 06 Sep 2010 04:13:03 -0700 (PDT)
Received: by 10.229.229.138 with HTTP; Mon, 6 Sep 2010 04:13:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155550>

Hi,

I wonder if it's possible to exclude a dir from the diff. I want to
get some diffstats from Linux tree

git diff v2.6.35..v2.6.36-rc3 --stat

but without drivers/staging/ dir. Is it possible?

Regards,
Jan

-- 
Jan III Sobieski
