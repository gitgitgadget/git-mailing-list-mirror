From: David Aguilar <davvid@gmail.com>
Subject: Re: When i run git difftool, git did not use difftool.bc3.cmd,why?
Date: Mon, 8 Aug 2011 04:08:05 -0700
Message-ID: <EC90E9C8-3745-4E39-9627-945CDC7DD199@gmail.com>
References: <24cad567.da0.131a1ed237b.Coremail.sinojelly@163.com> <9c0c497.f7f.131a1fb4855.Coremail.sinojelly@163.com>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?GB2312?Q? "Git=CC=D6=C2=DB=D7=E9=28=CE=DE=D0=EB=B6=A9=D4=C4=29"
	 ?= <git@vger.kernel.org>
To: jelly <sinojelly@163.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 13:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqNlc-0008Qv-OP
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 13:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab1HHLNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 07:13:04 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:57141 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1HHLNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 07:13:01 -0400
Received: by iye16 with SMTP id 16so8830198iye.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=/zxgqkSBAnoqVj1EOPXVlY4kkp5W7txDxmOii0WXra8=;
        b=nAWQfDfAWFsTMW1vpGFnZuyzIDlYQOE7suaCQq97cI/q4Ia/c3RvCO0ibXkE0Rqkcl
         aOtuKPUU9V48lhiYqimb0zg9iRHCc1KKsOCyz+5DeSOg7tloXN+N/+Yt0P9C4jjlcSuu
         R+mPWTHGEonZ6Ng6hD1KJhin9A53I3WIxlds0=
Received: by 10.42.97.134 with SMTP id o6mr293964icn.36.1312801692961;
        Mon, 08 Aug 2011 04:08:12 -0700 (PDT)
Received: from [192.168.1.13] (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id q13sm4160955ibi.60.2011.08.08.04.08.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 04:08:11 -0700 (PDT)
In-Reply-To: <9c0c497.f7f.131a1fb4855.Coremail.sinojelly@163.com>
X-Mailer: iPhone Mail (8C148a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178955>

On Aug 6, 2011, at 7:03 PM, jelly <sinojelly@163.com> wrote:

>> When i run git difftool, git did not use difftool.bc3.cmd,why?>Even i write a wrong exe file name bcomp1.exe, git still use bcompare.
> I found the reason.
> because bc3 is a special name, git call bcompare internal.change the name bc3, it works fine.

That's right. We have difftool.<tool>.path for this use case.  It lets you redefine the path to the tool (e.g. bcompare).