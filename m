From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 20:53:12 +0100
Message-ID: <fabb9a1e1002031153n6d579484vbd2ea3251fb72738@mail.gmail.com>
References: <20100203174041.GC14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Jelmer Vernooij <jvernooij@gmail.com>,
	Jelmer Vernooij <jelmer@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:53:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclIB-0007oe-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab0BCTxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:53:33 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:44798 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab0BCTxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:53:32 -0500
Received: by pzk27 with SMTP id 27so1820355pzk.33
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1c24/YBeU/pzWmKL9vr3Avq55iDFq9+w4O9wfHnWlU0=;
        b=MPZRY0vPWqoPxtRffcGFtJdyNzGaKNpLn0Uy1AFv+QuJAG+46jSZ/B2rcD3HFa5GvP
         9a5veE0aeXRX/jFiHnoeJJzp7vl8W1laARsXq3cLKMY9ags+BLaQus6pg/vWC1mbUWUW
         7lPxx7CdGAFUKv0MVj10MhkHY3W0bZU1TOLMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Zz2nJn/RiDMc7DGaEv2EF1Mmaiq37IM4T9FS4Bzk+YvsGP9hLJ35sa8wd8mwkOEu9c
         /T23Xfwe9QkCrNoH1OIluXOB6GQwDRLIjHdvZMOaAKXjSwDh4qgQTsuxXCD95W/bSlDR
         QaYI1E1hXdhg1Y7Tla+AiKEwcoKu3R7uUCU1E=
Received: by 10.142.250.19 with SMTP id x19mr39257wfh.23.1265226812175; Wed, 
	03 Feb 2010 11:53:32 -0800 (PST)
In-Reply-To: <20100203174041.GC14799@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138875>

Heya,

[+cc Jelmer]

On Wed, Feb 3, 2010 at 18:40, Shawn O. Pearce <spearce@spearce.org> wrote:
> I haven't spoken with Jelmer Vernooij directly about it, but after
> some indirect email through a 3rd party, it seems he might be under
> the impression that this really is a bug in Dulwich, because "other
> git implementations do it".

That would seem like the #1 thing to do, I'm sure Jelmer (cc-ed) can
both benefit from this discussion, and perhaps explain what is going
on from first hand. Full thread as it's developing can be found here
[0]. Jelmer, you can just reply to this, no need to subscribe or such.
Also, it's custom on the git list to cc all involved, so you should be
in on the conversation for any emails that are a reply to mine.

[0] http://thread.gmane.org/gmane.comp.version-control.git/138848

-- 
Cheers,

Sverre Rabbelier
