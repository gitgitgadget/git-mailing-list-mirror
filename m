From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - work around stderr redirection on Cygwin
Date: Thu, 17 Jul 2008 22:41:47 -0400
Message-ID: <488002EB.8080100@gmail.com>
References: <1213462668-424-1-git-send-email-mlevedahl@gmail.com> <487A6780.7030500@gmail.com> <7vfxqdqxh7.fsf@gitster.siamese.dyndns.org> <487A7949.9050800@gmail.com> <487EC2BB.5050503@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, paulus@samba.org,
	git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 04:43:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJfwC-0001HN-PI
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 04:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760811AbYGRClx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 22:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760805AbYGRClx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 22:41:53 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:54362 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760774AbYGRClu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 22:41:50 -0400
Received: by yx-out-2324.google.com with SMTP id 8so63329yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 19:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Pogs0ycl5Q6bg2fkxEoFWuZbAZb6bTXslt84Gpz5tjg=;
        b=ZcDOz9gvmDIeUs2G/5AN6cr8M2gL9Lp8TBmqDr78YL0CYPTIh2ODtxVi0V7wx3jFlH
         y8+J5RHCstvkiBy3OXfzDGi7TFuc8Jv3PT2RkWpSHUjm152kbJsNOtn+wQtHUFOGWZ28
         mTisDA0j7+I54xWinToU59ZAEPFixdfhdDVU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZUAa0pzl/0SQnO6RTthhTJN+DwbjCjHumdR50P5CxZpoUzQamiY2GEBWmymRJTKao3
         0hObGvGej/9/tUol8L1AMAxaDmonf2cRuPWJGCTwobirOQ/29AJeiuUb0zlMpLV+ovJk
         NpDgRWbylR99GRo5T9NCXdsK6rMbwC7EQ2W50=
Received: by 10.151.42.21 with SMTP id u21mr1404740ybj.211.1216348909658;
        Thu, 17 Jul 2008 19:41:49 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.191.242.168])
        by mx.google.com with ESMTPS id 34sm898530yxl.9.2008.07.17.19.41.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 19:41:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487EC2BB.5050503@byu.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88979>

Eric Blake wrote:
> Could you point me to the patch?  I need to roll the Cygwin git 
> release of
> 1.5.6.3 anyway (in part because cygwin has upgraded from perl 5.8 to
> 5.10).  This sounds like something worth me including as a vendor patch,
> if it does not get folded into the main repo.
>
The patch is at the top of this thread:
http://article.gmane.org/gmane.comp.version-control.git/85023/match=gitk+work+around+stderr+redirection

(I'll send you a patch against Junio's tree privately as a backup).

Mark
