From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v3 8/9] t3903-stash.sh: tests of git stash with stash-like 
	arguments
Date: Sun, 8 Aug 2010 22:56:09 +1000
Message-ID: <AANLkTik8jN_LqB+mOqDAGzFnBo4R0_LDxApshm5iGORa@mail.gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
	<1281242771-24764-9-git-send-email-jon.seymour@gmail.com>
	<201008081132.56998.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, ams@toroid.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 08 15:05:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi5Yn-0001Yv-Qv
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 15:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab0HHNE5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 09:04:57 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61555 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936Ab0HHNE4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Aug 2010 09:04:56 -0400
Received: by qwh6 with SMTP id 6so6413177qwh.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NLnnFNjlx8JeQ2PYoVmMNRbaru2WXtiv4G9HYH6fnPo=;
        b=Dlq+qT6ONQAgkH+wiMd0tlnn2b7sG0wSaVWX/zIYbegFrN3/EXJqA6+1aN9/Q7+zxL
         BqK+RaKzbR839S5TFEKyeKcNcrm3B5afeRXhrlR53O45ICA36Y6+LgjAVGVoNYfj7eGH
         a4nvN8ZEDlqxbg9m1gCr3FX/eMpmyMd37W2mM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rCC/WmPhUMpqC2ZWR33ITpdX71tiH4smb1asOsjfAwTWtUnDtONpYA1/fCxOQRtPto
         HrXfZjtLHe+jhNOY3sa+OtZKKUccXuWVe4GtquHxcSeFSrnFvUPtQm7pZBO2KVGAJPSL
         BI47Oq6nKESDTgEY1lxjpMQzV/xJG/LmAaIZM=
Received: by 10.229.249.198 with SMTP id ml6mr6373362qcb.117.1281272169989; 
	Sun, 08 Aug 2010 05:56:09 -0700 (PDT)
Received: by 10.229.222.13 with HTTP; Sun, 8 Aug 2010 05:56:09 -0700 (PDT)
In-Reply-To: <201008081132.56998.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152905>

On Sun, Aug 8, 2010 at 7:32 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Sonntag, 8. August 2010, Jon Seymour wrote:
> To catch failures in $(git stash create), you should rewrite lines li=
ke this
> one as:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0stashid=3D$(git stash create) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git tag stash-tag $stashid &&
>

Good point. I've replaced the use of git tag with a variable
assignment and dereference and will repost the series with these
changes in a day or two.

Regards,

jon.
