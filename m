From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: EasyGit Integration
Date: Thu, 11 Jun 2009 01:04:32 +0300
Message-ID: <94a0d4530906101504j7928b0aaqff4c30c5136eec44@mail.gmail.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 00:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVuW-0006M7-2Q
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 00:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZFJWEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZFJWEd
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 18:04:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:41753 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbZFJWEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 18:04:32 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1380400fga.17
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sAyDXGiLJzMMiGyP4jYNNY8KybTQBUsa2X2KrZu0q6g=;
        b=MGKQc7pXp0vUedszPJcntBQFH6N1m1s+11OfdxZsm/xd7vn1SMlMdPz1Rr1byrg0Uw
         THxeHhdm2zhVTofGc0vpsnunLfGu1gdFm6igqSzcGsA7+QO0XxdfWp+70iqNteTnO3yv
         des04RsqpV567tzxVoPrAyFL7bRCokkg/nHZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mCSY6Sz65aWM15PsKQQDl+mvWhBICiFM91kkeAbSsHLRkVOM0LKwfKUEGgmGnAAyEl
         fyxsqLsctoe+qecYHbl06j5KFMx4/7EiVwus9xXBVL7lbw6gRogYKS3YjRACt99HPD5m
         /sRa3cVLY17fWEzsD+XCEQmvPcVoHYUQeMAYE=
Received: by 10.86.86.10 with SMTP id j10mr1536424fgb.37.1244671472678; Wed, 
	10 Jun 2009 15:04:32 -0700 (PDT)
In-Reply-To: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121311>

On Tue, Jun 9, 2009 at 9:59 PM, Scott Chacon<schacon@gmail.com> wrote:
> Hey all,
>
> I have been playing with the EasyGit project lately and I have been
> really impressed. =C2=A0I looked back to the last announcement here a=
nd the
> conversation didn't really go anywhere, sadly. =C2=A0I thought it mig=
ht be
> nice to adopt or at least consider a number of the design decisions
> they made in modifying the defaults and commands available. =C2=A0Per=
haps
> as a 1.7 goal or something? =C2=A0I like it because it addresses a lo=
t of
> the issues that I hear from beginning users:
>
> * breaks the various things that 'checkout' does into separate
> commands - moves 'revert' to doing what 'checkout -- path' does, move=
s
> current 'revert' to 'cherry-pick --revert' (which someone mentioned
> was a good idea at the last GitTogether), and adds 'unstage' for
> 'reset HEAD file'. =C2=A0also adds a '-s' option to 'branch' to switc=
h to
> the branch after you create it, which many people expect rather than
> 'checkout -b'.

I like 'git unstage', but not the rest.

> * adds 'git resolved' for 'git add', which I hear all the time as
> being confusing

I would prefer 'git stage'; 'git resolved' seems to be meant for a
very particular case: resolve conflicts, it would be much better to
learn that you can do 'git stage' at any time.

<snip/>

> * 'git backout' for 'git reset HEAD^'

I don't like that. Looks like a very specialized case. It's much
better to learn this particular use of 'git reset'.

> * 'git push origin --delete <branch>' for 'git push origin :branch'

That would be really good, it took me a lot of time to find that idiom.

Cheers.

--=20
=46elipe Contreras
