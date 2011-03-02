From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Wed, 2 Mar 2011 13:34:58 +0100
Message-ID: <AANLkTi=YHNnuBAF_GitrmMYFK1h_p9JP54hRyj9vWTzc@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
 <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
 <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
 <7vsjv6evy4.fsf@alter.siamese.dyndns.org> <4D6D0A51.9030701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 13:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PulHN-0004zO-CR
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 13:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722Ab1CBMfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 07:35:39 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43782 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562Ab1CBMfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 07:35:39 -0500
Received: by yia27 with SMTP id 27so1466929yia.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=a5UILhFiX3YQKrl6nVCrdcylW4p3lyKeBNusPL5GV1k=;
        b=iOz/J05RecyxC4lBoA1LoZQ7PGUUPtAhFqEu+QU774IAqOsI/S2em/Y5M6QyaIHK4f
         p55SOnYoEKCu/Axa/dbzd+lyo/uorz0ACxgbmvFIYjzF5127X7ju0T2CNCJwJimuVOWU
         eXPzVgP4wWQd7LVWWWVw2dQH3oSDef2h8o2Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=B40SqILLPPZKTsXztjP3xHjzAgH4NIeKTv2gsWfSjtHt3R8n7clY/cl/4RJhe3iGpQ
         GRPSCN2aR/bsr+hI6B2h8hnq+/KiPe3VduhneFGcoBD+L8dm3zbllBoFRkBRIxNkR3jt
         0yZjRqEScIbm4RbRbNhAaFyaTHBO6qw7sCR5E=
Received: by 10.150.66.10 with SMTP id o10mr83635yba.235.1299069338095; Wed,
 02 Mar 2011 04:35:38 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Wed, 2 Mar 2011 04:34:58 -0800 (PST)
In-Reply-To: <4D6D0A51.9030701@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168303>

Heya,

On Tue, Mar 1, 2011 at 16:01, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> I have to say I'm really excited about how transparently this works
> across all kinds of commands, and how suggestive this is with rev:path
> in mind.

I like it, especially considering how small the impact on the codebase
is. The downside is (once again) backwards compatibility though, I
haven't heard much on how to address that, other than "just quote it"
(which _I_ think is fine, people with filenames that start with fancy
characters are probably used to quoting them anyway), but what does
Junio think?

-- 
Cheers,

Sverre Rabbelier
