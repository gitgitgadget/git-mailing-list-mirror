From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git add" and absolute paths
Date: Mon, 28 Jan 2008 05:08:44 -0800 (PST)
Message-ID: <m33asi9jxp.fsf@localhost.localdomain>
References: <916BAC14-A5E4-4666-A29E-2CDF114DCD87@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 14:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJTjn-0007L2-MZ
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 14:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759428AbYA1NIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 08:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759129AbYA1NIt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 08:08:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:17295 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758654AbYA1NIr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 08:08:47 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1702727fga.17
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 05:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=b4ZtEdeLY+bgcOihQ2ZP7JvlakXKIb/6GCmYxLds4jU=;
        b=QMdSe+cdSuiEqnvixmzrb0OLCs/Tlq/hjjkiwvdjamkEZyvGFh6f8uS93U4RaFreDv55zmvmOt/balPHl0FmK9NQmKWencRO/65jQ8pu2pr97t9mRjkgNmyMxScq4wbJ0hNmN3+InbsZY7XmIe0Xxm0Y01XysH5c9/PN5yt++ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Eu36vc3/IJoZb6ozBH+7oSg4d6LWS2IJBpf62gcF9WyXHN+Dophpwn2d36Lf3WiayM4pjqrAJEmoD+D47a+NkFIIGBG0Y2eS51jsd7IfCwCh8qwD8msvFVvNDYEHZFiU/MkeVOkpwdcsgYvWpJZJwc/XqFx8mSmYWxjMsV9PY5w=
Received: by 10.82.161.19 with SMTP id j19mr9704881bue.25.1201525725680;
        Mon, 28 Jan 2008 05:08:45 -0800 (PST)
Received: from localhost.localdomain ( [83.8.198.108])
        by mx.google.com with ESMTPS id t2sm7029515gve.3.2008.01.28.05.08.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Jan 2008 05:08:44 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0SD8aRH018086;
	Mon, 28 Jan 2008 14:08:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0SD8YTn018083;
	Mon, 28 Jan 2008 14:08:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <916BAC14-A5E4-4666-A29E-2CDF114DCD87@wincent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71886>

Wincent Colaiuta <win@wincent.com> writes:

> I was somewhat surprised the other day to see that you can't pass
> absolute paths to "git add":
>
[cut] 
> 
> I understand that you can't add arbitrary paths outside of your
> worktree, but if the absolute path specifies something _inside_ your
> worktree then it seems that this is either a bug or a "usability
> shortcoming" if you prefer to avoid the term "bug".

If I remember correctly this issue was discussed on git mailing list,
and I guess there were even some patches implementing that, but I
don't know what happened iwth them: freeze persiod, troubles with
Cygwin (MS Windows), or what...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
