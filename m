From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 13:24:41 -0400
Message-ID: <9e4733910609131024v28ccce5cx7dd427a55002bc4f@mail.gmail.com>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	 <20060913152451.GH23891@pasky.or.cz>
	 <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
	 <ee9akc$d62$1@sea.gmane.org> <45083490.9020203@gmail.com>
	 <ee9d5j$lhd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 19:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNYTe-0001UT-LE
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 19:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWIMRYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 13:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIMRYo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 13:24:44 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:53971 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750816AbWIMRYn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 13:24:43 -0400
Received: by py-out-1112.google.com with SMTP id n25so3250482pyg
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 10:24:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=alP/W+OMGP/oIsBxE/mZ1VY/WrrZhyzWpB3gJTO+CbwEDuJKrc+x5gE3ZMQQBpOgxzOOjOBMTnws/DQ71YGVztTMs2iv6fHJxa9JefbZwZbFT+F1POPlyLB1JHSweVQsQD+3t1An3NlpEi3geU5RKQU0HzUx1qjbCRN//tRDO7o=
Received: by 10.35.102.1 with SMTP id e1mr13360110pym;
        Wed, 13 Sep 2006 10:24:41 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Wed, 13 Sep 2006 10:24:41 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ee9d5j$lhd$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26925>

On 9/13/06, Jakub Narebski <jnareb@gmail.com> wrote:
> A Large Angry SCM wrote:
>
> > Jakub Narebski wrote:
> > ...
> >> As it was said somewhere in this thread, you can use tags (tag objects)
> for
> >> that, i.e. tag each of the abandoned branches, explaining why branch wa
> >> abandoned for example, remove head refs, and move tag refs to
> >> refs/abandoned or refs/tags-abandoned/ or refs/Attic/ or in
> refs-abandoned/
> >> (the last has the advantage to not be included by default in any command,
> >> even when --all is given)
> >
> > Using $GIT_DIR/refs-abandoned/ means changing a number of core parts;
> > think fsck and friends. Better to decide on a name in $GIT_DIR/refs/ and
> > teach the various visualizers to ignore that prefix by default. Maybe
> > even make the name a config item. *ducks*
>
> Well, visualisers IIRC shows only requested branches. The only place where
> abandoned branches would show even when we probably don't want would be
> --all... one can try to use --all --not refs/abandoned/*

In order to make the tools easier to use I would turn this around and
make --all show all active branches and the use something like
--include /refs/abandoned to include the abandoned ones.

>
> I wonder if using the "hidden" directory for abandoned branches
> (i.e. refs/.abandoned) would work...
> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
