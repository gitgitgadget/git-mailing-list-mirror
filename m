From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 17:45:10 -0500
Message-ID: <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:45:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpteM-0004Am-UR
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbXKGWpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbXKGWpN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:45:13 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:5723 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbXKGWpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:45:12 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1855060nze
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3G1wDsIrmboxbaNLSfMY3dyrGyCJvg93elyn6EI+3W4=;
        b=BNNG71yXs+B5bOB8TH0e8NLbeD+lK+ff+MJVtKVn7jn5TIKe5PvlO+0Y4wSFoT/J7w73dfLIXoAZg4ecLxbxGwYaLw5W9X/WurZzYX1w1CgTBAdqmYm0r817mwwfwXCJUuXH+UwUeRXRNq0OR8dn/EdTkZPbA8pafxwQshfck2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qpeeMuoarx9TYlIL96WYqC8e+BECRtXm3n18jKknth2pYfLsGolk1I0J4KEKRphd0TW/4dL0mm6cyAw75evY6MZzl4U0bGR6/GOeEQnpBlTNZIby5DgVpvv2b4auborqy8TUzbHjoNd0OEM6E94g4NUrbVjtkWT3hKMge5RhZhk=
Received: by 10.114.177.1 with SMTP id z1mr1491930wae.1194475510565;
        Wed, 07 Nov 2007 14:45:10 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 14:45:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711072242230.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63882>

On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 7 Nov 2007, Jon Smirl wrote:
>
> > In project root:
> >  git log arch/powerpc/platforms/52xx
> > works as expected
> >
> >  cd arch/powerpc/platforms/52xx
> >  git log arch/powerpc/platforms/52xx
> > fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
> > revision or path not in the working tree.
> > Use '--' to separate paths from revisions
>
> Try "git log ."

Shouldn't git log default to "git log ."?

-- 
Jon Smirl
jonsmirl@gmail.com
