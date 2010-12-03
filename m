From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-pull.txt: Mention branch.autosetuprebase
Date: Fri, 03 Dec 2010 06:57:12 -0800 (PST)
Message-ID: <m3k4jq3nxo.fsf@localhost.localdomain>
References: <1291364454-9849-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Fri Dec 03 15:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POX4a-00077w-7i
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 15:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0LCO5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 09:57:15 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33452 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0LCO5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 09:57:14 -0500
Received: by fxm20 with SMTP id 20so2265855fxm.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 06:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7YxnZJpQhUbrvgtzzYCW4G/EeLGKWj26pocaB4n6rbo=;
        b=Y4vS0LoWArnkFrEbmzAOqQpFsVLAiiV1BlmRU/vt2gIBpZF4gCZNsAPapMeGdKt19e
         vZci3MDxxAIEvl23T8lJZyBkq97Yc2nw0ujtmV23Ri5tSfOKnjRIwUlB1JANjvIaU+dK
         qNa6Mit4GWzTBO6yzZS5S338zV6XhYfd7lIR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BtnRulRMTdQ+iqqcsMSTyKTv6FJHzYWVItFt+VdiqXeZbWz1476s4EICubnFVbgqCv
         Ve75cefgFcBkbCbMei+uljr7Bf/BfOj/pT6jO/Sk6Usi5tgRq3neGsCBMldZ9EPNBk7s
         cTO4txSc8yHjswIwRCJZ+RXTtFbfZwfZX4nN8=
Received: by 10.223.125.136 with SMTP id y8mr2152616far.149.1291388233356;
        Fri, 03 Dec 2010 06:57:13 -0800 (PST)
Received: from localhost.localdomain (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id a25sm641151fak.20.2010.12.03.06.57.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 06:57:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB3EuYqY021753;
	Fri, 3 Dec 2010 15:56:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB3EuJ3J021749;
	Fri, 3 Dec 2010 15:56:19 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291364454-9849-1-git-send-email-jari.aalto@cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162802>

jari.aalto@cante.net writes:

> From: Jari Aalto <jari.aalto@cante.net>
> 
> In "Options related to merging" mention also related option
> branch.autosetuprebase in git-config(1).
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---

> -See `branch.<name>.rebase` in linkgit:git-config[1] if you want to make
> -`git pull` always use `{litdd}rebase` instead of merging.
> +See `branch.<name>.rebase` and `branch.autosetuprebase` in
> +linkgit:git-config[1] if you want to make `git pull` always use
> +`{litdd}rebase` instead of merging.

Good catch.  Thanks.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
