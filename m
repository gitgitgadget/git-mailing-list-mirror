From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: How to split a patch
Date: Mon, 28 Jan 2008 10:05:31 +0100
Message-ID: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "gi mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJPwn-0000ff-7w
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYA1JFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbYA1JFf
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:05:35 -0500
Received: from hs-out-0708.google.com ([64.233.178.240]:56908 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbYA1JFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:05:33 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1481912hsz.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 01:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=8F/sFWNTTbISS88QxtDylYYvgvKTpSfDC8YxyFiDYn4=;
        b=lQk7FCSFGiGPCRSDv2hqIQv629HF08hutMONhN3AFCr53wl/HUPHIz26XFwkaHOLniAYECMLI/CvE9pxY6Bx3v+Cz/AhDrpmPfbt+YCb6TjZxCG4mSJNsLbc84SnZ0GYT8kwtqAWUa+YGpPOtKuNjk4CBCBYRt9fDzKHeUiZ+1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E/AyIsDBpmkLCMG6NMYXq5jUA7z5rm4Xqc7RN1HGh8DiRh4mfT9/KpyZ/kxWp6TP2GChBagcXsqMZnP2nlmeXKMh6DjEtfA/iB92durTwcujvaeh4JnOtwefVez6io8gO84km08drpDUeKZGO3fwIWySQj7EwAfEcjdlbP7M2I8=
Received: by 10.143.17.13 with SMTP id u13mr2095725wfi.69.1201511131948;
        Mon, 28 Jan 2008 01:05:31 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Mon, 28 Jan 2008 01:05:31 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71865>

Hi all,
I have a big patch that affects a single file that needs to be split in
a few logical patches.

I know ho to do the opposite process, rebase -i and squash is something
I'm really used to do but this time that trick is not going to help me.

What is the preferred way to split a big patch in a series of smaller patches?

Thanks.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
