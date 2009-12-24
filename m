From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: elegant(?) debian topgit workflow?
Date: Thu, 24 Dec 2009 17:14:40 +0200
Message-ID: <94a0d4530912240714y798085d8r3bf88011e8ec782b@mail.gmail.com>
References: <200912161113.38396.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: vcs-pkg-discuss@lists.alioth.debian.org, git@vger.kernel.org,
	debian-devel@lists.debian.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Thu Dec 24 16:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNpOq-0006pM-GW
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 16:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbZLXPOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 10:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbZLXPOl
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 10:14:41 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:38540 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZLXPOl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 10:14:41 -0500
Received: by iwn1 with SMTP id 1so5811577iwn.33
        for <git@vger.kernel.org>; Thu, 24 Dec 2009 07:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Dmb4/ycEI93DXrWKVqjok9NU6CUYHWjYaeR/MNa/A1w=;
        b=eBkhLT5npxMebbY/nbjhI6jUx3Rl7WhdNRB0VY7pTckqz2cay0Cq2iAMvcdx3Zu2Ck
         C3b5Ty5jrzPg5qy3KH482OAY+AVGnM5pGkJZsdsVXW3gNJHEjlUd4VwYEGvK9n6hRmVm
         sYeMC3mKplEY9qhNMqkUpDI+Ghu3hbQil9Ja8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KtlqvexbyVZseRVuoA4zCtldNQD5NEZ7zeSAxT+6dc6LttNPgNZkhuJxy0miGsK/JI
         64QDIgYuBNWspOTJ1/eOHr9tYikwN8Oy33Q9o7LQ9RyTMEF3/hQoUklnqwHVHbe6MmQu
         y4gT/GDIgRY6py27sdImOsBmQWMg2gr+Uyg6g=
Received: by 10.231.167.212 with SMTP id r20mr1059125iby.7.1261667680342; Thu, 
	24 Dec 2009 07:14:40 -0800 (PST)
In-Reply-To: <200912161113.38396.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135654>

On Wed, Dec 16, 2009 at 12:13 PM, Thomas Koch <thomas@koch.ro> wrote:
> branches
> --------
>
> upstream

I would call it 'master'. That's how upstream would call it.

> debian/*, fixes/*, features/* - topgit branches based on upstream
> patches - the hero
> master - contains the debian/ dir and is the branch we build from

Think about other systems, like Ubuntu and Maemo, it would be nice to
have branches both for Maemo and Debian on the same repo:
debian - what you call 'master'
debian-patches - what you call 'patches'
maemo5 - contains the debian/ dir, but for Maemo 5
maemo5-patches - patches for Maemo 5, might be based on top of debian-patches

-- 
Felipe Contreras
