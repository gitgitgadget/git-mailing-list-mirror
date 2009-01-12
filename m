From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 10:17:07 +0100
Message-ID: <81b0412b0901120117mf010317m79874a235e29a439@mail.gmail.com>
References: <200901120246.28364.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:18:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIwN-0001YO-PQ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbZALJRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbZALJRL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:17:11 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:36916 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZALJRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:17:09 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3374415ywe.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6U2j6QL0J93EMGo/zRrAoAQaSoLvMiwUcZwAU74pHBA=;
        b=W/BHzLYjWw5X2d1ReeO6iJxc/xHHuYOOQYzgryH9JCzX+zk8BEaBenm+CcdLsusgH5
         uWX7WB2C9OGCVw6UJD3PrF/jcP+NUzWDsVq2e1W34b8YfTPs8tPqqIRvIRXTmNGI/u60
         1X14zxMmjXF3citeAY79tFd9KKt5bcRvmXRnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=p6jSX5L8+0HhZH5hcshHljOgtiH/p782tvEnqowwH9WIe/283CLlsciEFGDTHIthZE
         tzUByF/r8Z3NlLuKzGmmaZ3N4+GTaclEg2d3CIPCJ59AogbVMJmUc2TV21eLwilrDIpI
         68cklXY0wIiP16h7s3EB1WSY3LiH3PQAkPw2A=
Received: by 10.100.163.15 with SMTP id l15mr15011651ane.128.1231751827740;
        Mon, 12 Jan 2009 01:17:07 -0800 (PST)
Received: by 10.100.143.19 with HTTP; Mon, 12 Jan 2009 01:17:07 -0800 (PST)
In-Reply-To: <200901120246.28364.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105309>

2009/1/12 Jakub Narebski <jnareb@gmail.com>:
> Do you have any suggestions to bypass this block for git? I have access
> to Linux shell account (no root access, though) which doesn't have
> problems with repo.or.cz, so I think I could set up SSH tunnel: but
> how? And what to do with access via git:// - move to SSH too?

See man ssh, look for -L. It works for arbitrary ports, so you can redirect
git:// port to anywhere. Same for push over ssh, just give another port when
connecting.
