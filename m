From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/5] Add string search routines from GNU grep
Date: Sat, 13 Feb 2010 16:56:24 +0100
Message-ID: <4B76CBA8.5060504@gnu.org>
References: <20100213141558.22851.13660.stgit@fredrik-laptop> <20100213142038.GC9543@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 17:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgKU7-0003VC-JA
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 17:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040Ab0BMQEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 11:04:37 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:61255 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0BMQEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 11:04:36 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2010 11:04:36 EST
Received: by fxm27 with SMTP id 27so60074fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=f9s5Uyl92YZcdbDuA0Fh3vP0p+KhC9Xnsjph1VoW9RE=;
        b=rmpsUtMOPGLMc2WDDGfNYSDOvOHyiqi+A4iij+zR3HbsxpE3XMg2uCOrnqUgoJwdXj
         Rs0rmfAmkHfWgi9EWOBicEExp8YWAciTdMp5NMUtM0r01lS3aZK7THdgXs64SzVr6mlX
         Swl0PzrVuRCbkmczT3Yt/3JQHbWQ/8E8fUCgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZBxFSf2WnD65ylO9g+g2UV33YSqJ5yV1TOr8FgbJvGu8pYGUVyd2G+3gW2aDORmaee
         zO6TtufHHIHbFcqj+JUHWkA7KIHGmpxzF6sWHmQ8Uwpzz9QJuPXRqFcLBtsp9LQsVfqu
         A96aqd5vgkKvYgCnC35i4jVI99/D0uASBGYYo=
Received: by 10.223.3.196 with SMTP id 4mr3245265fao.63.1266076588789;
        Sat, 13 Feb 2010 07:56:28 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id g28sm7331561fkg.8.2010.02.13.07.56.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 07:56:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100213142038.GC9543@fredrik-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139809>


> +   This program is free software; you can redistribute it and/or modify
> +   it under the terms of the GNU General Public License as published by
> +   the Free Software Foundation; either version 3, or (at your option)
> +   any later version.

You need to use the last GPLv2 version (commit e7ac713d^ in the GNU grep 
git repository).  It doesn't change anything except the copyright 
header, but let's do things the right way.

Paolo
