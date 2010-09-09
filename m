From: Carlos Eduardo da Fonseca <eduardongu@gmail.com>
Subject: Re: Tags only shown on log with --decorate?
Date: Thu, 9 Sep 2010 17:36:09 -0300
Message-ID: <AANLkTi=htz2+tPSNrt+niQPczAoTGeu2g0iWgjZoFxBb@mail.gmail.com>
References: <AANLkTikgxMFoiQm31FXgqBth=enVxxgxDJv8_97C30HF@mail.gmail.com>
	<AANLkTimOEQY9xJvindxuVPZotmWXZ=Ya9088ghL--Xuf@mail.gmail.com>
	<20100909194823.GB1146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 22:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtnrA-0001yG-QP
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 22:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0IIUgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 16:36:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59902 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab0IIUgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 16:36:12 -0400
Received: by vws3 with SMTP id 3so1730493vws.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=cG5/AFLygQfY1sMmFX7AHqp/tISOGgGL82xyWxZXOsA=;
        b=ITwhF6vxd+sQ8eKPZlHva/pzBSVeOQcMmsdzHPPCxhV4x69SiO4UdNkM+ahF3h0nCD
         LZqb3uoVZTI8gHffdzQW3uCN75MXUz6WTvpR56lt+m1dbDTpuxdJkFVqnReFVkEK/sev
         7F343U+/LMzYp6L8ht6K644vFZI2ulUXOFW9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Rkk7TfkvFmAgrL6iMxQcdOwNeppbtop8MAW7iCur09kvKmHDILoznobgRcBzLc1Gra
         byZ5MNjNaVqmirwVxmtuNJvvYEcNyJNShZNc5BtNLdaSsvuk7VXvzdpQbam6PqZZAuAf
         ZY/haaXYHkQT5TcDxcGd6zFOowzIgKtFKkkPE=
Received: by 10.220.60.199 with SMTP id q7mr246028vch.67.1284064570065; Thu,
 09 Sep 2010 13:36:10 -0700 (PDT)
Received: by 10.220.111.18 with HTTP; Thu, 9 Sep 2010 13:36:09 -0700 (PDT)
In-Reply-To: <20100909194823.GB1146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155901>

Well, I don't see how can it distract people, but I find important to
developers who clone/pull a repository to immediatly see what were the
tags added and what are they relation with commits when they "git
log".
I wouldn't (and I think most developers also wouldn't) remember to
execute "git tag" or use the "--decorate" parameter every time they
clone/pull something.
