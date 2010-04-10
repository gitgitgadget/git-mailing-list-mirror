From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Re*: [PATCH v9] Documentation/remote-helpers: Add invocation 
	section
Date: Sat, 10 Apr 2010 18:06:58 +0530
Message-ID: <m2jf3271551004100536q65725be3i224c7e7fb334563@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> 
	<20100407224942.GA20239@progeny.tock> <7vzl1eamss.fsf@alter.siamese.dyndns.org> 
	<h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com> 
	<7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 14:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ZwG-0004CN-LU
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 14:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab0DJMhV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 08:37:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35661 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0DJMhT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 08:37:19 -0400
Received: by gyg13 with SMTP id 13so2085853gyg.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OHLV+N5fw+a1uEiKEMmY6NKEqb6rA/SwotT136SI6Mw=;
        b=OBim1b9v9ZZ8RvjwJp2+aVGbab29L09TdqOYV+aC47EdpvCPswwHkfSJSX2ASCsma2
         iYyeAiCQGfHe/4oxevxrX4qTIxkb8BAAOLRUgG9KU//D9V9Rtp17mURnHAOv2eBsf0ff
         M503IbfnnYvl+teWkJbQYA21I+Kkk6mYnX7kI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J7LJ59UeWjOOrHGnqw+MR6yf2ih0zRv+vxQ/oKq5/ulKxptV+lvDOeSqRd7OaMFPiK
         5jIqvpoeJlmU5WoVN+t8AE7ygUItHAt08AOnSk8MiRjibKMHdBKkDjSBReKcQsgOGF7h
         /riAS6zRrQrVnTjn5yYnymulpbaQMaFpDb01Q=
Received: by 10.90.69.14 with HTTP; Sat, 10 Apr 2010 05:36:58 -0700 (PDT)
In-Reply-To: <7vfx3567e2.fsf_-_@alter.siamese.dyndns.org>
Received: by 10.91.162.16 with SMTP id p16mr590232ago.101.1270903038523; Sat, 
	10 Apr 2010 05:37:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144543>

Hi,

I like the idea, but I think it's too verbose. Perhaps something along
these lines?

1. In general, base your patches on 'master'.
2. If your patch is a bugfix try to base it on 'maint'. If the bug's
in 'master, but not in 'maint' also, base it on 'master'.
3. If you're working on a feature, some of whose patches are already
in 'pu', base your work on the tip of the last commit in your topic
branch (See THIS). If it's a minor correction, you might want to add a
note asking the maintainer to squash it into the previous commit.
4. If you're working on an elaborate feature that depends on many
commits in 'pu', maintain a public branch based on 'pu', and
periodically post patches to the mailing list for feedback (all based
on 'pu'). You might have to rebase/ wait before it's finally merged.

THIS:
> + =C2=A0 work on the tip of the topic. =C2=A0"log --first-parent mast=
er..pu" would be
> + =C2=A0 a good way to find the tips of topic branches.

+ "The grandparent of this merge commit is your latest commit in this
topic. This is the commit you should base your patch on."

-- Ram
