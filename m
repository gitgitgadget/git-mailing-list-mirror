From: Elliott Runburg <Elliott.C.Runburg.1@nd.edu>
Subject: Starting on a small project
Date: Thu, 8 Oct 2015 17:45:49 -0400
Message-ID: <CAAWikH5JJ2RSN-QaY2G2_N7ccSxvQm_GfT1u8-FXc2p7dcqRbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 23:46:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkJ16-0001oj-Nz
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 23:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbbJHVp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 17:45:57 -0400
Received: from mail-msa5-prod-v.cc.nd.edu ([129.74.13.14]:16765 "EHLO
	mail-msa5-prod-v.cc.nd.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753816AbbJHVpw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 17:45:52 -0400
X-Greylist: delayed 4409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2015 17:45:52 EDT
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com [209.85.218.43])
	by mail-msa5-prod-v.cc.nd.edu (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t98LjnsW009857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
	for <git@vger.kernel.org>; Thu, 8 Oct 2015 17:45:51 -0400
DKIM-Filter: OpenDKIM Filter v2.7.5 mail-msa5-prod-v.cc.nd.edu t98LjnsW009857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nd.edu; s=msa-bulk;
	t=1444340751; bh=GKbKHWHTme6UhDgu6A8lzA5F8epXGMm5oV8nECofpMI=;
	h=Date:Subject:From:To;
	b=n27XnX5IQsP/Zcx/o+2YadkkI+F8mA7wHHUE57hkqv7cxCKIa4UPUX/mtAhOg68DV
	 ofuusmYk1bX7AjZxcYLWSmpWBNGSJiSuPOwhbtJmBeruw3gKfHphCCv4lnhasOONVS
	 QhrGgTJlLg1+ZGekZjQBUMjt9965i1bxk4g0+bWQ=
Received: by oigi138 with SMTP id i138so12551778oig.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 14:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=GKbKHWHTme6UhDgu6A8lzA5F8epXGMm5oV8nECofpMI=;
        b=PKP2uvKPIE42XORfgbmAvXCENeCvXsvp0SkMNsKfEZ7D5tYHGrnWyKUxxY+To4dgfX
         1Xl1l4Cstfzjsy5Z7wbNopLQTWYsrFfP2vO3bT3mvD0mA02qYXXcLtIFCQibv6dWXexd
         84HHPbiJ5E3dJNnk7DIM+3HdP+afEelElkOmawbFXTs3ewCBQSJ+/lRNzYGnkzCX2Otq
         ZIf88DcHdSsaw1CKsmHSlFVx+5ABUhtck+56fnI0BhBQds7JYjK4cY5zxg8iOyY2olc7
         UaTsnd0f+jPmzY8FBx0B/QobIZBk1/lOxU+x0GqWrGYcuRv068YQTHSHt3dXoljaoPDH
         0xvA==
X-Gm-Message-State: ALoCoQkEOgPwlyMC6Ha5l6DSk/hcnkUxayA6iwTb4B2WoEt8R8greXDwMZLZoNFYs85NSNZWLzuybNIe54o+huTcbaoJwoyk+3pWE3+5JYH7MtryWu920CDTWX4bdOazgapL5Op3eUDF
X-Received: by 10.202.217.194 with SMTP id q185mr5926103oig.29.1444340749664;
        Thu, 08 Oct 2015 14:45:49 -0700 (PDT)
X-Received: by 10.202.217.194 with SMTP id q185mr5926094oig.29.1444340749504;
 Thu, 08 Oct 2015 14:45:49 -0700 (PDT)
Received: by 10.60.25.40 with HTTP; Thu, 8 Oct 2015 14:45:49 -0700 (PDT)
X-ND-MTA-Date: Thu, 08 Oct 2015 17:45:51 EDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279279>

Hello all,

I'm interested in contributing to a small- to medium-size project,
preferably something regarding data structures. I was looking back
through the SoC ideas, and saw in the 2014 page the suggestion to work
on hash-object. I was wondering first if that still needs work, and if
so, if there is somewhere with more specifics about what changes
should be made.

If this doesn't need work anymore, are there any suggestions for
small-ish projects regarding data structures?

Thanks,
Elliott Runburg
