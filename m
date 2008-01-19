From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Why very small repository has 2.7M size
Date: Sat, 19 Jan 2008 21:59:58 +0800
Message-ID: <46dff0320801190559qbd9c846v56ece0111554d94b@mail.gmail.com>
References: <46dff0320801190143h471e6d70ve5bf114335e1534@mail.gmail.com>
	 <46dff0320801190148y5a00c83m4825f4066547ddc2@mail.gmail.com>
	 <4791D7AD.1060106@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jean-Luc Herren" <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Sat Jan 19 15:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGEFK-0000nW-RI
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 15:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbYASOAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 09:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYASOAA
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 09:00:00 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:60951 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbYASN77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 08:59:59 -0500
Received: by py-out-1112.google.com with SMTP id u52so1988405pyb.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5aZuKsazWEZw9mU+HC81uOSifCy/+nwUnlZZ7hZt+v0=;
        b=mPOpOjl8KyA42YqDGtlnNWTZPJM2V0WnErhiswK4g7xMo1M2vDNxseaUu5oknWkrVN32ks0MMzRYg5pPCb9uq9cZrRt5Y4MPgXc07nMZDpTHJYcNu6K2p7eBlGVOWjMZDbbFI8vmzbhfPadN5faUgsndLrupfnjRA8Oqd1AtRNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fSn7YIL2GSj1xeUOGPUHVPbHZzao2hudmkMOfEyQmh8Lm1+7n3gnGndUSCde2bXmkr2nXjJmcjF/L6dhaE983Ghxt4H94RVo3V6SG0XQ3YUhNCwiZpDtjB7/J6CnLX58rphofSK/xQYQy22vZgri/j8pntS7/mOeoXw6qP2II5I=
Received: by 10.35.135.20 with SMTP id m20mr5214106pyn.28.1200751198144;
        Sat, 19 Jan 2008 05:59:58 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 19 Jan 2008 05:59:58 -0800 (PST)
In-Reply-To: <4791D7AD.1060106@gmx.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71105>

On Jan 19, 2008 6:57 PM, Jean-Luc Herren <jlh@gmx.ch> wrote:
> Ping Yin wrote:
> > -rw-r--r-- 1 yinping yinping   26 2008-01-19 17:33 .gitignore
> > -rwxr-xr-x 1 yinping yinping  131 2008-01-19 17:44 Makefile.common
> > [...]
> > Counting objects: 87, done.
> > [...]
> > 4046b84344038d63b655b56f6e619888dd424e4e Add Makefile.common using commonmake
> > 8bbd7d4649ac1df1b29414b2ec469f532a77f222 Init empty repository, ignore
> > *.o, *.d, *~, *.swp, CVS, .svn
>
> You sure have a lot of objects for only having two commits and two
> files.  Maybe some of the objects are loose ones?  Try running
> 'git gc --prune' to see if that removes them.  But be aware that
> this deletes them all, you might want to check first if the loose
> objects are something you wanted to keep (with 'git fsck' and 'git
> show').
>
Oh, sorry, my fault.
$ git branch -r

  origin/HEAD
  origin/backup
  origin/backup1
  origin/backup2
  origin/master
> jlh
>



-- 
Ping Yin
