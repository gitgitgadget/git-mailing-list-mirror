From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git rebase -i doesn't respect rebase.autosquash
Date: Thu, 30 Dec 2010 19:37:06 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012301929221.7175@debian>
References: <4D1D1A38.9090305@cs.dal.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Mike Doherty <doherty@cs.dal.ca>
X-From: git-owner@vger.kernel.org Fri Dec 31 01:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYT0I-0003jk-FE
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 01:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105Ab0LaAgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 19:36:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46078 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab0LaAgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 19:36:12 -0500
Received: by qwa26 with SMTP id 26so11558001qwa.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=WSPEh/9OE2UJ6gCWzJRssYU72YmWWvc6mpPUiU1on+k=;
        b=fUyQCFhHQ2TNdKHRFb2syYojLiO2rf7b4SoR10xwIrcIeSzWgutUrLyjCTDm6xMZS6
         MDiyspB3nFVYGfDWjpWd+9TleOhF4p58Q2dn8VrLy5RhrsdCbX8QAYFH/g8/JqzoLGda
         itSA0azHLcQp21GD+hth7B9nI28OPtXemDg9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=rdbg8uB6HwcyX0czs5bfVQ7bNaKT2zjq0B7MXTpDYwWuIJwkPBREbP/v/11luokEYo
         sPFOsoo9NGEuoQvhkrNs/9ww9kmp7zyaQxCE5YwiK4bpk3dELJ+xMrFE+NFh/QsPuoQu
         o40eQ5pLbebGGmBT5gcjnCE0r/LvtWmSMmEn4=
Received: by 10.224.47.145 with SMTP id n17mr15929976qaf.118.1293755771667;
        Thu, 30 Dec 2010 16:36:11 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id t7sm8455688qcs.28.2010.12.30.16.36.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 16:36:10 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <4D1D1A38.9090305@cs.dal.ca>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164375>

On Thu, 30 Dec 2010, Mike Doherty wrote:

> Hello,
> 
> In a git repo, I have rebase.autosquash enabled by default (in
> ~/.gitconfig), but whenever I do `git rebase -i`, that setting isn't
> respected. Is this a known bug, or am I misunderstanding what that
> setting is meant to do?

I also have rebase.autosquash enabled and it works for me. Does it
autosquash as you expect if you pass '--autosquash' on the command
line? Which version of Git are you running?


/Martin
