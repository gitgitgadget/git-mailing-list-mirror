From: Alex Budovski <abudovski@gmail.com>
Subject: Re: Noob question regarding git push
Date: Thu, 20 Jan 2011 13:35:07 +1100
Message-ID: <AANLkTimv8N7K2yvbgBnTzmTzaGtqf2tiS-Kk2-5Y__1M@mail.gmail.com>
References: <AANLkTi=X8PURGSX5ODHpXACUWuA0oioTkeNEmRVnkx1D@mail.gmail.com>
 <AANLkTik5QOoWNjUP8LvRE=AmiAtmchc8NND9aKDe2svR@mail.gmail.com> <AANLkTins5KrYmy6gBJXphEMhcgCEDYcbEGpb7nyU-P=m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Harry Johnson <hjohnson@viasic.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 03:35:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfkN5-0006IG-27
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 03:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365Ab1ATCf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 21:35:29 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46019 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab1ATCf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 21:35:29 -0500
Received: by eye27 with SMTP id 27so41909eye.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wn6gydjegWexjdpWDF0fa7NdKMvHdwSeE8Gw2bDAh/k=;
        b=KQDIkPoMHtEgtaa9CCu4djfSRiNSGSePyH7Zjsl6P/xBCUp0C5yJ3NtZFwNevEjfOg
         2q5kBMVDsR4DlNLJBkaqY5O3acMbvvXy6onQGUd/4fnq3SkEzyGV1heXlGArnkTV2VdM
         geHaV4KQLlq5hYiFUoLnn9Rm9S7ubKLY4mkrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=I8Xw+9NJQzrWvRAqQdLzAIR88gz1xWwEpUsDGZPuEhMKHFplDhJD/DnXXr8RunqgRH
         Ce6WN7swH6DNlHNPKpiZwYQgEFtDuIc5s3r6hCtQMGJkWHSgmayxZCFeuSNTjHpw3T3x
         moa1RO9S53TSCRK9ntd2hG4DBjgnrXEyg1CBQ=
Received: by 10.14.131.200 with SMTP id m48mr208088eei.19.1295490927760; Wed,
 19 Jan 2011 18:35:27 -0800 (PST)
Received: by 10.14.22.78 with HTTP; Wed, 19 Jan 2011 18:35:07 -0800 (PST)
In-Reply-To: <AANLkTins5KrYmy6gBJXphEMhcgCEDYcbEGpb7nyU-P=m@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165301>

On Thu, Jan 20, 2011 at 10:10 AM, Harry Johnson <hjohnson@viasic.com> wrote:
> Thanks! It was in that faq. So it sounds like I just need to do a git
> reset --hard before doing the builds... This shouldn't be a problem
> since that working tree should never have any local changes. It is
> just a snapshot to be used for builds. However, it does sound like
> maybe I should look into a bare repo and then the build repo could
> just be a clone of that.

The central repo itself should be bare.
