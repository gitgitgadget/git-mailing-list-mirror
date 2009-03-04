From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git as backup/DRP; also meta-question about Majordomo
Date: Wed, 4 Mar 2009 14:36:30 -0500
Message-ID: <76718490903041136h620ac07eq21f5970d2053acd2@mail.gmail.com>
References: <274eb6f0903040951g27cb4956u1d101c84952d0090@mail.gmail.com>
	 <274eb6f0903040956t36580a8ayd269f74882724637@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Damon Getsman <dgetsman@amirehab.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lewur-0005gG-UX
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 20:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbZCDTge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 14:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbZCDTge
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 14:36:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:58077 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbZCDTgd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 14:36:33 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1020407rvb.5
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PHjJRhQxCKgo87kRzg4Vsa58wYieH0CYm370PrBT6RQ=;
        b=QDe+Xic/fowoFkQyC/odvR4EMfQneRzsj4KPgfeQJKJYBc1xeMi8z+y8AnXu/27EPR
         0D1r7sibaqgmAZVw7XKJ5RTy7CHB5ZxuuKcGN1t5EofX91DpYixyTdULx00o+5DMpsQy
         cpWk0VXvp+DstgtfXQSsSuT2ZhIE+/njiUbVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IUM317/4zbkA2E4scu3OwrYtJzm2CEgCAfroDeqKmazDlqM9t5hBYiftZiaW5YNq4G
         QOtD9y97MP7H55dQiAUm1NfHWMT4IzGYX0A5iH4V6gEFKqV9RXzW8V0isWRhyrK9vvyx
         HvN8zGmusMGRlxVp9uGoWBaXxpK2gxh2rvjYs=
Received: by 10.140.187.14 with SMTP id k14mr101686rvf.270.1236195390231; Wed, 
	04 Mar 2009 11:36:30 -0800 (PST)
In-Reply-To: <274eb6f0903040956t36580a8ayd269f74882724637@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112239>

On Wed, Mar 4, 2009 at 12:56 PM, Damon Getsman <dgetsman@amirehab.net> =
wrote:
> =C2=A0Hello! =C2=A0:) I've got a couple of questions for y'all.
>
> =C2=A0Q1: First of all, I'm being handed a project whereas I am to fi=
nd and
> implement some sort of backup system across a wide range of various
> Linux hosts and a couple of windows machines.=C2=A0 This backup syste=
m is
> to basically be a 'pseudo-TimeVault' if you're familiar with Mac
> OS/X's current backup system.=C2=A0 I need to be able to roll back to=
 any
> particular revision.

I think you may want something more like
http://www.mikerubel.org/computers/rsync_snapshots/

You're going to run into issues with git if you have to store very
large files. Also, if you need to delete a file from the backups for
some reason, you may find it more difficult than you'd like (you have
to use filter-branch and rewrite history).

I'm not saying it cannot be done with git, but you'll be using it for
a purpose for which it was not intended.

You might also consider a filesystem which offers snapshots.

> =C2=A0Q2: I haven't found any way to tell the 'majordomo' mailing lis=
t
> software running this list that I am not happy receiving 40-60 emails
> in my business email inbox per day.=C2=A0 Of course I can use google =
to
> filter them, but I'd still rather just get a daily digest if this is
> at all possible.=C2=A0 Am I missing something obvious?

vger.kernel.org does not offer its lists in digested form. You can try
reading the git mailing list via
http://dir.gmane.org/gmane.comp.version-control.git,
http://marc.info/?l=3Dgit, or consider signing up for a webmail account=
=2E

j.
