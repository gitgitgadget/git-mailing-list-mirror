From: James Pickens <jepicken@gmail.com>
Subject: Disallow amending published commits?
Date: Sat, 21 Mar 2009 10:56:26 -0700
Message-ID: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 21 18:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll5SJ-0001yd-5h
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 18:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbZCUR4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbZCUR43
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 13:56:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:63780 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbZCUR42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 13:56:28 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1016047wah.21
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=AOhCtSRuVRceHXLyUO5pIgTRhk6x4OVEYPvB7nll/Lg=;
        b=pdp8PoJeojIPyKlIjC5UG7vYXe1xCKgH8/tlPDHRBe7HInUCJ4vxD8bromBVuKerKI
         ljZXSgml42qHKIarLB6lTcNgy+/GBIB5Z6DDL3MFCvhlZ6nMAQxlLYLIhTYnJOWzjMWl
         k4VIoV3NuD8ROsYL3d7dLApOnSTyO7ce9/WeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=oh1AIEf6/SAuavs71pLrqFNmfTZd/xwCIHefNvnRGH7HWuhB49zsEgaxpKGEJRYpmH
         TBSJcixGvJpXY+4XL7okcPnW/7uAnHu5mbKnDxeGLenfWZixOhLuo/Iu5NOovNVsrd7K
         frUEsccsY9aNq1xUcLMo98F1JvFyylndKZ99E=
Received: by 10.114.181.13 with SMTP id d13mr3410567waf.109.1237658186844; 
	Sat, 21 Mar 2009 10:56:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114048>

I wanted to have a pre-commit hook that would prevent users from
amending a commit that had already been published, but I couldn't
find any way in the pre-commit hook to figure out if --amend was
used.  Is there a way to do that?  Or any better way to disallow
amending published commits?

Thanks
James
