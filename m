From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Fix username and password extraction from HTTP URLs
Date: Sat, 13 Nov 2010 22:33:20 +0100
Message-ID: <AANLkTinf3T7_7WGv_W=f2bD0xs-VPS6d3iSQn_rOKn5S@mail.gmail.com>
References: <1289604025-6406-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
X-From: git-owner@vger.kernel.org Sat Nov 13 22:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHNkY-0007Bl-2j
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 22:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118Ab0KMVdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 16:33:42 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45848 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0KMVdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 16:33:41 -0500
Received: by gyh4 with SMTP id 4so2450997gyh.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 13:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GVG9znWMT0uiwlWk6MQp7dMXZeV1SW7imJUSWIiqkwg=;
        b=hZp/a5+wfHW2Nwh2n8BKcvZ9rApMfsQoezSmUYZfHWUfJDq6769LssgohinCj2jMWl
         KI1ucSerAtGdTpf209N/AhskuuHiIyPGPWEgdDD8+2DXReI0vu4H155mSifxm85GPF6d
         5ueZJHfNW+c0gDDebLLM5rr087uxHHwigABNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=m9aqxAprKTfoJy2OYVEO72aN+Qf6CAdFBPyykWIvKsiSzzfuAlfC+7zZEaOuqCAx3y
         cdK1zHEGo2qK7OyaU9IniewubCn8NjhriQ4gk67Jub70UcVGSEOW6ltu0X4dIHApgY+f
         Q5/4SND6QySY+voEFa2iKttn4a2UgME5Ai5tE=
Received: by 10.151.111.17 with SMTP id o17mr503938ybm.356.1289684020499; Sat,
 13 Nov 2010 13:33:40 -0800 (PST)
Received: by 10.151.100.3 with HTTP; Sat, 13 Nov 2010 13:33:20 -0800 (PST)
In-Reply-To: <1289604025-6406-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161398>

Heya,

On Sat, Nov 13, 2010 at 00:20, Gabriel Corona
<gabriel.corona@enst-bretagne.fr> wrote:
> Change the authentification initialisation to percent-decode username
> and password for HTTP URLs.

Can has tests?

-- 
Cheers,

Sverre Rabbelier
