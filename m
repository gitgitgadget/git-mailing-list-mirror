From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [Announce] bup 0.09: git-based backup system for really huge 
	datasets
Date: Fri, 12 Feb 2010 12:51:35 -0500
Message-ID: <32541b131002120951h25368812w547e8dcbaf054fa1@mail.gmail.com>
References: <32541b131002091448o6f809322x1d86d2d7f74a80ed@mail.gmail.com> 
	<20100211135129.GA2988@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Fri Feb 12 18:52:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfzgQ-0006Qb-Ul
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885Ab0BLRv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 12:51:57 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:47671 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0BLRv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 12:51:56 -0500
Received: by gxk24 with SMTP id 24so2641848gxk.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Bq3fwu7jgV2rNWOvHx+9TDYGQS4+celwZdDSawJycXQ=;
        b=q+IGnveMlE0S/XQH/NY2ybusTE3+7FOpQpCAyIT5D6VaqDZ4+Jsvw2Me65f92HleXC
         jwVhr8j6HlXW6WZSkkLaaFJ62QFmka12fI4azYTtOURsK2RoSjAOXIH58YOi+ztNBXt7
         nSCZX7JnK26SwbyDkGCQ/SAkb0Fm7o4sNQoE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KWKpYQMY+DYoaawaMsiOCfvrkvv6KcfxfAR4sPV9jnJTDLg6/pQv4mm1h+CArYGRZd
         5yPQT+HaEXVQcDjw0J5mC2AlMzpSK2Fq5zP5ts2UWJKm1EQZHw6SdSPV76ND3VbyJwAD
         kED8yHcEXag8ldr/Bq7yAa7FXLDi/1aX1r6/o=
Received: by 10.150.56.11 with SMTP id e11mr2788833yba.212.1265997115388; Fri, 
	12 Feb 2010 09:51:55 -0800 (PST)
In-Reply-To: <20100211135129.GA2988@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139732>

On Thu, Feb 11, 2010 at 8:51 AM, Stephen R. van den Berg <srb@cuci.nl> =
wrote:
> Avery Pennarun wrote:
>>bup is a file backup tool based on the git packfile format. =A0If you=
're
>>interested in git, you might find bup interesting because:
>
> Interesting concept. =A0It has some killer features which make it a g=
ood
> competitor to any of the existing solutions.
> The only obvious thing missing for unattended backup-operation is a w=
ay
> to purge specific or old backups.

Thanks.  Oddly enough, pruning of old backups hasn't been a really
high priority for me (or apparently any of the other users) because
chunking-based deduplication is so efficient that my backup disk
hasn't filled up yet :)  But it's clear that this will need to be
added eventually.

Unfortunately git's normal pruning and gc stuff is inapplicable since
it dies horribly when faced with hundreds of gigabytes of data.
That's to be expected, but it means I can't just cheat by running 'git
gc' and hoping for magic.

Have fun,

Avery
