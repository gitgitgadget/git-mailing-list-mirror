From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 13:36:25 -0400
Message-ID: <4C4DC799.6070702@gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> 	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> 	<4C4DB9AC.9000306@xiplink.com> <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmai
 l.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Avery Pennarun <apenwarr@gmail.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRbQ-0007bU-2V
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab0GZRgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 13:36:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59381 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0GZRga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 13:36:30 -0400
Received: by iwn7 with SMTP id 7so2941240iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=F7WU6Gp7k4pN/jHFhiINgEitJVrA4aWJafexrOEjJ8c=;
        b=rWbnraKsrBHjxmEcfTm3q3zh2dwJaqInnkIUpNNizxRanjuuOG0MCUHgPcQAM7hMX0
         AJerfHAZpV4YWFVf9VABqwKJKkbi3Z5tbxAf+jMpJE1KLZLPtCv41HcBz/NSz8xAtZxz
         QgyZ8LNfBupDrr+LnkLIsvattg2LQOkiHiDTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=x6Rah+BvgKYdQcSmsZi8m+LqDYOoj/42jBqZRYhjrdBcaqhJI2nqGxTZralU3PccsP
         T1oCK06mZnVttmfe/fjavMHhGQX4Y/aCC8BEXmGQtXd0/xjmpwL4QmVan9pkMloBmA0N
         tHTOOjnrynViQFqBfqXjji2ryqB4i8am7QBZQ=
Received: by 10.231.31.135 with SMTP id y7mr8974813ibc.182.1280165789634;
        Mon, 26 Jul 2010 10:36:29 -0700 (PDT)
Received: from [192.168.1.102] (69-196-134-89.dsl.teksavvy.com [69.196.134.89])
        by mx.google.com with ESMTPS id e8sm3850693ibb.2.2010.07.26.10.36.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 10:36:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151861>

On 10-07-26 12:41 PM, Linus Torvalds wrote:
> On Mon, Jul 26, 2010 at 9:37 AM, Marc Branchaud<marcnarc@xiplink.com>  wrote:
>>
>> I think I should mention one aspect of what we're doing, which is that a lot
>> of our submodules are based on external code, and that we occasionally need
>> to modify or customize some of that code.  So it's quite nice for us to
>> maintain private git mirrors of the external repos, with our own private
>> branches that contain our modifications.  Although we want to get much of our
>> changes incorporated into the upstream code bases, upstream release cycles
>> are rarely in sync with ours.
>
> THIS.
>
> This is why I always thought that submodules absolutely have to be
> commits, not trees. It's why the git submodule data structures are
> done the way they are. Anything that makes the submodule just a tree
> is fundamentally broken, I think.
>
> That said, I'm not competent to comment on the actual user interface
> issues. I can well believe that git-subtree has a nicer interface.
>
>               Linus
>

To me, that's what git-subtree is: an internal private mirror of an 
external repo.   Using git submodule moves that into a separately 
managed repo, which is just unnecessary hassle.  Why maintain repo 
called "clone of library X for project A" when you can just stick it 
inside of project A without any downsides?

For us, changes are made in the superproject and tested in the 
superproject.  Once they're tested, a git subtree push or a git subtree 
split pushes the patches to the subproject.   Once the subproject has 
accepted the patches, a git subtree pull merges them.   Same workflow as 
the "private git mirror of external repo" listed above, just without the 
hassle of having another repo to manage.

Bryan
