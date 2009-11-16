From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: .gitignore polution
Date: Mon, 16 Nov 2009 01:22:41 +0100
Message-ID: <fabb9a1e0911151622p7863093dn175d2510a88bf268@mail.gmail.com>
References: <fabb9a1e0911141557k5f6b0b8aud48b95784a9da4e3@mail.gmail.com> 
	<20091115094352.GA21477@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 01:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9pN7-0005ok-8P
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 01:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbZKPAW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 19:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZKPAW5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 19:22:57 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:65208 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbZKPAW4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 19:22:56 -0500
Received: by bwz27 with SMTP id 27so5168186bwz.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=28R/XYdxVMCh9navsHhXAgZm/BgoxAv9lHs6gccJIiE=;
        b=rCJAigw/1I2SuGhg+7Z7T77+PC/4dzn5XJawnqRtBVZSzd3opn9gLgAiayG4cEleaK
         Kiitbe5h1D+PSsAtf7ganVP/q0p2YrwIU+GtxgtAYOvXLX7B8IfX2E1SZM9O78qN2Xn+
         5lvf/Pt1DoNcV3liAp2EdwUa3BZMCDaMkX/LM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R7vCvBVLLdMjUNnretepsQE47G/Er+W7sBMam2TdFlQ6DhsK3eVnlkc+aK2+qQrSsj
         WEo9hJJx/lvSvO/ck3Ts97RycQQ3OhE4f7UH1OQG+lnCDL5de8E+BzKxFS6CA1nN6ixB
         lVKi67aIzJExSJhptWdVr4KyVjcSVV9ppdEfM=
Received: by 10.216.93.74 with SMTP id k52mr938027wef.144.1258330981195; Sun, 
	15 Nov 2009 16:23:01 -0800 (PST)
In-Reply-To: <20091115094352.GA21477@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132975>

Heya,

On Sun, Nov 15, 2009 at 10:43, Jeff King <peff@peff.net> wrote:
> The other option is to mark them for ignore outside of the
> branch-specific ignore:
>
> =A0git ls-files -o --exclude-standard >>.git/info/exclude

Ah, that would work, thanks! :)

--=20
Cheers,

Sverre Rabbelier
