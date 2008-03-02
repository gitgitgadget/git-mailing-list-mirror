From: "Steve French" <smfrench@gmail.com>
Subject: Re: kernel.org git tree corrupt?
Date: Sun, 2 Mar 2008 16:02:31 -0600
Message-ID: <524f69650803021402q93534c4w5acaa01fe1d1dd6f@mail.gmail.com>
References: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
	 <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
	 <46a038f90803021340uf1c9c6te5501d9fb0565f19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	lkml <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVwH2-000130-LR
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 23:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbYCBWCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYCBWCd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 17:02:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:1024 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYCBWCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 17:02:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3143181nfb.21
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Wd/ZxbCepbjt5WIZ2xDU5FuSWEH62QIJLbfZsBT1wFc=;
        b=PWkVsdmpyEMV7rskfigZnAuSKmtMi4jwxx98oci/2uEDxEibH1jowU5dGS/cZ/U84C5wFUybnEPHhl4PxsST4LKvNOYGXTW538EqObV+BGrhGzlxcx8vLP+veJDEWnhOoWvenrmsbB5HmKoyNB3TVoPOtznh9fomXZwfv0wEmS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fNrNc4KqLw/NB+yoidjCQewf5/WGclgBEpBBPVpFXwmpXXS+HqlIj0gtsflmEY1wR09rT47qecqqmfdG7pIwqkBlDF4tGWi1KMNvntoa0iNFnMH5CFs3UT/nL5NAsiHOISNh/aJR+sA/Jb2OXHUf/HhdmjgMobI3C0fX+yCeAA8=
Received: by 10.78.97.7 with SMTP id u7mr16703474hub.53.1204495351319;
        Sun, 02 Mar 2008 14:02:31 -0800 (PST)
Received: by 10.78.172.19 with HTTP; Sun, 2 Mar 2008 14:02:31 -0800 (PST)
In-Reply-To: <46a038f90803021340uf1c9c6te5501d9fb0565f19@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75849>

On Sun, Mar 2, 2008 at 3:40 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Mon, Mar 3, 2008 at 10:16 AM, Linus Torvalds
>  <torvalds@linux-foundation.org> wrote:
>  >  In that case, your "origin" simply isn't updated, but points somewhere
>  >  long back in history. I can only assume that cogito has done something
>  >  wrong, like not been able to handle packed refs or something, and you have
>  >  an updated tree but "origin" pointing to way back in the history.
>
>  Strange - cogito over git protocol will use git itself to peek at the
>  references. Steve, what is your git version?

This is master.kernel.org so git version is 1.5.4.3

-- 
Thanks,

Steve
