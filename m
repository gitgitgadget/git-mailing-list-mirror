From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Fri, 21 Mar 2008 07:49:49 -0700 (PDT)
Message-ID: <m3wsnwuo6y.fsf@localhost.localdomain>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alturin Marlinon" <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 15:50:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JciZk-0007YJ-LM
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 15:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbYCUOtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 10:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754490AbYCUOtw
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 10:49:52 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:15810 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYCUOtv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 10:49:51 -0400
Received: by el-out-1112.google.com with SMTP id v27so1009195ele.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=blLzwSDgzTVGSKcmZGVgxT1dsf0iI98/5ah7NGn8EdA=;
        b=iFVuhpPMmlLZXPQYfLgz6m3KiP/vndqeEZAO4yfsKfU7YsUc5+u6c8wAc0mNUuRkeM5MIUqKZYOIwxhaq/9cUxC7MPep4jOPTb9AGPl/4rzM3SOD+NCswd7cSk+0vwqaw+hwGKmxJfbbKegaF05tF7FzHpR3Rx32jCsDrjHOgQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=NtsR6yfLbZ8vb8lghbpC0d/JLM6BOCKijzA7qJPMrTURp2sOEtUChrMq+b2r5chT4DMXg130Gdhs93fCnM1ur4r86FFrbe5CcDzskWlhFXKv82kjfk4r+dtCq2HMOr7bID6Yb6b3f/FQ7LAmj7BA+JHly1fQeMywQ14Twtvx86o=
Received: by 10.150.199.21 with SMTP id w21mr1616927ybf.60.1206110990311;
        Fri, 21 Mar 2008 07:49:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.99])
        by mx.google.com with ESMTPS id d27sm5504318nfh.2.2008.03.21.07.49.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Mar 2008 07:49:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2LEngoQ010349;
	Fri, 21 Mar 2008 15:49:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2LEngJU010346;
	Fri, 21 Mar 2008 15:49:42 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77742>

"alturin marlinon" <alturin@gmail.com> writes:

> Consider Ohloh, an external tool that provides commit information
> about contributors to a project.

Ohloh currently doesn't make the statictics part of Ohloh code
available: only ohcount[1] is open source.

But there is other similar project, but is fully open source:
GitStat[2]. It is also geared towards using it from web browser;
nevertheles it is worth examining to avoid "reinventing the wheel".

References:
[1] http://labs.ohloh.net/ohcount
[2] http://tree.celinuxforum.org/gitstat/
-- 
Jakub Narebski
Poland
ShadeHawk on #git
