From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Tue, 7 Jun 2011 07:04:31 -0400
Message-ID: <BANLkTi=Wu77cJikN63NjSqb-PtB4+9BiEQ@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DEC8322.6040200@drmicha.warpmail.net>
	<7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
	<4DECE147.3060808@drmicha.warpmail.net>
	<7vd3ir9btd.fsf@alter.siamese.dyndns.org>
	<BANLkTi=KZN3g4s9jHSgYcPHA4eM+2U3g4w@mail.gmail.com>
	<7vr576943r.fsf@alter.siamese.dyndns.org>
	<BANLkTi=yytzDrJLvVn_ZhJOiQs-rqvKi1w@mail.gmail.com>
	<BANLkTinE8tCRZ-HFP0uwm6odGNAxjZPXng@mail.gmail.com>
	<7voc2a70f0.fsf@alter.siamese.dyndns.org>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTu5P-0001zj-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab1FGLEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 07:04:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36094 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab1FGLEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 07:04:33 -0400
Received: by bwz15 with SMTP id 15so4071022bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qxzd/QDCo+l9fcMmW9IN1qU1nEghma6hz2WsDLAiwiE=;
        b=uByxd7UoBXzXCTYYEcr8VmtLPLo9pH9JytfoSEEzeErHtbvklN4N/DFcjf3nCp/vjs
         0gYiZenfktOoDfZPtiY38p8pgFQZXzE1QuTJ2jWblGOmg5HVKG66w3sklRBuOWCV/Mf9
         ncN+A7ObNmHJeQMqsDphI3XgL/4DfPHXxDDdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=OU1WDAtbcBU7BgrgdSvK2A2hHKoRVD+qZWvD7z2KHD8GIGPZHepddAVlECIeU1/OTS
         EE8Nrqoh90eIx/z5XrmWmBzCs9ilsXeryGPWLnRzOViJ6BfCdGmWLakbNu+rQYNP6mdN
         dZ082jXWREjAQhptQApSWmL9yAJB8XqgzVCDw=
Received: by 10.204.171.66 with SMTP id g2mr512613bkz.7.1307444672223; Tue, 07
 Jun 2011 04:04:32 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Tue, 7 Jun 2011 04:04:31 -0700 (PDT)
In-Reply-To: <7voc2a70f0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175195>

On Tue, Jun 7, 2011 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Michael Nahas <mike.nahas@gmail.com> writes:
>
>> I think NEXT and WTREE should be like tree objects, not commits, so =
I
>> would argue that "git show NEXT" should show what it shows for a tre=
e.
>
> So what is the definition of such a "tree" during a conflicted merge?

Good question.  You've been asking it a lot.  I answered it later in th=
e email.

> The traditional definition is "such a state cannot be expressed as a
> tree". You are free to define it the same way, or for NEXT to be more
> useful than status quo, come up with a better definition.
>
>> My thought is that NEXT should only represent those changing files
>> that have been resolved.=A0 So, NEXT would be HEAD plus the files in
>> Stage0.=A0 So, "git diff HEAD NEXT" would print out the changes in
>> Stage0.

(during a conflicted merge...)
"NEXT would be HEAD plus the files in Stage0".

That is the tree.  HEAD plus the resolved files.

> That would mean conflicted files will all be shown as removed, or
> unchanged? =A0Either would be more confusing.

Conflicted files would be shown as unchanged in NEXT.

"diff NEXT HEAD" =3D=3D changes in resolved files
"diff WTREE NEXT" =3D=3D changes in conflicted files
"diff WTREE HEAD" =3D=3D all changes.

That makes a lot of sense to me.  Those are the three different
changesets I'd want to see and those are the logical commands using
NEXT and WTREE to see them.

I _believe_ but don't know for sure that that _is_ the current behavior=
 for:

"diff --cached HEAD" and
"diff --cached"
"diff HEAD"

If it is the current behavior, I don't see how it could be more
confusing.  It's exactly the same amount of confusing ... with a more
regular syntax, IMHO.


Another way to think about this:  If you had a conflicted merge and
someone allowed you to create the next commit with a command "git
commit --force", what would you expect to be in the created commit?
Wouldn't it be only the resolved files?  The files in Stage0?  The
files in WTREE have the "<<<<</=3D=3D=3D=3D=3D/>>>>>" blocks in them - =
would you
want to commit those?  No.  For those files, you'd prefer the versions
you already had in HEAD.

Mike
