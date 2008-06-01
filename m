From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v3] perl/Git.pm: add parse_rev method
Date: Mon, 02 Jun 2008 00:51:39 +0200
Message-ID: <484327FB.8080105@gmail.com>
References: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-2-git-send-email-LeWiemann@gmail.com> <4842DE78.7000006@gmail.com> <20080601215449.GC29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 00:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2wPk-0008Sg-KU
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 00:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYFAWvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 18:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYFAWvn
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 18:51:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:57188 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYFAWvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 18:51:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so592503fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=8i98UYUix96iOt78FVvPE0oYZCknVnPc8Rafpr4lqCk=;
        b=xgXQ/tBmhV+fHCLfLC50W/J5wIcSmwi8beBFgCngYKNfsZihaFEzEjoAZwhiHUedxohGaqW8z9xcGIEMOZjPSqM/bhJPY0w2E//J6RD+5VGoFZf2yPpWRTq5aWIKmLjAk3h+8Tv+9zXyeypwsL53u3KjJGk6TF/Y3LSksWTQ820=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=pHoWTCb7NbfItYx8UD+4UqOQzEe+GrK50F9g/IuxhoUeBwUybLo9b5/aeLm3rt3P36//VRC2FzleXjz1K+QLJj5J8mK8dfxSkogA4iicsgkKGQTyQMqTWyTg2Kw6j744Q6q+DTfzCpYfgRebIrrpa4EqT+BZp1FxCMJWUITfA/Y=
Received: by 10.86.49.3 with SMTP id w3mr819663fgw.64.1212360701496;
        Sun, 01 Jun 2008 15:51:41 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.205.25])
        by mx.google.com with ESMTPS id d4sm2834400fga.8.2008.06.01.15.51.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 15:51:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080601215449.GC29404@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83476>

Miklos Vajna wrote:
> Lea Wiemann <lewiemann@gmail.com> wrote:
>> Is there *any* name for the identifiers you pass into git-rev-parse
>> (like HEAD^2 or master:test/foo.txt)?
> 
> `man git-rev-parse` calls them "revisions". Yes, even the commit:path
> ones.

True -- it's quite cringeworthy indeed. ;)  As long as it only affects 
the documentation for that particular method, I'll go with "revision".

-- Lea
