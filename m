From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] [PATCH] Provide a window icon on Windows platforms
Date: Thu, 31 Dec 2009 21:12:18 +0000
Message-ID: <a5b261830912311312if3d71aax5bb693a907dc5c0f@mail.gmail.com>
References: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Kirill <kirillathome@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 22:13:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQSJl-0005oF-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 22:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbZLaVMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 16:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbZLaVMV
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 16:12:21 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55755 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZLaVMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 16:12:21 -0500
Received: by ewy19 with SMTP id 19so4965309ewy.21
        for <git@vger.kernel.org>; Thu, 31 Dec 2009 13:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Vw9yqAIJ1XvkjyJ712IcD2TRYdqI9RO4VtVghu9VfWE=;
        b=IsBb3lokVepI2YcOXLVSHoLoLx1+wckFhzMQOPwJhK8IfNaVqscgWPoosCz+LZJp7Z
         ZP2h7qjeK8ngnUE9gTVmr6p1wgj9rkqJ5ONPjg5bI0BjM9aqd7AbzR3lCuY+Y4h/CeqK
         oj2UNL8iksJIdO4H2n+z4KNn3+02/k0+2aOKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M4uzCz9vQmnKuRHeIeIm3IjW1lSMkGK3vUf5QWVlnyVfBFwNy/59kggHJw8Y/eIoM8
         4KyHuiWYY5HL0WOiGRiq2vJ30qWV4Xgkm/iHV3qXf9qgN9M5FjubJwP066oGzamgePr3
         USBmrQPlCp0/IRVqSH/xeTj4sCiziQc0n4lYQ=
Received: by 10.213.104.10 with SMTP id m10mr21664731ebo.62.1262293938682; 
	Thu, 31 Dec 2009 13:12:18 -0800 (PST)
In-Reply-To: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135975>

2009/12/31 Kirill <kirillathome@gmail.com>:
> Looks like 37871b73 by Giuseppe Bilotta does not work very well on Windows.
> Instead of a former tcl/tk icon, the window has a black square as an icon.

I've been using versions of gitk on Windows with that patch since it
was applied in March and it has been fine. On Windows XP and Windows
7. So there is more to this than you are telling. Are you using
windows via remote desktop? There was a patch committed to Tk a while
ago about the program icon displaying as a black square over remote
desktop. If so, this requires an updated Tk and not a patch to gitk -
tk 8.5.8 should be ok if this is the problem.
