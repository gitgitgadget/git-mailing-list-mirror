From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Fri, 5 Feb 2010 09:42:22 +0100
Message-ID: <cb7bb73a1002050042w20c8ca58hfac4283bee0a3676@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7v4olxhrti.fsf@alter.siamese.dyndns.org> <201002041821.22864.jnareb@gmail.com> 
	<201002050144.50538.jnareb@gmail.com> <7vaavosdqq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:07:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL4H-0003Bj-5B
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab0BEImq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 03:42:46 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:57290 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab0BEImq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 03:42:46 -0500
Received: by ewy28 with SMTP id 28so3984403ewy.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AX0EB+lIPGPuL6e2uG2l2fpDDA914rmDjR/qMLvKg5Q=;
        b=iKdHBMWjuv3xoSotrqTFWEQykc5pOsW3/TNjnSJpmqUouQk9cX3dJG/QN6gZbNmmoU
         92uTiQFO1CdlIcKgj41jFjh3ktKax6jRPBJcxQX3s3180ztpnVtMWtmAbaqzCWeyeRoP
         h577lkQSEmiDBvfJNjwwV6w9B++e+afIFgtCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JOiKsdEf2TMQc4a0Uk1fnycmTSO1AQaht6CgF16Be8KInqVOCTGkhJ25KXt9+GGNKC
         1CInZ5ccVLBZjy5ZzV2VJOCDuasQrQhgh8L5Uyh3T1hhrBLV+/hJE+PCaNK2GFO564gB
         7J3P2SgSZl895AwNFxYWpEGnaPsLnaQd2UpQk=
Received: by 10.213.25.75 with SMTP id y11mr2080372ebb.5.1265359362349; Fri, 
	05 Feb 2010 00:42:42 -0800 (PST)
In-Reply-To: <7vaavosdqq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139038>

On Fri, Feb 5, 2010 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Still, 1 or 2 git commands per commit is a bit too much (with shortlog
>> displaying 100 commits per page)
>
> But who said you need to display notes for all commits by default?
>
> It could be a thing that you would get _on demand_, just like patch text
> or diffstat is given only on demand by going to the commitdiff page.

But while diffstat or patch text always make sense for _any_ commit,
since you always have them; notes don't, in the sense that you might
not have notes in most of the commits, and you might actually be
looking for commits with notes.

At the very least, a view like shortlog should give an indicator that
a commit has notes, and possible the namespaces where its notes are
(e.g., you're only browsing for bugzilla notes).

Anyway, since git cat-file --batch, or --batch-check if we only want
the indicator, (didn't know about these options, btw, thanks a bunch)
means that we can get all the notes with a single extra call, what's
the problem with displaying them?  ;-)



-- 
Giuseppe "Oblomov" Bilotta
