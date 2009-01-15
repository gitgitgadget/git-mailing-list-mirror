From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Thu, 15 Jan 2009 14:46:12 +0100
Message-ID: <20090115134612.GA6556@atjola.homenet>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de> <496EE74F.6000205@viscovery.net> <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com> <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de> <8B5B7148-B900-4E01-9B2C-16C251966F7F@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSZR-0005h0-6K
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969AbZAONqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757070AbZAONqP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:46:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:36473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757011AbZAONqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:46:15 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:46:13 -0000
Received: from i577B90FF.versanet.de (EHLO atjola.local) [87.123.144.255]
  by mail.gmx.net (mp070) with SMTP; 15 Jan 2009 14:46:13 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19fIK1uCERfHIT7tTLgtwMYTqZP6e0IHtQs+M8Ivx
	X1SxHoX/FhyG4a
Content-Disposition: inline
In-Reply-To: <8B5B7148-B900-4E01-9B2C-16C251966F7F@frim.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105806>

On 2009.01.15 12:57:04 +0000, Pieter de Bie wrote:
>
> On Jan 15, 2009, at 12:36 PM, Johannes Schindelin wrote:
>
>> BTW I was not fully happy with 'edit' back then, either, which is th=
e
>> reason why I showed the usage in the comment _above_ the commit list=
=2E =20
>> But
>> nobody could suggest a name that I found convincingly better.
>
> (BTW, I reply to this thread because I'm also often confused with the
> rebase. The thing that hits me most is that with resolving conflicts,
> you have to do a 'git commit' and with 'edit', you have to do a 'git
> commit --amend'. This can get confusing if you set up an interactive
> rebase where you have some new picks or squashes, and also an edit.
> If the rebase stops, you first have to carefully read whether you're
> supposed to do a 'git commit' or a 'git commit --amend', and remember
> that until you're finished with the changes).

You can handle both cases with:
git add -u # Or whatever
git rebase --continue

Only when you split a commit, you have to explicitly reset and commit.

Bj=F6rn
