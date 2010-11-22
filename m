From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] bash completion: add basic support for git-reflog
Date: Mon, 22 Nov 2010 23:50:44 +0800
Message-ID: <AANLkTinJPQF-khzViED+ROyojEr9nHrcgwKQWsDugD7Y@mail.gmail.com>
References: <1290274368-3212-1-git-send-email-rctay89@gmail.com>
	<20101122152409.GA7010@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Nov 22 16:51:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKYfa-0007Sg-DB
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 16:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab0KVPuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Nov 2010 10:50:46 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43543 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab0KVPup convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 10:50:45 -0500
Received: by eye27 with SMTP id 27so3928770eye.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JzmEQ+gl57l0YI7VJ6XmYGg0kpOLcR3VKnquueqGWkQ=;
        b=CirtIlUfjrUdV7GNbfN8KDwQzZOGikCvte0O2hdC+dLCJlk+ygxLBY7XZCFRx4pBSv
         s6UEZ3KFX8KyMj+Eu9P5iEnKPT6BsT5sr4LT9480dEgRljLDA7RDpi+btTN5JQkKd0YP
         hg7mLTsa3V0V3e15AScCA6Qo1oheZtc/YP1KM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eJjF0l6gKyGuKQGRvre46oh3N/+waqB+9FB9VKdbqUbTpUxn/VLJLCrWrbHq7UQJ0g
         g5eOJ64CB4513N2zlFp2hxvkJNLSIOcCoxsR7kvDslYqCFP+N7ysA3/t6m+q2ZVnqp4i
         uPlzvfxon4Xy9N+PlIkjj/nGmgtVzMucK6pBU=
Received: by 10.213.33.14 with SMTP id f14mr7952070ebd.15.1290441044222; Mon,
 22 Nov 2010 07:50:44 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Mon, 22 Nov 2010 07:50:44 -0800 (PST)
In-Reply-To: <20101122152409.GA7010@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161899>

Hi,

2010/11/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> On Sun, Nov 21, 2010 at 01:32:48AM +0800, Tay Ray Chuan wrote:
>> Add basic completion for the three subcommands - show, expire, delet=
e.
>> Try completing refs for these too.
>
> Heh, I've always thought reflog is plumbing, and that's why the
> completion script doesn't support it.

That didn't really cross my mind, I just did this out of my irritation
with its absence.

(After some checking, it's actually part of git-log, so I don't think
it counts as plumbing.)

> This only looks at the previous word on the command line, and leads t=
o
> wrong behavior when an option is used:
>
> =A0$ git reflog expire --verbose <TAB><TAB>
> =A0delete =A0 expire =A0 show
>
> To prevent this you could use the __git_find_on_cmdline() helper
> function and follow how other completion functions use it.

Yep I'll look into it.

--=20
Cheers,
Ray Chuan
