From: Parag Kalra <paragkalra@gmail.com>
Subject: Making Git untrack few folders
Date: Sun, 12 Sep 2010 03:22:40 -0700
Message-ID: <AANLkTiktMe190OVPrTXMtmfaLRLXeJBZ4vSZewJecQWe@mail.gmail.com>
References: <AANLkTi=vjueuP66BAMsRDww=J3Nq3Q4BooKF+85khcBn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 12 12:23:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OujiF-0000Rw-QM
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 12:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab0ILKXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 06:23:03 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54628 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab0ILKXB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 06:23:01 -0400
Received: by qyk33 with SMTP id 33so4296217qyk.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=Hg4G1PxUQ5wMa9MB/2PWeS4Orv5snIhyi39rjkykEuM=;
        b=wNJ19jZh/s2Ef0ryVgY+PaZ5dEDc2QJM2Bfawa6Q1l08W45geitMDDoMiRAkU9iE8t
         k98TteI03PtrokhldIMQLiLyi34nLGPvpRxf4xM6PnszYqzYj0I6ZLPE0n/ObV7yopFR
         jV7No9+IEaSkbtcPi3dbUu9GgjD1WpqI16WVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=kTJMa1FK/QLsfT+msU23MxvCCLFE/GLbswXFO62hYIvNltLiNVqQ+BIToWqctP7jmE
         oYV1yPXtgILxaujdF8MfHXwiZp4JkzSkNmyjruAp7F9Io0Z0xM9HoEMq86YGG82BrwCz
         CCU1bBDqZ1kML6/zQvszw+Fbo6hK+GE6pJJAQ=
Received: by 10.229.224.67 with SMTP id in3mr2189711qcb.91.1284286980285; Sun,
 12 Sep 2010 03:23:00 -0700 (PDT)
Received: by 10.229.248.149 with HTTP; Sun, 12 Sep 2010 03:22:40 -0700 (PDT)
In-Reply-To: <AANLkTi=vjueuP66BAMsRDww=J3Nq3Q4BooKF+85khcBn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156029>

Hi All,

I have couple of interconnected questions:

1. Is there a way I can make Git not track a particular folder in my
working code base directory. For example, I have a tmp folder in my
local code base and I don't want Git to track whats going on inside
that directory.

2. Accidently I have added this folder, committed and pushed it to
origin master. Is there a way I can remove this tmp folder from git
revision history and at the same time keeping it intact in my local
code base directory.

Cheers,
Parag
