From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Date: Thu, 31 Mar 2016 09:49:44 -0700
Message-ID: <20160331164944.GB11150@gmail.com>
References: <01020153c222ebc0-a691d562-ece3-4b35-908a-a0487e912879-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Harish K <harish2704@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:49:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfn7-0002UF-P7
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbcCaQtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:49:49 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33870 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcCaQts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:49:48 -0400
Received: by mail-pf0-f177.google.com with SMTP id x3so73282223pfb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9BG8GE68ytc8u1fRe3k8SeKhw7Vr1KVLZtJZS5qOCI=;
        b=ViyScIWTdwuSAfxxp97mEnR1RLObow5RlD75pwggrAZ67vZd7cnnZz6Doq59iQeaJG
         +CMWrMZsMBcKzwOL5pWyUnVdkd3F8BlyAy4n5mV3+4oIRpVsPU+C9I8EEUmFoTMzxh7Y
         uVU2irNMU2RSAlJ0D/5noR+wS6g0Qg4Q0aKZ1J4jxD7kLtqPL3oIPYPmNUHC64uOQsBE
         i0xqRLQSNQ+bFbSM6jeIpcBhWevjubWgLyDmESgR1VoN85o13knEAg3OrWcncsIacqJR
         VQfbu9JZDhDngImdEPD8lQH+dPmCbaDwA9nfgkU3vBZ+qMjhhc1Uosdd4bfjvaUFXbGm
         4yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9BG8GE68ytc8u1fRe3k8SeKhw7Vr1KVLZtJZS5qOCI=;
        b=Ys76WCC8A97Sad53h5N4+bcLv9MqAVq/LE8fsGnJegSHdq0SuJ5RqZE8b4MaZivYvA
         ZLwM39YYqIA1Hiw598OGlzzDWMK988wZTcwKaf65+XCp9P04ZzZWnSzAckAjLKBew2A4
         aGApyDU+hbg35nySq5bKeD7KYmRT7+2IQKPgSaKF80Zo/WDYiqV+WEYXOXPZlFD6PHYM
         8cEPQQ2YhWyrSIwudCPFvt4SrdDViGD7LhC6sSDNAWGx5eVhrj6VfphhXPs4coAbGTyr
         uB42bYNq+7COj39MbsjXdPVSLLo5I+JdSY0YdZuZ5M+IG68kG+6crKL0CL2hj9YHhj8s
         ctzw==
X-Gm-Message-State: AD7BkJIt1lej1Bdcc0dfe5dm2c5AS+nfdbuzyXC89btkH7cGM6ZcILKE4g0jr3rSf1IQdw==
X-Received: by 10.98.15.142 with SMTP id 14mr23573985pfp.6.1459442988212;
        Thu, 31 Mar 2016 09:49:48 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id f8sm14655469pfj.49.2016.03.31.09.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2016 09:49:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <01020153c222ebc0-a691d562-ece3-4b35-908a-a0487e912879-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290418>

On Tue, Mar 29, 2016 at 11:29:41AM +0000, Harish K wrote:
> ---
>  git-gui/lib/tools.tcl | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)


I forgot to mention that git-gui has its own repository.
The git project merges the upstream repo as a subtree into its
git-gui directory.

You should probably clone the git-gui repository and create a
patch there so that it can be applied to the upstream repo:

http://repo.or.cz/w/git-gui.git
-- 
David
