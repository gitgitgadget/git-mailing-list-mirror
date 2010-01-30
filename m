From: Mark Lodato <lodatom@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:53:47 -0500
Message-ID: <ca433831001292153idee3677gf9761d9726dca135@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> 
	<7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> 
	<alpine.LFD.2.00.1001292013150.1681@xanadu.home> <ca433831001291840o751fa02eve1ae301537674325@mail.gmail.com> 
	<alpine.LFD.2.00.1001292208470.1681@xanadu.home> <ca433831001291959m76ed6adap32a17c10e465af1f@mail.gmail.com> 
	<alpine.LFD.2.00.1001292305500.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6It-0007zh-VJ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab0A3FyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 00:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095Ab0A3FyJ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:54:09 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:49523 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0A3FyI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 00:54:08 -0500
Received: by pzk2 with SMTP id 2so2305723pzk.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=102szciCoHrf4dINbv8xKKbmmbtbCg5vA8j7X6qBhQM=;
        b=aWxYEAhSirC87mnhJmLXqn+IShdAvEb2qxFDW45cClY2kyKWgi0Dy94XtRukvUk7Ws
         uHBeTDfiB5vTaxIGc5dSvRB0Sb+ebERsQkBR/XTA1n4fxzMg0WgX91ZKFS5SLpZaQ9mi
         cTnDHzhnd3iEgJMSXb6DF5nEkwNA8Bil4JQRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=q/p8ZuYBkxUL0RsfbayMkVAl6GgS1zt0gblLZa1w+Sn0SqJpq2UCFwprI+xpxfyboa
         X67Cdx6CEKznUmm69orHbpfPzLhsn9wHcbQ6r1FtSIY/eD9eHvekk3IhROBcXlVhFp4I
         eWs/aPLEUJMdvkB0NmRTOp2sMKxvjzXbdu43w=
Received: by 10.114.188.38 with SMTP id l38mr1236366waf.63.1264830847086; Fri, 
	29 Jan 2010 21:54:07 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001292305500.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138450>

On Fri, Jan 29, 2010 at 11:39 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> First, I'm afraid that "Checking out commit 'foobar'" might be confus=
ing
> as this may happen through either a remote branch, a tag, or any rand=
om
> commit. =C2=A0It seems to me that "Checking out 'v2.5'" is less confu=
sing
> than "Checking out commit 'v2.5'". =C2=A0But that's a minor detail an=
d
> probably a personal preference.

I'm fine with "Checking out 'v2.5'".

> I consider that starting the explanation paragraph with " any commits
> you make will be lost" is even more unfriendly, and misleading. =C2=A0=
That is
> sure to scare people needlessly.

See wording below.

> I think your wording is just too far on the negative side, and makes =
Git
> look like an even more difficult tool than it actually is.  And you h=
elp
> no one by stating things that are not exactly true even if the truth
> implies that you need to know what you're doing.

What is not true?  Sure, they're not really "lost", but there's no
concise yet fully correct way to say the full truth.  Would you prefer
"discarded"?

> The _whole_ and only
> point of a detached HEAD is actually to be able to make commits even
> without having to create a new branch first.

Wrong.  I have never (purposefully) made a commit on a detached HEAD,
yet I use a detached HEAD all the time.  Why?  Because I checkout a
particular commit to look at code at a given location.  For example, I
recently ran "git checkout v1.6.6.1".  I did not intend to make any
commits on this; I just wanted to look at and compile code at a
particular version.  I think most users do the same thing.  The reason
for the warning is that folks make a mistake of trying to commit
without first switching back to (or creating) a branch.


Anyway, how about the following message, which is more in line with
Junio's last version?

-- >8 -- not a patch -- >8 --
Checking out 'master^0'.

This is not a local branch head, so you are in a 'detached HEAD' state.
If you only plan to look at files, this is fine.  However, any commits =
you
make will not update a branch, and may be discarded when you check out
another branch or commit.

If you want to create a new branch to retain commits you create, you ma=
y
do so (now or later) by using -b with the checkout command again. Examp=
le:

 git checkout -b <new_branch_name>

HEAD is now at a9d7c95... Merge branch 'maint'
-- 8< -- not a patch -- 8< --
