From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] reset: add --quiet option
Date: Mon, 30 Nov 2009 13:45:30 -0800
Message-ID: <780e0a6b0911301345v42c2b22bs34092fb69b21a2a0@mail.gmail.com>
References: <1259492290-21771-1-git-send-email-felipe.contreras@gmail.com> 
	<1259543939.5679.5.camel@swboyd-laptop> <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 22:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFE4C-0006qT-PH
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 22:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbZK3Vpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbZK3Vpp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 16:45:45 -0500
Received: from mail-px0-f173.google.com ([209.85.216.173]:37803 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbZK3Vpo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 16:45:44 -0500
Received: by pxi3 with SMTP id 3so3241436pxi.22
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 13:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=59jIntFbogKMJZjZUL2HRh/N5O973RIPJ5gk9PN4Ybw=;
        b=RzsDG/2/8Loy3wkcCpumLLlXk+9qDDfc9XS7okRuN2yE9nkP6o+qm3Gy4vpq4mkvZ0
         cIYkYM1y7j/g0wG5247L3l+DTsWxCQC813jhqgoRASljDoZnPQcV00qFg8C42Gb24x+u
         ogKkBy7yZUrNFcxY+kSqbE2sQpvModiauOIXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vPKjUvPFC6RQDNsr2PkaGHjroInFZ6Rj4LSBcmPunKJTw8MqjQsVXurl8D2vLGG8pD
         P9/Nhj4ZNKte9jMK2C+nuHZwaOSYOTaAVAYcKpe7zb+nimaui0/0NRo7HIFAXc3FSKMK
         Kir1WS5dEPI6x0CkIFhKrCKtaG6uBCONzqIb0=
Received: by 10.142.119.7 with SMTP id r7mr500141wfc.261.1259617550158; Mon, 
	30 Nov 2009 13:45:50 -0800 (PST)
In-Reply-To: <94a0d4530911300219j51e21e2cwae17d4248400a345@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134144>

On Mon, Nov 30, 2009 at 2:19 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> I thought somebody would complain about loosing that string. In any
> case, first step is adding --query to 'git reset', second step is
> moving all OPT_BOOLEAN('q' to OPT__QUIET; there are other commands
> doing the same.
>

If you're already touching the line why not just do it once? I agree a
follow-up patch to cover the other commands would be good.
