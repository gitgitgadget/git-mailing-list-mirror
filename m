From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 13:22:09 -0400
Message-ID: <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	 <20060913152451.GH23891@pasky.or.cz>
	 <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
	 <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 19:22:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNYRC-0000yk-P3
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 19:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWIMRWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 13:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWIMRWL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 13:22:11 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:39885 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750815AbWIMRWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 13:22:10 -0400
Received: by py-out-1112.google.com with SMTP id n25so3249978pyg
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 10:22:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZaFc5Ke4eTld7wlkhFi4/yXwcHMn92nP2dZL9TMeUck4tX/KIwZzjV8aWb1hG78QUdA8c9Y1NBXETMSVIAtmAL/m5vzB1GyLAa37t1oW/ISumuWJsANLoovgqEZ/na/OjmPBLKH/0h6UqzHYMrAKAy09e0zbTJV5dQLcHPJ1DSg=
Received: by 10.35.90.20 with SMTP id s20mr13346021pyl;
        Wed, 13 Sep 2006 10:22:09 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 13 Sep 2006 10:22:09 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26924>

On 9/13/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 13 Sep 2006, Jon Smirl wrote:
>
> > Moving the refs into refs/abandoned would work too. We would need new
> > git commands to do this and flags on the visualization tools to
> > include the abandoned branches. On the other hand doing this is
> > recording state about the repository in the refs directory instead of
> > writing this state into the repo itself.
>
> Well, the refs directory is _part_ of the repository. Think about it, if
> you do not know which branches are in the object database, you lack a lot
> of information.

If you delete all of your heads you can recover them by following all
of the chains in the repo to find them. Doing this would recover the
abandoned branches too but it would mix them up with the active heads.
This is not a big deal but it is info that is getting stored outside
of the object db.

-- 
Jon Smirl
jonsmirl@gmail.com
