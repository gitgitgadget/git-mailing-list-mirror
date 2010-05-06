From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2] An alias that starts with "!!" runs in the current 
 directory.
Date: Thu, 06 May 2010 07:21:16 +0100
Message-ID: <1273126876.3562.4.camel@dreddbeard>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	 <20100505005153.GC25390@coredump.intra.peff.net>
	 <4BE115EF.8010306@viscovery.net>
	 <20100505070131.GA11265@coredump.intra.peff.net>
	 <19425.9169.537598.876589@winooski.ccs.neu.edu>
	 <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	 <19425.54504.163875.379151@winooski.ccs.neu.edu>
	 <19425.58290.42871.986460@winooski.ccs.neu.edu>
	 <1273098179.723.10.camel@dreddbeard>
	 <7vpr19j4ng.fsf@alter.siamese.dyndns.org>
	 <n2qc376da901005051705t821b073do178d0261c4e4b2c0@mail.gmail.com>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eli Barzilay <eli@barzilay.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 08:22:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uTD-0004Q0-J8
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab0EFGV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:21:57 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:54596 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab0EFGVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:21:55 -0400
Received: by wwb34 with SMTP id 34so417435wwb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=2ZQkrG+53A2psLeMtacuvhbHKugVl+1yy702GEYnqEM=;
        b=jfMgapQY9EvN6hhOXm5bgYnRpRRmH56Xq8Iku68v++WRpNfhtDLRG5DytCvLVitNYM
         5g4NkQINxS9MwLlVg8SHiHXSLSLWUtJRx1t8YwSaRcbIDLT32SMmC6nVD4wVeXmeDL5i
         2kkIGXb7FoKoEclfuWy25IPEZjMi6lctL5Nus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=wUXMpmLiuiVhUcgIbP1kOGak9EHjbrec6YvMHJ01V+fuGvYo5mGwNSNZPh9Cu1HK1f
         BrJA177Zaxyj9J9KSskdFDSVpUoHj9GI7OBAjW2EeqaGJ8WGZJADrQJ20rhAMMHG8SCX
         TYywrLBNZj8VbUCpi+YySxoUMZ+8PhZFMuTho=
Received: by 10.227.151.77 with SMTP id b13mr3682768wbw.13.1273126912544;
        Wed, 05 May 2010 23:21:52 -0700 (PDT)
Received: from [192.168.0.129] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id y23sm4872027wby.16.2010.05.05.23.21.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 23:21:51 -0700 (PDT)
In-Reply-To: <n2qc376da901005051705t821b073do178d0261c4e4b2c0@mail.gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146441>

On Wed, 2010-05-05 at 20:05 -0400, Adam Brewster wrote:
> On 5/5/10, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > It probably is a good idea to switch aliases to start at the $cwd in 1.8.0
> > (or perhaps one major release after it), and using a notation that is more
> > descriptive, something like "!(cwd)" vs "!(root)", may give us a better
> > transtion strategy than casting cryptic "!!" in the stone.
> >
> 
> For what it's worth, I like "!cmd".
> 
> Would it be good enough to set some environment variables?
> 
>     [alias]
>     command_in_cwd = "!cd $GIT_CWD; ..."
> 
> Adam

I'd be tempted to say that setting $GIT_CWD was an ideal solution, if
Junio hadn't mentioned the possibility of cwd being the default in
1.8.0, which to me sounds much more sane than defaulting to the
repository root. Defaulting to the root has never made sense to me and
has some perfectly good built-ins to emulate if needed. I know I have at
least two scripts-which-should-be-aliases sitting around because of this
restriction.

-- 
-- Will
