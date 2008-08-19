From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 04:42:42 -0700 (PDT)
Message-ID: <m3od3ps02b.fsf@localhost.localdomain>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	<alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	<7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0808181628420.19665@iabervon.org>
	<7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0808181839390.19665@iabervon.org>
	<7vy72tit90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 13:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVPcv-0003xB-Hj
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 13:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbYHSLmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 07:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbYHSLmq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 07:42:46 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55030 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbYHSLmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 07:42:44 -0400
Received: by gxk9 with SMTP id 9so4899381gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=r1jnAvKnM0r7gJA7KhgIpGxcBbly1ajHtJaorkqI9WY=;
        b=DF1tM9go8rqsGLCc0fMSVXlvApeDEZBkZLMir854OCV7oj50nCiiGxyidy/lYO1S77
         u1oidAPsQ1uygqV8mn7ibzzhJadwu0zFJW5zEish65O2p8cvv5ZT3IRKgg0kG/q9H+kG
         e/ZBmMU2YIz/35tM5nwuy2yf8wvL3YWuvLl9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qadrQkrJcvfSHcyIptI7HPWtfQ7nIHC4AxigXI4I1DRdxgp2QsmKevje6nMnMyqmRa
         9WQLaFESYWxFOUAUdytRPOhpmZtuPfCyK+wL7+VdK05CPmFrLA4KLBH+riu3i/hST/3d
         xDjMvI4vGimsJslIjMJJ0S8+ba/u1SvRg4dc0=
Received: by 10.150.201.13 with SMTP id y13mr11682555ybf.238.1219146163418;
        Tue, 19 Aug 2008 04:42:43 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.212])
        by mx.google.com with ESMTPS id s30sm11372999elf.9.2008.08.19.04.42.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 04:42:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7JBgbGg002309;
	Tue, 19 Aug 2008 13:42:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7JBgaCm002305;
	Tue, 19 Aug 2008 13:42:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vy72tit90.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92849>

Junio C Hamano <gitster@pobox.com> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Actually, this weekend I was trying to cherry-pick the aggregated changes 
> > to certain files from one branch onto another, and was repeatedly confused 
> > by the fact that the only available diffs are backwards and there're no 
> > clues in the output. (That is, you can't get the difference between (---) 
> > the {index,working tree} and (+++) some commit, and when you've done "git 
> > diff messy", the resulting diff doesn't give any clues that you're 
> > deciding whether to add the - lines and remove the + lines.)
> 
> I do not know if I like the end result, but here is a patch to make the
> traditional a/ and b/ prefix more mnemonic.
> 
> A lot of existing tests and documentation need to be updated, if we were
> to do this, though.    The first test to fail is t1200-tutorial.sh.
> 
> Obviously not tested except for creating this patch that pretends to be a
> format-patch output.  You can tell that I just did this only in the work
> tree now.
> 
> -- >8 --
> diff: vary default prefix depending on what are compared
> 
> This implements Daniel's idea to indicate what are compared by using
> prefix different from the traditional a/ and b/ in the textual diff
> header:
> 
>     "git diff" compares the (i)ndex and the (w)ork tree;
>     "git diff HEAD" compares a (c)ommit and the (w)ork tree;
>     "git diff --cached" compares a (c)ommit and the (i)ndex;
>     "git diff HEAD:f /tmp/f" compares an (o)bject and (w)ork tree.
> 
> Because these mnemonics now have meanings, they are swapped when reverse
> diff is in effect.

> diff --git i/builtin-diff.c w/builtin-diff.c
> index 7ffea97..ecec753 100644
> --- i/builtin-diff.c
> +++ w/builtin-diff.c
> @@ -74,6 +74,8 @@ static int builtin_diff_b_f(struct rev_info *revs,
>  	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
>  		die("'%s': not a regular file or symlink", path);
>  
> +	diff_set_default_prefix(&revs->diffopt, "o/", "w/");
> +
>  	if (blob[0].mode == S_IFINVALID)
>  		blob[0].mode = canon_mode(st.st_mode);

I was thinking about reusing estended SHA1 syntax in the form
of :0:a/file or ::a/file for index, a/file for working directory,
and HEAD:a/file for a tree version.  But your way is I think better;
of course if you remember mnemonics (and they are documented, aren't
they?).

BTW. I wonder why in above patch, which I guess is result of running
git-format-patch and should be between TWO TREES, doesn't use standard
'a/' and 'b/' (git-show should also use standard, default prefixes).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
