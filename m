From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 21:43:47 +0200
Message-ID: <bd6139dc0804161243i5e5c973aia0cf2d5ec19079fa@mail.gmail.com>
References: <20080413205406.GA9190@2ka.mipt.ru> <20080414043939.GA6862@1wt.eu>
	 <20080414053943.GU9785@ZenIV.linux.org.uk>
	 <20080413232441.e216a02c.akpm@linux-foundation.org>
	 <20080414072328.GW9785@ZenIV.linux.org.uk>
	 <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
	 <4804765B.2070300@davidnewall.com>
	 <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com>
	 <20080416132634.GA545@cs181133002.pp.htv.fi>
	 <20080416120247.c665859c.akpm@linux-foundation.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Adrian Bunk" <bunk@kernel.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, jmorris@namei.org,
	viro@zeniv.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	davidn@davidnewall.com
To: "Andrew Morton" <akpm@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757376AbYDPToL@vger.kernel.org Wed Apr 16 21:46:59 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757376AbYDPToL@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDZ2-0003Yi-Ov
	for glk-linux-kernel-3@gmane.org; Wed, 16 Apr 2008 21:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbYDPToL (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 16 Apr 2008 15:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbYDPTnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2008 15:43:51 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:46906 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYDPTnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2008 15:43:49 -0400
Received: by el-out-1112.google.com with SMTP id n30so485032elf.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2008 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=odj7+brxAIAf7iHBAuiJCA2NVJwptjQQnL033JfkgsQ=;
        b=HgNwidDb/QWj8LU1noRgr/panfqHT2W2pczIOiwnQjJNZXKB89PPft8w7SjGNHIU86OGK90BkxMUpvA0WwZZndaebFY+hPNLecWLe1CHBP6qc5bEIAwh5yPsaWTDZu2yOwkf0WZRQwMMATHp26oWTJ1MHJcGIHYZSnDaJOSmjOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PVdAiUE/oBqLkE2jodDTOO8dcnaqFdU39++l//G8etCwLbAWfhD+gz8U5IxNoyvlTXdSlSj00CwEUbZvvodi3Wvt6bxRA5UhRdt6AiaPcbLsuYeD0eLg6uzQb6OUVl+SiJ5Y5yFRexzyqMzmIG/C6C5xrTCK5asJxGaq+o2MSMU=
Received: by 10.143.161.3 with SMTP id n3mr126084wfo.32.1208375027473;
        Wed, 16 Apr 2008 12:43:47 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Wed, 16 Apr 2008 12:43:47 -0700 (PDT)
In-Reply-To: <20080416120247.c665859c.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79730>

On Wed, Apr 16, 2008 at 9:02 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>  Sounds like an interesting project.

Thank you :).

>  Well yes.  One outcome of the project would be to tell us what changes we'd
>  need to make to our processes to make such data gathering more effective.

I defenitly agree here, the command's reliability could be increased
by always specifying bugfixes in a certain way. 'fixed-bug:' for
example should be very recognizable.

>  Of course, we may not actually implement such changes.  That would depend
>  upon how useful the output is to us.

Ah yes, free will and whatnot. Then again, everybody already does
'signed-off-by:', if there's an easy command in git to mark a bugfix,
it would increase the odds of people using it. Perhaps something like
'git commit -b 10256" which would then automagically append a
predefined message to the commit users would feel more inclined?

Cheers,

Sverre Rabbelier
