From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Thu, 18 Mar 2010 12:19:13 -0500
Message-ID: <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de> 
	<7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> 
	<4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de> 
	<32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 
	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> 
	<32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 18:19:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsJNk-0003E4-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 18:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab0CRRTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 13:19:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:53576 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0CRRTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 13:19:34 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2736587fgb.1
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V/1eZ650BKJkMCOsi4+sNM82g2MLdLsNEEd9L0WnfKw=;
        b=U1oPsgR1k/M6gRGT8swa+MxLxM6UABTGM5/2dZ4fC8I+jSrpsGexNoFCxycXaMrXHn
         aocYMU8uW+aU4bmf98k5eqLrL21CFxVQ3cIdcZBOwNxMLgDdm/FS09VBILe4NjuQoDcD
         n6wQywiPg/rEEMfeiMrhItrTrh/YOPZLXZW3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R9zcp01q9yUT6DcQvychgtIOPnZPKUeT01x8/NF+L76y0luLzRxR/G0HaNYp2fy0pR
         eSrRXNwPZz2bB1n/uMpTsr3VEwWeimJL9kfk/DZaJU0dfKORXll5Seu5dOhPKv4uNNJV
         G+O8Lm3AY4TVL04k+5rg9Ys4jC+QJ8R2MgYqA=
Received: by 10.239.188.210 with SMTP id q18mr1371079hbh.143.1268932773103; 
	Thu, 18 Mar 2010 10:19:33 -0700 (PDT)
In-Reply-To: <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142482>

On Thu, Mar 18, 2010 at 11:36, Avery Pennarun <apenwarr@gmail.com> wrot=
e
> On Thu, Mar 18, 2010 at 6:11 AM, Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>>> You may want retry the command after recording the local changes
>>> (1) in a temporary commit on the current branch,
>>
>> Can commits be consistently marked for intermediate use?
>> Can such "special" commits be easily found later on?
>
> You just make the commit with a 'FIXME' type commit message, then 'gi=
t
> commit --amend' to fix it when you come back later.

Something more explicit might be useful in my opinion, as suggested in
this previous post:

    http://marc.info/?l=3Dgit&m=3D126768880311121&w=3D2

    > I'm not sure how often WIP commits become
    > accidentally published or left in the history,
    > but perhaps it would be advantageous to
    > provide a means of specifying officially that
    > a particular commit is in fact a WIP commit
    > such that no other commits can be made on top
    > of this WIP commit and it can't be merged with
    > other branches or pushed or whatever.

>>> or (2) by using "git stash".
>>
>> Is this storage operation supported per branch?
>> Does a checkout look if any files were stashed away for the specifie=
d branch before?

Markus, this was discussed ad nauseum in the other thread:

    http://marc.info/?l=3Dgit&m=3D126746296820948&w=3D2

    http://marc.info/?l=3Dgit&m=3D126749413508313&w=3D2

    http://marc.info/?l=3Dgit&m=3D126746730431007&w=3D2

Are you not reading? Are you not comprehending? Are you trolling?

> stashing isn't really something you'd want to do on a per-branch
> basis. =C2=A0Most of the point is that you stash away your changes, t=
hen
> switch to another branch, then restore your stash to your *current*
> working state sometime later.

As you may know, "git checkout" carries local modifications to the new
working tree if there are no conflicts, so no explicit stash usage is
necessary in many cases.

Anyway, I think it would be useful to be able to manage multiple
stashes rather than having to rely on just one global stash. However,
I imagine than explicit Work In Progress (WIP) commits as sketched
above would go a long way in keeping histories and workflows clean and
organized.
