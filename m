From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 00:34:55 -0700
Message-ID: <20121025073454.GB15790@elie.Belkin>
References: <20121024191149.GA3120@elie.Belkin>
 <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
 <20121025042731.GA11243@elie.Belkin>
 <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin>
 <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
 <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
 <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
 <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
 <CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 09:35:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRHyD-0001jB-33
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab2JYHfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:35:00 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62418 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758613Ab2JYHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:34:58 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so958749pad.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vDXtZCyPT8Z5bbqgb5Y8+qiGfFogQhpn88s+LHFzRso=;
        b=dMfljoARI1FIueWbon/MEWehxUDKaMZP85b2c8mmgVZriWa4x5pyUEPfyKJDrZtbHk
         GDlqV4Fh7P5iNwm+NZVoV9NO4PXwkxUrAjY68w2rv2OXn6DnGibJ4YU7UaMYx4SeCsyB
         Rqr31/Ltr9QN8cu5gV7MRrBuDd3MpzFWAdI9uisPAqq9iL2NLAoxi1c8H1vFSiNKczjd
         N2V9+Ro+rvhsxqT/Xjnh7M1407cDMaUk3NONkPzxdFaYYTyeDESb58E7Htu2+aMaUnI0
         9SbN2HNWOqGjdbW/q1wB3IAwfnRAgYVRDdCJbnMGr9Bp8IGunL80XU6Yrhv83ZWb966n
         Lt+w==
Received: by 10.68.137.228 with SMTP id ql4mr57749345pbb.125.1351150498619;
        Thu, 25 Oct 2012 00:34:58 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id oe5sm10797480pbb.8.2012.10.25.00.34.57
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 00:34:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208357>

Sverre Rabbelier wrote:

> That's weird, we have this bit:
>
> +		if (elem->whence != REV_CMD_REV && elem->whence != REV_CMD_RIGHT)
> +			continue;
>
> If I understand correctly that should cause it to only output revs
> (e.g. 'foo1') and the rhs side of a have..want spec.

If I remember right, '^foo1' is (whence == REV_CMD_REV) with (flags ==
UNINTERESTING).  That's why sequencer.c checks for unadorned revs like
this:

	if (opts->revs->cmdline.nr == 1 &&
	    opts->revs->cmdline.rev->whence == REV_CMD_REV &&
	    opts->revs->no_walk &&
	    !opts->revs->cmdline.rev->flags) {

Maybe

	if (elem->flags & UNINTERESTING)
		continue;
	if (elem->whence == REV_CMD_PARENTS_ONLY)	/* foo^@ */
		continue;

would work well here?  That would handle bizarre cases like "--not
next..master" (and ordinary cases like "master...next") better, by
focusing on the semantics instead of syntax.
