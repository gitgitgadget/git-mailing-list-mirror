From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [feature wishlist] add commit subcommand to git add -i
Date: Sun, 14 Aug 2011 18:43:27 -0600
Message-ID: <CAJfuBxzseEtSLSupmragyoVbZBS9Cmmd9cabLzpdT+9xiQRbQg@mail.gmail.com>
References: <CAJfuBxwW8Dyp8FTS13uPOBKZGL9JOEqaSOhGN+zBJ_8BHpJE3g@mail.gmail.com>
 <CAOTq_pvMv6JN_jpQvDsmQTwmMgQK9JzuwXr+VF1T6X4=qf3GsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 02:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QslHn-0004IX-B9
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 02:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192Ab1HOAn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 20:43:59 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55716 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1HOAn6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 20:43:58 -0400
Received: by wwe5 with SMTP id 5so979394wwe.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 17:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aA2EcNsF+MUgDEC/1Ca2eoYKLZxzZmlGCBflTC60HYg=;
        b=JwzfXcaI3+++z882HE2n/cfoWIrw2Rodw+TlDACbs+B2U5Wt9f1K7+vOIvPhPTe0bx
         3/cHOUYQjKencI2wXmROjE4apD+0SLPtdjF7/0OPml6eK2bAImuthQUFhoQgWKAUngzR
         XwQG2RsevFfaQtzJ8KDH5TGYp+9cyg7vM8Vjw=
Received: by 10.227.137.142 with SMTP id w14mr2898895wbt.27.1313369037122;
 Sun, 14 Aug 2011 17:43:57 -0700 (PDT)
Received: by 10.227.121.131 with HTTP; Sun, 14 Aug 2011 17:43:27 -0700 (PDT)
In-Reply-To: <CAOTq_pvMv6JN_jpQvDsmQTwmMgQK9JzuwXr+VF1T6X4=qf3GsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179354>

On Sun, Aug 14, 2011 at 2:48 AM, Conrad Irwin <conrad.irwin@gmail.com> =
wrote:
> On Sun, Aug 14, 2011 at 1:38 AM, Jim Cromie <jim.cromie@gmail.com> wr=
ote:
>> going further, if git rebase -i =A0had ability to =A0"back" a fixup =
patch
>> back to where it should have been, and adjust the intervening patche=
s
>> where conflict would normally happen, that would be awesome.
>> Simplistically, this would just shift the patch 1 step back iterativ=
ely,
>> until it wouldnt apply properly, and then --abort, stopping at the l=
ast
>> clean rebase.
>>
>> apologies if this is too hair-brained, or already done.
>
> It sounds like you're looking for several git commit
> (-p|--interactive) --fixup <commit>, followed by a git rebase -i
> --autosquash. It's not quite as automatic as you describe, but I thin=
k
> that automating it would be pretty hard to do correctly.
>
> Conrad
>

it is indeed similar.  in the simple case, I know which patch needs the=
 fixup,
and using editor to rearrange the todo-file is straightforward.
using --autosquash requires knowing the commit-log message to be fixed,
and using it to name the fixup commit, which is doable, but I havent tr=
ained
myself to do so.  I'll give it a try next time..

thanks
Jim
