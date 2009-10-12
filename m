From: bill lam <cbill.lam@gmail.com>
Subject: Re: meaning of HEAD in context of filter-branch
Date: Mon, 12 Oct 2009 18:41:39 +0800
Message-ID: <20091012104139.GB3937@debian.b2j>
References: <20091011024357.GA9021@debian.b2j>
 <m27hv2s22f.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>, bill lam <cbill.lam@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 12:46:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxIQ3-0000ce-S2
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 12:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132AbZJLKmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 06:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbZJLKmV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 06:42:21 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:58120 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbZJLKmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 06:42:20 -0400
Received: by pzk26 with SMTP id 26so7982515pzk.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 03:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Qsdl2RU7rnCCIlZrbApH0p3KaDDDzZeu4UHERtIutFg=;
        b=F2zOmUbc8S2dKCFFvl8jG168sH6l0gLpZEaP1dIlgHVRi6Sg6rvcpZVZMYiehmpPTB
         T6DqXCNaI7OB9rhrKu0BWDYF0sS+i46Ahfa5pTkwo8vfyZkV/MGyftkbfbF3Q9r2tXmR
         KmwBZdt6jSd/xCwOBXf+oY0C25YBeF85cLFyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WyQJvff3vqUj4RMFqNZoRN0BSCwNWFwCK3Aadl4XAaPvV9Nq0bJvVWoI5WImks3vcr
         WDO2LB/9WLMYsv/KjsD//WWLhrn4864xYJRf3E/ZJuJeuQRdyFNH3usA7mxOXMQu5yIH
         lOZjOgj7eAjr9+sKzpoPykp65FI4jaOzUizUk=
Received: by 10.115.98.29 with SMTP id a29mr9630671wam.142.1255344104742;
        Mon, 12 Oct 2009 03:41:44 -0700 (PDT)
Received: from localhost (pcd632137.netvigator.com [218.102.164.137])
        by mx.google.com with ESMTPS id 20sm29532pzk.13.2009.10.12.03.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 03:41:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m27hv2s22f.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130002>

On Sun, 11 Oct 2009, Andreas Schwab wrote:
>        reasons). Prior to that, the $GIT_COMMIT environment variable will be
>                                     ^^^^^^^^^^^

Thanks. This is what I should use.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
