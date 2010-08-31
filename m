From: Matt McCormick <mbmccormick@gmail.com>
Subject: Gitweb: 500 - Open git-rev-list failed
Date: Mon, 30 Aug 2010 23:33:42 -0400
Message-ID: <AANLkTimnz103yX_8YZO4RbmOqdvA-sET78EL5g5LrK+a@mail.gmail.com>
References: <AANLkTinjFNMH+ocDuxx=tkj_pe70RZMkfxBLW4wcLzPF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 05:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqHc3-0006JX-U3
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 05:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab0HaDeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 23:34:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61496 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab0HaDeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 23:34:14 -0400
Received: by ywh1 with SMTP id 1so1959967ywh.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 20:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=DzF82GQk27Ut52BJbLpdV1jqyGbAbQk3fowJlUYk2DU=;
        b=ieuicXwgvpSK6Y024y0gtKQ0HYwSYR2RC0gaFQrABVqFQS04mJpHtdExFJFq2XzZA0
         DPQdgmIx5X4/1Mtfh5XoUlNkLE7uvMqzvILTRvO4kW9viIsKX/M0wWbvSNc/pCRvpsn/
         m+gu01ilG3yHHl6KLp3NQBbTqtOd+IJ0iEE5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=TcCTad7vSDaVYFLhOWEVJQsHcmKFn+GT2oZILr+cdXiIHLSaE21DBeUlWWLDhyCYLo
         6BhqkfJqHMdYwmE6y0RfH3lllFt8Mw64e9vwYTQJmCuv09FRaj0jf9MHsFrGUjuFIK0g
         DsEH/vEmh0f8Nqw16sAHds8JiFLTJ1cbieMvo=
Received: by 10.220.168.12 with SMTP id s12mr3755631vcy.240.1283225652196;
 Mon, 30 Aug 2010 20:34:12 -0700 (PDT)
Received: by 10.220.192.193 with HTTP; Mon, 30 Aug 2010 20:33:42 -0700 (PDT)
In-Reply-To: <AANLkTinjFNMH+ocDuxx=tkj_pe70RZMkfxBLW4wcLzPF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154878>

Hello,

I just recently installed git and gitosis on my server. I am able to
pull, push, etc. to my repositories that I have setup using gitosis
without any problem. However, when I try to access gitweb, my list of
projects is empty. My configuration files for gitosis all have "gitweb
= yes" specified and my configuration files for gitweb are properly
set for the right project root, etc.

When I manually enter the URL for my project, like the one below, I
receive "500 - Open git-rev-list failed". You can visit the URL below
for a demonstration.

http://code.mbmccormick.com/?p=mccormicktechnologies.com.git

Any help that you have is appreciated. Thanks!

--
Matt McCormick
