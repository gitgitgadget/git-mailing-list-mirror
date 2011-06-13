From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sun, 12 Jun 2011 22:14:34 -0400
Message-ID: <BANLkTikNwk0HpJ-G+fc7NwRdY_=Hy930iQ@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<m339jps1wt.fsf@localhost.localdomain>
	<BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
	<201106051311.00951.jnareb@gmail.com>
	<BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
	<7vwrgza3i2.fsf@alter.siamese.dyndns.org>
	<4DF08D30.7070603@alum.mit.edu>
	<20110609161832.GB25885@sigill.intra.peff.net>
	<4DF10ADA.5070206@alum.mit.edu>
	<7v8vtayhnm.fsf@alter.siamese.dyndns.org>
	<20110609200403.GA3955@sigill.intra.peff.net>
	<7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
	<BANLkTin_NYZ39s7gXbVrbAZU=+fzRCHdcA@mail.gmail.com>
	<7v8vt6spr0.fsf@alter.siamese.dyndns.org>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 04:14:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVwfq-0004C5-3W
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 04:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab1FMCOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 22:14:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47761 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1FMCOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 22:14:36 -0400
Received: by bwz15 with SMTP id 15so3380273bwz.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PbVMnjZVJ5lCOXd75UHSUQPfV0/7EnUL3jxNboZKdUM=;
        b=vroNOS1DD8eCI+1DvfzdtvtDcLEpbxYDPe/FKD1YjL7upNJeWaCRCLiIA/yt5ysZrn
         JRqsQs9wr1exd7K9s48iB2cG/WWDDQVa8pLrDTaR9HcKJGzAoHzLTN6RwsHe8IeRZey6
         2Db9R4huon9YYVshzWjQqxWHd9+8OYFVnXzZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=ppQ40wI85qI+Ts5X0NFBHQG2zLIZQAOTtG1n5ROFs6Hr510uFAJrpvd+YfvDtw9bGi
         XZleNhdSsAFLVEAekrca1kishgpyLXHgYnVjK6AaINaRHGmXGnzLsyTlnpdX2Z2Fo/8s
         zcFeb0APf3drhFL/v8cLXaGRxfz6tm4BfBlvo=
Received: by 10.204.168.194 with SMTP id v2mr3952965bky.169.1307931274702;
 Sun, 12 Jun 2011 19:14:34 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Sun, 12 Jun 2011 19:14:34 -0700 (PDT)
In-Reply-To: <7v8vt6spr0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175675>

On Sun, Jun 12, 2011 at 5:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Nahas <mike.nahas@gmail.com> writes:
>
>> It is clear that implementing NEXT/WTREE will worsen the performance
>> of some commands ("git diff" under merge conflict).
>
> It is not clear to me at all. I generally do not to base my first
> objection on performance. When I have problems with proposals at the
> design and concept level, I do not have a chance to even bother about
> performance aspect, before questioning the proposal.

My apologies.  "Performance" was an ambiguous word.

I meant that "git diff" under a merge conflict would be less
informative if forced it to be equivalent to some notation with
NEXT/WTREE.  Even if we allowed diff3 and defined BASE, OURS, THEIRS.
