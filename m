From: Adria Farres <14farresa@gmail.com>
Subject: --trust-exit-code not working
Date: Fri, 14 Nov 2014 17:12:35 +0100
Message-ID: <20141114161235.GA30086@vimeitor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 17:11:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpJSj-0005BL-PP
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 17:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935261AbaKNQLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 11:11:00 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:49819 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934727AbaKNQK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 11:10:59 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so19843769wgh.34
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=ZI8qs1Eclw5aIzoBUvDdwq6th183Cahcec9n+W4bmqM=;
        b=x0UVvu/sdoYwb0cTcp6faMq+rPkCk5tLU4xABrK7rS027YLmnLtDSZy30xyanr5eX+
         uG/K3ED4p/TpaEaqUHplJk/seys77U9fWvqXcfAKYUXcXLFmd1FWjZ9HWRnZQMH19TAy
         UoSeCh4XPPOHAeVrDMtOdIyx9ARSMC0TnvbvIiIplyjgMew2354vjoOWm8NFHIlYdcEW
         jDS/0DSuXzpFDTuha1FqivOY/adnZYM2BEMd6kpFyTd++HeZ9bhltd8KxQ0360pFD6QN
         uqy2WoVV0tLHouBsj6kEtH7suXRvWyB8L6HMoIALX6/hCohOdF7qsEGIiCFum1T06aSB
         Wjbw==
X-Received: by 10.180.93.37 with SMTP id cr5mr9062476wib.76.1415981458431;
        Fri, 14 Nov 2014 08:10:58 -0800 (PST)
Received: from vimeitor (194.Red-88-17-200.dynamicIP.rima-tde.net. [88.17.200.194])
        by mx.google.com with ESMTPSA id pf4sm29094819wjb.36.2014.11.14.08.10.57
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2014 08:10:57 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!,

I sent an email last week, but I'm not sure if I sent it incorrectly, or the
formatting was very bad, or it went unnoticed. A few days ago a great soul was
kind enough to create the --trust-exit-code option that made git respect the
exit code of the difftool. Unfortunately, I haven't been able to make it work.
Exiting vimdiff with :cq doesn't seem to make git quit, as it keeps pushing new
files to be diffed. I tried meld and the exact same thing. I'm confident that
exiting with :cq gives an error, as I have checked it, and I'm using git
2.2.0.rc1.

Am I missing something important? Has anyone managed to make it work with
vimdiff and meld? Sorry for bringing that up so late and for being a
disturbance.

Thank you,

Adria
