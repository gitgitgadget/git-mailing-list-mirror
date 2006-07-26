From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] t7001: add test for git-mv dir1 dir2/
Date: Wed, 26 Jul 2006 16:33:06 -0400
Message-ID: <9e4733910607261333k3ec961f7yd012566aa9aa6ed8@mail.gmail.com>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910607261050k5f8d8d5dke5ded3a806b46f21@mail.gmail.com>
	 <7virlkrzr4.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910607261131q195defa7vbedd72cb0b938ba3@mail.gmail.com>
	 <7vejw8ry5f.fsf@assigned-by-dhcp.cox.net>
	 <7vmzawqi1m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 22:33:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5q4A-0005cw-3u
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 22:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWGZUdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 16:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWGZUdI
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 16:33:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11690 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161038AbWGZUdH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 16:33:07 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3351200ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 13:33:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N4gZlwBIm4LrPxINxBQPuSc0k3NXmo2aXt2l+LzBT3LhBo3E/KkTr7Wh8rkHi5SRk+otD3rkFauLnNofjX5aVfS2C0IZyZnOJdxYA9jD47zJj2MZcYjRlyVnhOtK9gnwtbW8OJEq3Y/9izusKOP0mXA7voZU3M0VyLep8eqDJGQ=
Received: by 10.78.177.3 with SMTP id z3mr3435507hue;
        Wed, 26 Jul 2006 13:33:06 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 13:33:05 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <7vmzawqi1m.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24246>

On 7/26/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> >> git diff HEAD makes a much longer patch that deltas out the existing
> >> files and delta in the new file.
> >>
> >> It's applying patches in the extended git format that fails.
> >
> > Thanks.
>
> ... and it turns out that "git apply" (with or without --index)
> groks it just fine.  I suspect the fix is quite recent (not in
> v1.4.2-rc1 but in v1.4.2-rc2).

I can confirm that git apply is handling this correctly with code from
the current git tree. cogito is failing this case.

-- 
Jon Smirl
jonsmirl@gmail.com
