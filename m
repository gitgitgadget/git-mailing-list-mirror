From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 10:17:13 +0200
Message-ID: <81b0412b0704250117y5dbe5594ybb672a2b0e350124@mail.gmail.com>
References: <1177483875.12689.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Ansell" <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 10:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgcgu-0000Jj-Lm
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423256AbXDYIRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423281AbXDYIRS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:17:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:45124 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423256AbXDYIRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:17:14 -0400
Received: by wx-out-0506.google.com with SMTP id h31so157143wxd
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:17:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o2ChXoHBtWDofVx9NLBjDT+v16yyPDbVX0FRnaeZSV1KQpFRtLGYMV13fuxLxMvM17CPmsYf6JR24KOzmJK7taa6+olSBGvkfXd+hpl1kj8UeMecCE4NlndYuY2Adyi5zc9QZlB872wffj6ZfaDkdrwq/HoLliGZQ6coVHJwzNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r1WnTgHzEedRJBqPqGHvi7ABBI549hqImHPtNDa6akxRWGnKFUf5+v3Q9mN8lxzNw0+7YN9hNHq/G0U8xUhOMW08EhpcyxOXpXzeuBwR4lsmSm+w1okyD7Y2DYYkE9uTVV19RTIbgZ4v67TVdfBGcuYztgJzFj9yLub86aRAARs=
Received: by 10.70.35.1 with SMTP id i1mr963507wxi.1177489033949;
        Wed, 25 Apr 2007 01:17:13 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 25 Apr 2007 01:17:13 -0700 (PDT)
In-Reply-To: <1177483875.12689.22.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45510>

On 4/25/07, Tim Ansell <mithro@mithis.com> wrote:
> which is quite large (about ~126Mb) is causing problems when trying to
> clone via git-daemon.

126Mb sounds so _small_ compared to the repos seen lately (Firefox,
KDE, hell, my own work is long in Gb ballpark!). You're lucky :)
