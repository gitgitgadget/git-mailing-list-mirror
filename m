From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 12/15] for-each-ref: introduce %(upstream:track[short])
Date: Tue, 4 Jun 2013 17:14:19 -0400
Message-ID: <CAPig+cRsDWSsC+K0SN9x06LmBOGi02SLPMLC5jgONuSU_8-Dfg@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
	<1370349337-20938-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyYl-0004MY-3I
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab3FDVOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:14:24 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35616 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3FDVOW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:14:22 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so769557lbf.36
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xUi0l0YftlrZ86MIyhJIgk0TqfVxxhKTOMq9XCQUPFs=;
        b=wmt0AI5fWXhPnsN+MTcl4IMuU2aozhFW9PxeOAV9t6ds2WuKzqlTgZnrhFNaCafdSj
         5REmSHoq8o1DjlekTzImi1PbQuVMk/w/F9pcEFXMRizSgWeFfsCAPGflK2/0ncNV9SxO
         11hAIealwbFbdRQnQgDr8tveJOM3kpQ2ZSnc4hkHcWKf+JIBomEertDGqii5Y6shuwXJ
         Eel4lIGyFfdQW0+0xCdgI/L540Vw/4TaNOAXp9fWsmWsFRYvcN7rD8ObPlVWxrl2CLRH
         KrE/ABGzGa/yTt0kmycmNektifh+St5HUxfn7Z1Tuc0tu8/MdrBtguCOsSMrtKcxakVH
         pnNA==
X-Received: by 10.112.88.166 with SMTP id bh6mr13951130lbb.47.1370380459766;
 Tue, 04 Jun 2013 14:14:19 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Tue, 4 Jun 2013 14:14:19 -0700 (PDT)
In-Reply-To: <1370349337-20938-13-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: zn-V-BxUGpFSOqTKzqPdmxuX4cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226406>

On Tue, Jun 4, 2013 at 8:35 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Introduce %(upstream:track) to display "[ahead M, behind N]" and
> %(upstream:trackshort) to display "=", ">", "<", or "<>"
> appropriately (inspired by the contrib/completion/git-prompt.sh).

Bikeshedding: s/trackshort/trackbrief/ perhaps?

> Now you can use the following format in for-each-ref:
>
>   %C(green)%(refname:short)%C(reset)%(upstream:trackshort)
>
> to display refs with terse tracking information.
>
> Note that :track and :trackshort only works with upstream, and errors

s/works/work/
s/errors/error/

> out when used with anything else.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
