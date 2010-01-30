From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:06:40 -0500
Message-ID: <76718491001292106je41d6e4x7341678c475122db@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
	 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
	 <7viqakcu56.fsf@alter.siamese.dyndns.org>
	 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
	 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
	 <ron1-F006CF.18381129012010@news.gmane.org>
	 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
	 <ron1-8B7921.19261029012010@news.gmane.org>
	 <alpine.LFD.2.00.1001292232130.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:08:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5Z7-0000Ze-M2
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab0A3FGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 00:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894Ab0A3FGm
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:06:42 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:48167 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab0A3FGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 00:06:41 -0500
Received: by iwn39 with SMTP id 39so753482iwn.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ghXe0gi2X+5MalSwE0/VRdeS8nEJvU5L+RtTVkwhV5Y=;
        b=UN4aQeIk5qSO8UfC9S5wE4rGGucA3d6HADCYMwISc8Gs9VDkhXY7lW9XysSDnPsHEO
         0bcrrYw6FEZjSLB6zILhl1ICWxzKPwqPNvvIn7hdc8dDZSpoL1Zn4NVSLxZ3sS3jIF4e
         tHPBAhS3l3zeuc5hMvdWFVHQZPR6XCYVsKo1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CECEKMG3/S5lKdbROk63VuLe8oQ6iKzFk8J4lCus912fIwR/hsOjA6WDDt0LkxeZzs
         efEv+RhOA75WIl/MlIpaNNxn9mRvsz9lND3wdSKM/DAJMqrAtVvW9qs9EpujY9laY+ZO
         nVSJKXYgIR9DFo1EymJU49FlQYQlj6yqHXJlU=
Received: by 10.231.147.70 with SMTP id k6mr2705057ibv.55.1264828000973; Fri, 
	29 Jan 2010 21:06:40 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001292232130.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138442>

On Fri, Jan 29, 2010 at 11:03 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> Have a look at http://eagain.net/articles/git-for-computer-scientists=
/
>
> That's one of the clearest explanation of the Git branching model I'v=
e
> seen.

Ah, I never realized this before, but it doesn't include any
discussion/graphic of what a detached HEAD is. It only shows HEAD
referring to a named branch.

> There is no contradiction. =C2=A0The "detached HEAD" corresponds to H=
EAD
> pointing at no branch in particular. =C2=A0There is just no current b=
ranch in
> that case.

Again (referring to my last message), I think Ron's confusion is that
"branch" can mean either a branch in the DAG which is your repo's
history, or it can mean a named branch (something under .git/refs),
and they aren't necessarily the same, although around here when we say
"branch" we almost always mean a named branch.

When HEAD is detached and you create a commit, you're effectively
creating a branch in the DAG, but this branch is anonymous and subject
to garbage collection.

j.
