From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unable to clone an ssh repository (with ugly installation-specific workaround)
Date: Tue, 12 Feb 2008 00:16:11 -0800 (PST)
Message-ID: <m31w7iegk6.fsf@localhost.localdomain>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:16:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqJu-0001kf-2J
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbYBLIQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYBLIQP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:16:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4520 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYBLIQO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:16:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so443455ugc.16
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 00:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=dY+NpGFJUdQwHfcbi25CIQnWfNvqcCjLPQtGKoFDylU=;
        b=XxqY8A1XTSVOIIn+CSeODDTBioEl7L0ZnhBXHlnbA4K2darEkPgJutRz4a55Z4oXGQg1ZD69v2uUzLHE+rULw1fOXzJOV31Vbc6eu8QpA5cDPVNkU+fkzXawXQrbCVjmVSjWruCfzu4b/6gIXY8/JEKJ5CAoSv2WY4vP7aNNhWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=FhKLbEmph7Y3lK5q8FhaoBOpVmOGSSaFm0cABId0VjwtCDBhhCu0UwdhiPnOJbEHTBK67lw8YyeYgi9ufp3S5jJs87CAe8RVAN4aUO2IzuSY19aUBrv1aiJtwFCuJI1vwx5lkkBGZQU//UtMNl118GLHnk735Ze0I2bki0ibESA=
Received: by 10.67.115.19 with SMTP id s19mr251862ugm.70.1202804172947;
        Tue, 12 Feb 2008 00:16:12 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id u6sm9241500uge.83.2008.02.12.00.16.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Feb 2008 00:16:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1C8FlFb022820;
	Tue, 12 Feb 2008 09:15:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1C8FbgC022816;
	Tue, 12 Feb 2008 09:15:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73635>

"Elijah Newren" <newren@gmail.com> writes:

> I'm pretty sure this worked before, but with git-1.5.4, when trying to
> clone a repository via ssh from a machine that does not have git
> installed in a standard system path, I get the following:
> 
> $ git clone -u /home/enewren/software/install/linux/git/bin/git-upload-pack
> ssh://enewren@remote/var/scratch/enewren/votd
> Initialized empty Git repository in /home/newren/devel/votd/.git/
> remote: fatal: exec pack-objects failed.

git-pull(1)
[...]
       --upload-pack <upload-pack>
              When  given,  and  the  repository  to  fetch from is handled by
              git-fetch-pack, --exec=<upload-pack> is passed to the command to
              specify non-default path for the command run on the other end.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
