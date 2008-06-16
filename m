From: bill lam <cbill.lam@gmail.com>
Subject: how to track changes of a file
Date: Mon, 16 Jun 2008 18:46:49 +0800
Message-ID: <48564499.3050008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 12:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8CFa-00086U-Lc
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 12:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbYFPKq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 06:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbYFPKq6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 06:46:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:34976 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbYFPKq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 06:46:56 -0400
Received: by wa-out-1112.google.com with SMTP id j37so4297167waf.23
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 03:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=W97R9pbKaIUhyrMNK3uGlIoPef3M23wvEK1losZZuVM=;
        b=mECwhLKP/Tl1+VZwyyYIzfaNkOn6OG2JDAhGaQEI3E3hMzvcY4RxQXiiHlYJwzduE+
         GXmb0UReW/hDOPVJpgy6AUzucah3DPMswFuvIhfe1jVJF8ts3MF/IIROImW331r7g9Kl
         TPq2M5s+oo5qkhlhfhMrwvJqM++EHIomw89aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=mTLgFAVzn69UhmEYLdp73IYJo/a/kwtPHnLqf6kY83l+z4hKFJx7pG2cfrTReFkcfr
         q/Kw9vMbHP+Uc1OmBgndgrxvw85FIg5yb2yc6BsYm2F26L4U7Wvpm9pn7Vsg9Wyy0Hp7
         2rdkq2ogVD9HwkjhQowjPo4ZOgoRTq9EbesgQ=
Received: by 10.114.135.1 with SMTP id i1mr5970089wad.5.1213613214193;
        Mon, 16 Jun 2008 03:46:54 -0700 (PDT)
Received: from ?192.168.1.201? ( [219.77.26.32])
        by mx.google.com with ESMTPS id n38sm9114512wag.24.2008.06.16.03.46.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 03:46:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85174>

I want to see what had been done to a particular file, so I started with the log,

$ git-log --no-color glinvc03.ijs |grep commit |head -3
commit 23335cf4acadb9f09410f106adbcc2b190fe9c70
commit 31e4f2c519caa9afa2e29ed8ffb40deb62aa972f
commit b515f020d05f2967a7283751c8dd3740de7136a4

I want to know how to,
1. cat the content this file for these 3 versions
2. show the differences between versions,

I use vim to view man page, and git-log without redirection will invoke vim as a 
man viewer.  Does git-log always use man?  Without the --no-color option there 
will be some "33m" prepending to some lines, is there any global setting to turn 
off color in git-log?

regards,
