From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different from the parent
Date: Thu, 1 May 2008 10:34:44 +0200
Message-ID: <8aa486160805010134l4746f9afhec546a9d49fd7a6d@mail.gmail.com>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com>
	 <1209545236-4266-4-git-send-email-sbejar@gmail.com>
	 <20080430145017.GA922@sigill.intra.peff.net>
	 <20080430163701.GA6544@sigill.intra.peff.net>
	 <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com>
	 <20080430192639.GC30344@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Alex Riesen" <raa.lkml@gmail.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 10:35:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrUGS-0001e7-Dk
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 10:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbYEAIer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 04:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbYEAIer
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 04:34:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:63185 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYEAIep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 04:34:45 -0400
Received: by yw-out-2324.google.com with SMTP id 5so489660ywh.1
        for <git@vger.kernel.org>; Thu, 01 May 2008 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/QxP9JCJF7az9S9jrdJEVpsXYpwnUcpgHz09bBNo67E=;
        b=bGToxgBkskTQ7S+HtvHMv8UKZZB7Hr17qP5n0kCDy1zuxw7BI8FpfG7JKkodQNHF8GtGSbTxWl01XF7btDIFasEGe7eIbphMKrcNEk3qTQNp3BO8N/CUidnMFOQ57jmp+N6vJs1FrySBoIVYXfQfxgLD+qxw4o/TtGaGzL9/xhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LVjm4VEIqUfpEfz600lpMjHZ0Q+eqGtHqc8uezJ8vCoegAdFbbHdEA8TbDlWQL23G4X1b6vt3z5HRkt1Ox1ccyoc05+vFKCtUkjsDKtufX4+rTFH/4spTBvXZx0YUi1xFuBBjppoUqPi6pMQnqthPAXnNR4orM0oFm86O5358VM=
Received: by 10.150.68.41 with SMTP id q41mr2091225yba.105.1209630884664;
        Thu, 01 May 2008 01:34:44 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Thu, 1 May 2008 01:34:44 -0700 (PDT)
In-Reply-To: <20080430192639.GC30344@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80894>

On Wed, Apr 30, 2008 at 9:26 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 30, 2008 at 09:23:43PM +0200, Santi B=E9jar wrote:
>
>  > >  I like the idea in general, but the implementation could be ref=
ined.
>  > >  Maybe consider looking at user.name (whether the repo has an id=
ent
>  > >  set)? This is usually done conciously, and the user wont need t=
his
>  > >  reminder.
>  >
>  > Maybe only show the committer ident when both happens:
>  >
>  > 1) the committer ident is different from the parent
>  > 2) the committer ident is set automatically
>
>  Honestly, I think just "2)" is probably fine (where automatically
>  presumably means "from GECOS"). I see what you are trying to accompl=
ish
>  with "1)", but it's so workflow specific as to be useless.

I don't see "1) as workflow specific, it is there to minimize the
number of time it is shown, ie somebody might prefer the automatic
ident, so as long as it does not change it is not shown.

Santi
