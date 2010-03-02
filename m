From: Chris Packham <judge.packham@gmail.com>
Subject: Re: failed to push
Date: Tue, 2 Mar 2010 13:36:47 -0800
Message-ID: <a038bef51003021336g3ab0b4f6vba2738a18a92dd36@mail.gmail.com>
References: <4B8C2E68.3020507@gnu.org> <4B8C303E.7050605@gmail.com>
	 <a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com>
	 <4B8C38E5.7090305@gnu.org> <m3tysylexh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bkorb@gnu.org, Jakub Narebski <jnareb@gmail.com>, schacon@gmail.com
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 22:37:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmZlt-0005Si-JA
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 22:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab0CBVgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 16:36:48 -0500
Received: from mail-pz0-f201.google.com ([209.85.222.201]:51607 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab0CBVgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 16:36:48 -0500
Received: by pzk39 with SMTP id 39so237678pzk.15
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+R6kwczCECqFLEhI5+os8f017evluU916fQMq4pSWZ8=;
        b=I3JxLfR9TNpY11ANEsCyA5rinNv2pfvul+3jc/yq3NsE7mdHO0dpRG1mDjer+mAru+
         EdGMnFuyxm0DigwsiXHtxHjzZ5zLy7qPKLZZw2Ksvuhe9wvLdVsLw0uUzYSmxt1WSLu8
         gjEgZdKiCYax0Iw5wbjHvXRWrNVPd3xy71/7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QlAREZVCb09tOI7S+nEona6EhA9+wbpCwUpCh4dxiaBH+rV/vFrh8nFK9olTkaNy/z
         +Zz5y042RPiegK8vuNH1LHNRXx5ycn1FIaUU90ksCANxaW981/VGagaAjtR1fi7RqnDD
         y88FWXPlV6fk/WOwz52jqGiZjiwfmSQcy5QSM=
Received: by 10.114.3.17 with SMTP id 17mr3771166wac.185.1267565807475; Tue, 
	02 Mar 2010 13:36:47 -0800 (PST)
In-Reply-To: <m3tysylexh.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141417>

On Tue, Mar 2, 2010 at 11:09 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:

> Well, all of us old gitters know: 1) that you should not change
> published (pushed) history, 2) that commits are immutable, and 3) tha=
t
> amending a commit generates new commit with correction and therefore
> changes history.
>
> It is true that git documentation ("Git User's Manual", "Git Communit=
y
> Book", "Pro Git") can be lacking... unfortunately by the time somebod=
y
> is knowledgeable enough to write git documentaions, he/she is usally
> used to git way of doing things, and the documentation might not be
> newbie-friendly.

I thought I smelt an easy documentation patch but the current help for
git commit --amend seems to cover it

"You should understand the implications of rewriting history if you
amend a commit that has already been published"

These sections [1],[2] of the git community book could probably do
with a note on the consequences or re-writing history. I'll see if I
can figure out how to submit a change.

[1] http://book.git-scm.com/4_undoing_in_git_-_reset,_checkout_and_reve=
rt.html
[2] http://book.git-scm.com/5_modifying_your_history.html

>Bruce Korb <bkorb@gnu.org> writes:
>> Then please be kind enough to put a *CAUTION* button next to
>> the amend button and have it bring up something that gives you
>> a little warning. =C2=A0GIT *could* have been written in a way that
>> causes the remote repo to become synced with my local repo,
>> but apparently it was not and there was not adequate warning.

Shouldn't be too hard to repeat the warning from git help commit. Just
not sure of what the least intrusive way to do it is (plus my tcl-fu
is weak).
