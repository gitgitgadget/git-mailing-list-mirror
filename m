From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: post-update script to update wc - version 2
Date: Wed, 27 Jun 2007 14:43:46 +0200
Message-ID: <81b0412b0706270543s7dd37e3ds1acfe671f647617@mail.gmail.com>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz>
	 <4681C640.6060408@vilain.net>
	 <81b0412b0706270221y40bac0a7gf6b73eda9f1e4bb0@mail.gmail.com>
	 <7vved9pv2h.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, "Sam Vilain" <samv@utsl.gen.nz>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 14:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3WsB-0004xt-IO
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 14:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415AbXF0Mnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 08:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756682AbXF0Mnt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 08:43:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:56739 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104AbXF0Mns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 08:43:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so312022ugf
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 05:43:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WDE/j/knvCMQG1VaC6AGbfGdQDkJrWYT3i8SuVFvH+hkz79unmEDo8HwAo4DZcU7R0/jeYB4QnhFFP/EWWA8Tz6LAZSrVJO02Ijba5aMgG/nxDTf1LLdZvEA7dwRQ8W2/UMUtPUPy5j9HzHnpbkK13BXYKxAhKxHkEr9LvDvaPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kH/acroedw2kdTjFcsp6deYdjb8e/4VQxDOvBQe8h1C+G/muYWk/Gas5uVGN5PS1384s/dZDZVhV4xwQPH869KbuepXbvHIu/wnEu87l2iJU6I0c+l4xMP+sTfCJpnzeAcCfaFxLiETXPvYB55rOyUjc2F2TKNlAi9xDb2S1U2o=
Received: by 10.78.153.17 with SMTP id a17mr237493hue.1182948226804;
        Wed, 27 Jun 2007 05:43:46 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 05:43:46 -0700 (PDT)
In-Reply-To: <7vved9pv2h.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51034>

On 6/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> > On 6/27/07, Sam Vilain <sam@vilain.net> wrote:
> >> Sam Vilain wrote:
> >> >         this_tree=`git-cat-file commit $commit | awk '/^tree/ { print $2; exit }'`
> >>
> >> Of course on newer git, `git-rev-parse $commit:` will do that.
> >
> > Are you sure? Maybe you mean git-rev-parse "$commit"^{tree}?
>
> I had the same "Huh?"  moment as you had, but what Sam said is
> correct.  He is being too clever to confuse us ;-).
>
> When "$commit" is a tree-ish,
>
>         $commit:$path
>
> is the name of the tree or blob object at that $path, and as
> very strange special case, an empty $path is the whole tree.

I didn't even see the colon. That's GMail, they obviously have
no idea what font should be used for the mail of a technical user.
