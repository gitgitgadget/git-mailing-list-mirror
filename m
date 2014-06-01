From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: Reset by checkout?
Date: Sun, 01 Jun 2014 13:26:26 +0900
Message-ID: <20140601132624.821C.B013761@chejz.com>
References: <20140531144610.754B.B013761@chejz.com> <53898448.8040105@bracey.fi>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun Jun 01 06:26:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqxM1-0001kV-LE
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 06:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbaFAE0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 00:26:30 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:52455 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaFAE03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 00:26:29 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so3101817pbc.30
        for <git@vger.kernel.org>; Sat, 31 May 2014 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=14oKkRqoaba1YipfcB8x7JjmLsjLoSRHCCHp3KJru60=;
        b=BYOIrX5EVLxxpmqSjs6SQ6b74t3Yh4/9hfazW+sYwQCpuNbkLGehhhx/P36J5ijS8c
         1fHu8VM6sY82ghuqXRvCegKddealoAtBOMsxQJg/qeGRPmk7JSirPDpGz7M5n26ISOX/
         JAhxpV5QFTeyO4NZEQPtw/gNcInp2Hj9llZ7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:cc:reply-to:in-reply-to
         :references:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=14oKkRqoaba1YipfcB8x7JjmLsjLoSRHCCHp3KJru60=;
        b=Qf47pXKiwmg9B8tnu7HmHsd0xdMpcNgjkvgM8oTWIWrZsLuHLfKdKepIRXvoqXlgw3
         NQP9QkuIDAKAHisLnMjna41gnpNMO9htgpE9p+L6eMUsZmAr3utMD2DyM0kCyCiDcIfu
         oZwwFbSXm9w8/G2uOT5ttPnEwsrJ8X5vaz8liuVeKwXwZ86254sMHHIc+wUUyV//kevJ
         WAqbb/eohDN6GJsUgj/rjOgaYdPHmKo8BpNO6I2iBHE5i17y7z086MKwhEDXQaQ+o26C
         /0cfk29PDHrsd5xcR6hD67bF61ukcQWVkCQMx/aSXn11LmBMXD239Lh8fZUtSj4iGs37
         WjYg==
X-Gm-Message-State: ALoCoQnd5e5Z6BhQ2crJwM1b2AMiCYI/5ODjHMHJ2iOZpG44nWkfGOaRCeP+FV0vOsEWdC7N7V6D
X-Received: by 10.68.241.68 with SMTP id wg4mr31412652pbc.66.1401596788639;
        Sat, 31 May 2014 21:26:28 -0700 (PDT)
Received: from [127.0.0.1] (KD106168138162.ppp-bb.dion.ne.jp. [106.168.138.162])
        by mx.google.com with ESMTPSA id uk1sm43031281pac.26.2014.05.31.21.26.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 May 2014 21:26:27 -0700 (PDT)
In-Reply-To: <53898448.8040105@bracey.fi>
X-Mailer: Becky! ver. 2.65.07 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250518>

Kevin Bracey <kevin@bracey.fi> wrote:
> On 31/05/2014 08:46, Atsushi Nakagawa wrote:
> >    `git checkout -B <current-branch-name> <tree-ish>`
> >
> > This is such an useful notion that I can fathom why there isn't a better,
> > first-tier, alternative.q
> ...
> 
> I guess in theory using "checkout" allows fancier extra options like
> "--merge" and "--patch", but I don't think I've ever used those with
> checkout, let alone this mode, where I really do just want a "reset",
> with safety checks.

It does indeed have those fancier options.  However, I just noticed
there's even a 'reset --merge'!  And like you say, I can't remember ever
using 'checkout --merge' together with 'checkout -B'.

> The original "git reset --hard" used to be a pretty top-level command.
> It was used for aborting merges in particular. But I think it now
> stands out as being one of the only really dangerous porcelain
> commands, and I can't think of any real workflow it's still useful
> for. 

My thoughts exactly.  I think the 'reset --soft/--mixed/--hard' pattern
is so ingrained, that many people just don't realize there's a safer
alternative.  (I've heard work mates on more than one occasion
recommending 'reset --hard' as the go-to command for discarding commits.)

I believe this is likely because many third party GUI tools just don't
support 'reset --keep', and these tools present a "Reset..." dialog with
the de facto Soft/Mixed/Hard options.  (Even 'gitk' does this.)

> Maybe it could now be modified to warn and require "-f" to
> overwrite anything in the working tree?

If people just forgot about '--hard' and used '--mixed/--keep' for
regular cases, '--hard' would effectively be -f. ;)

> While digging into this, it seems "git reset --keep" is actually
> pretty close to "git checkout -B <current branch>". It certainly won't
> lose your workspace file, but unlike checkout it /does /forget what
> you've staged, which could be annoying.  Maybe that could be modified
> to keep the index too?

Yes, I didn't realize that 'reset --keep' existed and now I'm feeling a
bit silly for asking.  The index preservation artefact of 'checkout -B'
could be useful, though I can't remember at this point if I've relied on
it in the past.

The documetation for 'reset --keep' is ambiguous about what happens to
index entries of differing files, so modifying it may be an option if
there's demand..  I'm going to try out 'reset --keep' for a while and
see if it does get annoying.

Cheers,


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
