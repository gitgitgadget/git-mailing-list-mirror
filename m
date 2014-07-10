From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Fri, 11 Jul 2014 00:12:55 +0200
Message-ID: <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross> <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross> <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:13:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Maz-0003mK-7K
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 00:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbaGJWNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 18:13:37 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:64422 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbaGJWNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 18:13:35 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so270754oac.22
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=091HfyN0h21kZIlx6Qv6hyJnPIN0umYH1HwUZJBDdZM=;
        b=QuReEuPj2m1OPxbN3l49zP1wFixDhKRRKUAw625aCSitORrZGPi0ubQ5VxfoRyVBSC
         GS+wcYAqJD7wXX3Az3jnueRY5h7TIu6NWTEmgbLPH0NNF8voCvZIDR+BHklEtdcfK7yS
         7JITXU52VBieWuA/DLydk328LMAslB9I7eCkYKzybv1+zeEiiHjkI9wWCt9mMVdHU/92
         i58hIATY6LpQVGSx9AZGVoYk8bkJJf/S42g9Zk2deivCY2Lx53rUE4vBc4/11CFPcw+t
         yrhDSmCWtjQACztdKZlMTG+wgoMdrXGi0aNVqpFAHwgGjlipAsASG1BXwmZkZZY2ydd3
         jfrw==
X-Received: by 10.182.200.132 with SMTP id js4mr56535268obc.3.1405030415223;
 Thu, 10 Jul 2014 15:13:35 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Thu, 10 Jul 2014 15:12:55 -0700 (PDT)
In-Reply-To: <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253223>

Sorry, didn't test properly when I tried with/without config.mak, and
PROFILE=BUILD was the problem. I had that in config.mak based on
information gathered from INSTALL and Makefile. To be clear, is
PROFILE=BUILD (still) supported?
