From: Cord Seele <cowose@googlemail.com>
Subject: Re: [PATCH] fix alias expansion with new Git::config_path()
Date: Fri, 14 Oct 2011 16:42:03 +0200
Message-ID: <20111014144203.GC13680@laptop>
References: <4E982B27.8050807@drmicha.warpmail.net>
 <20111014142557.GB13680@laptop>
 <4E984781.6050601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 16:42:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REixg-0004bh-VR
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 16:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049Ab1JNOmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 10:42:08 -0400
Received: from mail-dy0-f46.google.com ([209.85.220.46]:46147 "EHLO
	mail-dy0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab1JNOmH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 10:42:07 -0400
Received: by dyf4 with SMTP id 4so134928dyf.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Xj3gl1zf/R4fdrzmwTqXsYE0pjkeHeg/jQ7remP+eTk=;
        b=XYlThDMmBdRgrv2Z2+/xlrKdTO8UUfHvICb2hkoGACG4qyv4rzXWczafdju3qpVMRJ
         cwYLPYjVXgcDl9co6H2g4875Md/Ysv7Xezs5IM1hkplwIjNsEim86mXXtgUaaDeLGK0W
         weYFG99jXc0sWjG1jnWg48uO4yFcj4JPnUpXE=
Received: by 10.223.15.147 with SMTP id k19mr4511835faa.26.1318603324834;
        Fri, 14 Oct 2011 07:42:04 -0700 (PDT)
Received: from laptop (p5B306939.dip.t-dialin.net. [91.48.105.57])
        by mx.google.com with ESMTPS id n18sm4056514fah.2.2011.10.14.07.42.03
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 07:42:04 -0700 (PDT)
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <4E984781.6050601@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183580>

On Fri 14 Oct 2011 16:30:25 +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:

> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>

Great.

> Thanks. (Though I'm still wondering what this is about overall.)

to make '~/' work in sendemail.aliasesfile

-- Cord
