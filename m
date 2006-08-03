From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 3 Aug 2006 10:09:56 +0200
Message-ID: <81b0412b0608030109g6f49113ep5cf577475117469b@mail.gmail.com>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>
	 <7vd5bis9ha.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 10:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8YHR-0003mZ-EK
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 10:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWHCIJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWHCIJ7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 04:09:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:41 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932392AbWHCIJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 04:09:58 -0400
Received: by nf-out-0910.google.com with SMTP id o25so924715nfa
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 01:09:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Di9ln9SDmZf126wSNGJRxByYrY+wnDZgNpysfx6w8WY2pP7Ydyb8FiHM8BhGgq2lmHRjhIGFR6woRciVpV/Wur/hzd4R3BZF7WtfbH1DLUctK9k1+WrzklyYzlSjt2Ev2/aUuMIV+ZwFjBetD51fG2H4rbrV7sZ7UEOtSnX6K3Y=
Received: by 10.78.117.10 with SMTP id p10mr646449huc;
        Thu, 03 Aug 2006 01:09:56 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 3 Aug 2006 01:09:56 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd5bis9ha.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24710>

On 8/3/06, Junio C Hamano <junkio@cox.net> wrote:
> >>   - Git.pm by Pasky with help from Pavel Roskin and others.
> >>
> >>     I'd like to merge this immediately after 1.4.2, unless there
> >>     still are concerns about its portability (in which case
> >>     please help fixing them up before this hits the "master"
> >>     branch).
> >
> > Completely broken on ActiveState Perl and cygwin. Generated Makefile
> > contains pathnames with backslashes and the whole file has
> > CRLF line endings.
>
> Anything constructive other than "doctor it hurts when I use
> activestate", so you can help improve things to be more
> ActiveState friendly?

Nothing. If I had something, I'd post it.

> What's the standard workflow/procedure ActiveState users would
> use to build and install .xs extensions?  Maybe they have their
> own $(MAKE) equivalent that groks such a Makefile with
> backslashed pathnames and CRLF endings?

I don't know. It's a bit more than backslashes and CRLF. The pathnames
must be _completely_ converted from windows to cygwin. Cygwin even
provides an utility for that (cygpath). Besides, there still is that stupid
case-sensitivity problem.
