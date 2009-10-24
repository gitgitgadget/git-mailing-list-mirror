From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Use fast-forward
Date: Sat, 24 Oct 2009 17:17:47 +0300
Message-ID: <94a0d4530910240717i7c8fe973w2623d095daf04ca6@mail.gmail.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
	 <20091024220709.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 16:19:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1hSQ-0003am-G8
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 16:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbZJXORs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 10:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbZJXORr
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 10:17:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:48813 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbZJXORq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 10:17:46 -0400
Received: by fg-out-1718.google.com with SMTP id 16so4367983fgg.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DDEC/rZ/E0pBjLRTaigb02sCWGCCSaC/uNgoYkn7rNE=;
        b=qeN/kmZSa2LasJvQMwwobvsM9U1UZ1kkcYGqxaP8xurrW/Y+Frq22I4yaBGyrIpcaN
         Wa/YzHtfm68wBZJO1e82uUOQ8KAisUykBgCR6Flvj6XeXUP1m5ZqPioLDuHTytwszHFK
         pHpRnN8NdBFhIMt7/Dc5OLU3RJ6besxiulN7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Mv6Q4vo96fhT5nm/SLGF8pp8ww3Sdcl2WEyjEHlaK6WdAsytOqNLJcsotEdh785Ley
         9u6sTEz6Swv8Q0ClxBYNzhkUfv3nMYz3mJm13O7rpy55GK8agHNLAZ0Ro2eiNY0FcfKt
         hYyPAhzrugrLjYoTe5AC4IY2PScnFojvFHKQE=
Received: by 10.86.221.25 with SMTP id t25mr6641966fgg.19.1256393869916; Sat, 
	24 Oct 2009 07:17:49 -0700 (PDT)
In-Reply-To: <20091024220709.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131165>

On Sat, Oct 24, 2009 at 4:07 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Felipe Contreras <felipe.contreras@gmail.com>
>
>> As suggested in the mailing list, now I've replaced all instances of 'fast
>> forward' with 'fast-forward'.
>
> I had an impression that the consensus from the previous
> discussion was that there is no such consensus that this
> is an improvement, because there isn't a clear-cut rule?

I don't think anyone wants to preserve the current inconsistent use,
and I haven't seen arguments in favor of 'fast forward' either. My
understanding was that the comments were in favor of 'fast-forward'
but making it consistent across the code-base:

http://marc.info/?l=git&m=125532404330701&w=2
http://marc.info/?l=git&m=125535210203730&w=2

-- 
Felipe Contreras
