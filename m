From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Thu, 25 Oct 2012 00:48:29 -0700
Message-ID: <20121025074829.GD15790@elie.Belkin>
References: <20121025042731.GA11243@elie.Belkin>
 <CAMP44s1Pe8Ef6-GRbmSs7rY7gWyaPCN+jWGysyttZp3drSDoZg@mail.gmail.com>
 <20121025052823.GB11243@elie.Belkin>
 <CAGdFq_gg3gPvCADje9ibz8xHgPOLF+=79EqksVzG2JeTOfHocw@mail.gmail.com>
 <CAMP44s3kBxzJbyoxPqWbRMWmpX9sNPGjdRy_KrTeRoVmGC-+Hg@mail.gmail.com>
 <CAGdFq_jfiX9apPyq6pba4S4iCQLGLmDvSrLaujSB5rO0i+fzfg@mail.gmail.com>
 <CAMP44s1cRg_we5nXeRG1WcWz7YUOBrauJigeNna1YETcno9p=A@mail.gmail.com>
 <CAGdFq_hgYPF5eeCB9hSsjVfUyEhkBNJAtzoNuNqs5N6V-+w9Hg@mail.gmail.com>
 <20121025073454.GB15790@elie.Belkin>
 <CAGdFq_j5sWsHwJY-rWP-XJ6cMF6uwSq=9beFe9ZuZyixBa1fVA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 25 09:48:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRIBM-0001UA-J5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 09:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499Ab2JYHsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 03:48:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53428 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab2JYHse (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 03:48:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1817112pbb.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ozoc1/AeKXmaosQXQ4MLPvMwdllK4p8OT0xw0x9oqOQ=;
        b=tddbq7SIWe/ewyFclFxcE8dzOYmL1oxvdDx2TBOt1zUbBok/d2auuFf/s8l70HNQZA
         FSpj9WNUObb6iUq0acpFSPUglSm6bInxImXNseQEMu0gN96YZhysVVRMmYguGZwu+fdC
         8rxPvm8zX8cXsGs39hJ3DFrn6xpp1NU1Fb8n4lTxV0NWrJ43lqngOggYk+MmGF3AtCGj
         hxxeJr3NQGBZil+lIuh+gD4m9im0OgM2cJSPzr4FC+I0k4Py8JE8+EV+HKk8NolNMabH
         fkHiWO6eZmkcbPPgNCJZjTBm18BZV2BgSWQKQRpLAqAVF+1IACzxC3ciYKTOciYxjZOu
         4GVw==
Received: by 10.68.212.74 with SMTP id ni10mr57491306pbc.20.1351151313639;
        Thu, 25 Oct 2012 00:48:33 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id nd6sm10802014pbc.68.2012.10.25.00.48.32
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 00:48:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_j5sWsHwJY-rWP-XJ6cMF6uwSq=9beFe9ZuZyixBa1fVA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208360>

Sverre Rabbelier wrote:

> I know there was a reason why using UNINTERESTING didn't work
> (otherwise we could've used that to start with, instead of needing
> Junio's whence solution). I think all refs ended up being marked as
> UNINTERESTING or somesuch.

True.  Is it be possible to check UNINTERESTING in revs->cmdline
before the walk?
