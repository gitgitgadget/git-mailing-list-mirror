From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] Add LICENSE
Date: Wed, 14 Jul 2010 13:23:42 +0200
Message-ID: <20100714112342.GB3496@debian>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <1279064176-6645-2-git-send-email-artagnon@gmail.com>
 <20100714044712.GB3081@daniel3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Daniel Shahaf <d.s@daniel.shahaf.name>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <
X-From: git-owner@vger.kernel.org Wed Jul 14 13:22:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ02N-0000pg-6t
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 13:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab0GNLV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 07:21:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54957 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab0GNLV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 07:21:56 -0400
Received: by ewy23 with SMTP id 23so1367018ewy.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NgDyiWVog4eR3hggjUleKXoWV6piFtJSwlnzmRwGBr8=;
        b=PgjL9aihFWkiwS0ktnHzUc/xUpXc6WcAbD5CVePmlh7bI9V7VMtPXud7Sz1VzH4Fgr
         InuibC7UOVIetQw4YqqQkynHcSMGgfuC0+ANwdIPEqcN5aFAEShJyiyAKlkAUKu7j9Ni
         pvSdfx74LIURtDsjgQHhVxK9ly/BgaoSpg6K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QXGcnyfiBbKbPKaSduNDdHtYwwSRDy9kzbKO7kXNZVInTohzT0nPkOTknl2kfCAehM
         L7J8SCbjC2hIrqJx1D/mqPsZo1v78PlXmy1UDRk6xD7FzQK3P3XtAdAHqsGXAU5HAgf5
         l3JFAZvdLo89DjoNVdPbaDXhLm8GSspPn9Lfk=
Received: by 10.213.35.18 with SMTP id n18mr6185467ebd.7.1279106515232;
        Wed, 14 Jul 2010 04:21:55 -0700 (PDT)
Received: from debian (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id v59sm56344065eeh.16.2010.07.14.04.21.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 04:21:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100714044712.GB3081@daniel3.local>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150978>

Hi Daniel,

Daniel Shahaf writes:
> [ are all of these CCs really necessary?  that's another thing I almost never
> see over at dev@svn ]

It's Git culture. Since our list is so high volume, many people aren't
subscribed to the list. Even those who are subscribed often cannot
read all the emails. When I CC someone on a list email, I'm implicitly
telling them "Please review this patch" or "Please comment on this" or
simply "You were involved with this work; just FYI, this is where it's
going". Most email clients have convinient markers to tell people if
they're marked on the To or Cc fields, or are simply receiving it
because they're subscribed to a list.

> If it ends in svn trunk as subversion/svnrdump/ (and not as a tools/ utility),
> it's going to have to be licensed under the Apache License v2.

Yes, I know. PATCH v2 is licensed appropriately. My intial idea was to
dual-license it: two-clause BSD for the git.git version and Apache for
the ASF version, but it seems like too much work now.

-- Ram
