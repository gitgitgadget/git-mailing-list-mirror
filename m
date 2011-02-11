From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Adding default remotes to a bare repository
Date: Fri, 11 Feb 2011 13:09:33 +0100
Message-ID: <m21v3eojr6.fsf@gmail.com>
References: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>
	<4D5437C4.6000401@gmail.com>
	<AANLkTimg0YZ7eQ=hsxqSYJPipahLpiqZqSVkFz25=A2k@mail.gmail.com>
	<4D5460B9.9070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 13:09:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnron-0006gT-6x
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 13:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab1BKMJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 07:09:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64956 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1BKMJj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 07:09:39 -0500
Received: by fxm20 with SMTP id 20so2612378fxm.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 04:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=96A9hwhowWia6gRMjpsJ8UvtpyWxxlQDQadSeO+v6jQ=;
        b=qtCPbkUEEAQ3Z/UxI6sEXbtE9Cf22EyvwLWbSPXifA3HPmVIdsHAzjr24ASax2cTQR
         5EC6HUOCCf6aaGJLolOa+QygRJlxle2bCC21XhskNLhtLQasWYKmahFkgllWVsyyAoRV
         UUfi1pXv+blOgsnGjHgom01Nh2UKIHxBjXNC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=YhgGBhtzeOgyvFYDgCllG8+leEj69O56kf25y8fFPMObgyYkVsWA1SztvgArnqphTR
         +98oYNT/EUVumcYtqkH7WIM+e40pNhe0omFX3ZPI/cHXE93JkFXq6kJY7uD59sh7UjDN
         rCfFAIiinlEWM63O7+Sv7fsUO4Le+BbZxtlfg=
Received: by 10.223.96.6 with SMTP id f6mr405989fan.22.1297426178493;
        Fri, 11 Feb 2011 04:09:38 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id o17sm318333fal.1.2011.02.11.04.09.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 04:09:37 -0800 (PST)
In-Reply-To: <4D5460B9.9070300@gmail.com> (Neal Kreitzinger's message of "Thu,
	10 Feb 2011 16:03:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166554>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

[...]

> you can do some hook setup automation using git templates.  see the
> --template option of git-clone manpage and 'template directory'
> section of git-init manpage.  There is some big reason why they don't
> let you inherit hooks from the origin repo of the clone repo.  I think
> its basically because you could have security risks or compromise git
> integrity/workflow with hook inheritance.  If you look in the
> newsgroup people have talked about this alot before.

Ok I'll look at what have been said.

> As far as your request for automatic remotes, a flaw in your logic may
> be that you think the functionality you want would let you clone from
> an already-setup clone (1) which points to remote (a) then the new
> clone (2) would point to the remote (a) of clone(1).  Not so.  When
> you make a clone it does get an automatic remote to the repo it was
> cloned from.  This is called 'origin' remote.  Therefore, clone(2) has
> an origin remote to clone (1).  Your idea on automatic remote setup is
> in direct conflict with the way git currently does automatic origin
> remote setup.  You can't do both because that would turn in to a real
> mess pretty quickly.

I don't understand your last sentence. Why do you think it's going to be
messy ?

Thanks
-- 
Francis
