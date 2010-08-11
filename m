From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [WIP/PATCH 0/4] Re: Making error messages stand out
Date: Wed, 11 Aug 2010 03:31:00 -0500
Message-ID: <20100811083100.GA16495@burratino>
References: <20100725005443.GA18370@burratino>
 <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
 <201007251122.41166.trast@student.ethz.ch>
 <20100729235151.GB6623@burratino>
 <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6js-0007sO-ID
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681Ab0HKIcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:32:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61791 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932677Ab0HKIcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:32:31 -0400
Received: by yxg6 with SMTP id 6so4026022yxg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4qLLE/6NMDvcWHtyQ6e3jrGZNbhBB3qik4ZtpWxLJss=;
        b=IXrTIBMLFTTWgRWsI+IBD4kS+Qg4IdQZx2GcZISReLy2BbSiQJjr99KlfPVp9EGvCb
         nllOnI23pxw9wlmMtVh1UqYn9mA10695HyYse3tpbErBLfQAMBBEmgPQJqp/iRHVO1E2
         72JA9j6x8wYXeUPy0klNgRMPVU0ATvoewNBA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FQ8IrZa1/Vtoe4I+T2uZ6GxasbAVZfKGHJ1zQJymxSrgHIPIyJAfMABx1y19qbvlD9
         UyXnJkN9GNuwMfvhjwKeTswM8/epc8tf7lmqasmSzhffgmvFQ/nsl/N2BYnPYM/BK//c
         9HbqcQ9yeC/WNJvOQ5xSumFvQXRaaqHJZMW4g=
Received: by 10.100.154.15 with SMTP id b15mr21006232ane.20.1281515550324;
        Wed, 11 Aug 2010 01:32:30 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm12264005ann.0.2010.08.11.01.32.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:32:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153203>

Sverre Rabbelier wrote:
> On Thu, Jul 29, 2010 at 18:51, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> though, I find the best solution is to use short, formulaic messages=
:
>>
>> =C2=A0...
>> =C2=A0Recorded resolution for 'dir/a'.
>> =C2=A0[detached HEAD aa9ae6b] related change
>> =C2=A0 1 files changed, 1 insertions(+), 1 deletions(-)
>> =C2=A0fatal: could not apply 649420f... second
>> =C2=A0hint: after resolving the conflicts, mark the corrected paths
>> =C2=A0hint: with 'git add <paths>' and run 'git rebase --continue'
>
> Yes please. This would be _extremely_ helpful!

Ok. :)

This does not suppress the =E2=80=9CCould not apply=E2=80=9D message at=
 the end yet.

Patches are against cc/revert.

Jonathan Nieder (4):
  Eliminate =E2=80=9CFinished cherry-pick/revert=E2=80=9D message
  Introduce advise() to print hints
  cherry-pick: Use error() for failure message
  cherry-pick: Use advise() for hints

 Documentation/howto/revert-branch-rebase.txt |    6 ---
 builtin/revert.c                             |   52 ++++++++++++------=
-------
 contrib/examples/git-revert.sh               |    1 -
 git-rebase--interactive.sh                   |    6 +-
 t/t3507-cherry-pick-conflict.sh              |   20 ++++++++++
 t/t3508-cherry-pick-many-commits.sh          |   42 +++++++++++++++---=
---
 6 files changed, 78 insertions(+), 49 deletions(-)
