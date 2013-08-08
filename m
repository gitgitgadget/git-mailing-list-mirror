From: Andrew Ruder <andy@aeruder.net>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 8 Aug 2013 18:00:58 -0500
Message-ID: <20130808230058.GA10058@gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
 <52040F27.4050908@googlemail.com>
 <20130808221807.GA8518@gmail.com>
 <CACO0oR7M90iyDCo-mwoHn21jKRGuMsRWEeWkFXC-MCSUBscC9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Justin Collum <jcollum@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 01:03:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ZEx-00049T-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 01:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966455Ab3HHXDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 19:03:20 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40613 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966339Ab3HHXDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 19:03:18 -0400
Received: by mail-ie0-f174.google.com with SMTP id w15so2976827iea.19
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 16:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=p8SvkkNXMJtCGbwzNJjc9tPmRWixMstVqtfZvHwtnvA=;
        b=nmA4ksxxq3gq41dOKrpUkT4/pPLdvJYpOu9mQTIShWrXE5ttysXpulP3CpFInWyht/
         9wcrdt5/Api4JynvUyJgMESVD6XoGGNF7N38qLpmW5UWEPJwUxYI+Rm5YeZTqrjpnIsg
         jx7454+FvadPEZmyaHOhKeiYiAIB0wJJnrYWvus/o1tnCy3MIGb3ZDctQBacFdm9okcY
         FjvH8ZVP2iKqZhg8wKMNxxtYuA0WbnpW32KiYVvwZVutTgmh/jnPgeTP4VHNQGHKzmpf
         P1+fK65TapJbNLkhVsyN0UckWTYVUFt4lsYh7DuDxWz1gpQTmVI8FAzdkr2t19EhwrSZ
         XBNQ==
X-Gm-Message-State: ALoCoQkhJX/Esrpd7aIBCnAI1mvwfMY8gZCWun/GQMNz2j54s7z3OBXkyuqLq4hfy/IPKIvKk51r
X-Received: by 10.50.27.41 with SMTP id q9mr730476igg.25.1376002996993;
        Thu, 08 Aug 2013 16:03:16 -0700 (PDT)
Received: from gmail.com (64-198-156-98.ip.mcleodusa.net. [64.198.156.98])
        by mx.google.com with ESMTPSA id y2sm9071898igl.10.2013.08.08.16.03.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 16:03:16 -0700 (PDT)
Mail-Followup-To: Justin Collum <jcollum@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CACO0oR7M90iyDCo-mwoHn21jKRGuMsRWEeWkFXC-MCSUBscC9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231950>

On Thu, Aug 08, 2013 at 03:33:32PM -0700, Justin Collum wrote:
> On Thu, Aug 8, 2013 at 3:18 PM, Andrew Ruder <andy@aeruder.net> wrote:
> > he is neither the user dev or the group dev
> 
> I am both. There's only one user on this machine and he is me.

If you are running as 'dev', then I'm not sure how the permissions in
the modified case would affect git's ability to work with the file.
Seems like everything should be working fine... what is the error you
get when things stop working?
