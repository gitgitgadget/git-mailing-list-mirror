From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git stash apply segfaulting when called in subdir
Date: Wed, 25 Jul 2007 18:32:44 -0400
Message-ID: <20070725223244.GB21274@dervierte>
References: <20070725212311.GA13325@cassiopeia>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpPW-0005fM-MY
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237AbXGYWcs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 18:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755561AbXGYWcs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:32:48 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:31382 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbXGYWcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:32:47 -0400
Received: by py-out-1112.google.com with SMTP id d32so636896pye
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 15:32:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=eW2wPT+eftjLRgO/rghYGB0b9ErNqvgoQH6P/nGfR+2JXeSFqMiHZ1j/LeF3EzglMIToNY/wPLnO2g+PwlV8KofQhIa8FuFPQGDYUcO2pK8GFpbaadSTmROCR1KzzqEzKCk09MxgD9GijfgggYBsdtQx/Pylam/8X+FXKmdAdRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:from;
        b=TLqRHp5JCyWLvdkYnYkcF+e/85zecr08pQ7iglG/laG2dhuwWi3B4GnF48osatgQz1k6vFpI7clxpsC1yz/CF76wMsHdgtAAgvjYGtSQzNgkeMbN0qz2Smv0eEJLwB38bYVfoQ09N8fiREGWEYPWq72srobCk0Gp5e2ns8G/1D4=
Received: by 10.35.115.18 with SMTP id s18mr10225467pym.1185402766674;
        Wed, 25 Jul 2007 15:32:46 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.131.192.220])
        by mx.google.com with ESMTPS id n80sm1004845pyh.2007.07.25.15.32.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 15:32:46 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id C546DCFF866; Wed, 25 Jul 2007 18:32:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070725212311.GA13325@cassiopeia>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53728>

On Wed, Jul 25, 2007 at 11:23:11PM +0200, Uwe Kleine-K=F6nig wrote:
> zeisberg@cassiopeia:/tmp/repo$ cd dir; git stash apply
> error: missing object referenced by '696146c2a44d7fc4d5ae4a71589c4c0d=
84f59789'
> /home/zeisberg/usr/bin/git-stash: line 111: 13618 Segmentation fault =
     git-merge-recursive $b_tree -- $c_tree $w_tree

I've been seeing this, as well.
--=20
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
