From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Mon, 30 Nov 2009 12:19:27 +0200
Message-ID: <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com>
	 <1259543939.5679.5.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 11:19:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF3Lx-0001j6-Ph
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 11:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbZK3KTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 05:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbZK3KTV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 05:19:21 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:59752 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbZK3KTV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 05:19:21 -0500
Received: by iwn1 with SMTP id 1so2112252iwn.33
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Po45Yu7OSSBGoRnb6zI4+k/EXiZa5rFkzV3S7Mltviw=;
        b=czJdK8nfctdoPlsUtegAy8bPvK2xgclVUUZpJA9qnocj0GKB7NDGll6+hImE0PsEYT
         AO74GO4+FeEhZGQ/4eU9f/z1xr0PeUyyfFV6Y+1+AzDdXiuGHSHZx8TSgCG3yk9F+IJH
         l+s0WgcHgDRO4tRHPb70E67tmsLNhJCL8Z2lA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NIQ8opY3+DcGRVyIAdwO4SHVIw9pID6ORTHv3SzlM5F11Hpi/aKNcpcG7U4B13Qmwv
         XUT0ztkie/qLZ4dPxqFEedrptP6RDQp8BngLTSFgVejBITLILqB7COrSvZmupK/HrnNY
         Az7PiG6detplNaOhi2DemJRE44wKpkQ1CDclE=
Received: by 10.231.5.23 with SMTP id 23mr5731643ibt.45.1259576367342; Mon, 30 
	Nov 2009 02:19:27 -0800 (PST)
In-Reply-To: <1259543939.5679.5.camel@swboyd-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134090>

On Mon, Nov 30, 2009 at 3:18 AM, Stephen Boyd <bebarino@gmail.com> wrote:
> Why not just OPT__QUIET? We lose the specific help string but it's
> possible that what quiet is silencing will change in the future.

I thought somebody would complain about loosing that string. In any
case, first step is adding --query to 'git reset', second step is
moving all OPT_BOOLEAN('q' to OPT__QUIET; there are other commands
doing the same.

-- 
Felipe Contreras
