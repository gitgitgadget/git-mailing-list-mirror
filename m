From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Don't use the dashed for of git commands
Date: Sat, 30 Aug 2008 22:56:35 +0100
Message-ID: <b0943d9e0808301456t603834d4lb98c38fef83de9e5@mail.gmail.com>
References: <20080827002827.14720.45394.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:57:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZYRz-0001JY-Df
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbYH3V4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 17:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbYH3V4h
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:56:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:2651 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbYH3V4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 17:56:36 -0400
Received: by wa-out-1112.google.com with SMTP id j37so853087waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8x2sH445h5OiOjKfdGxgFI03xus5aEJC9H4cJm35O7s=;
        b=sPEqVWvp6xPiEX5DzhUa+0pCeDeIBy24ttB+lVs0AqCknjfuFyz2N78ENauonKU0D9
         yAvVSTrA/UKrWsN2+wEJkXvJR56panG/rXX5mY3lUs/NkSNsQ7lfizMd5LGl+8s7Rn5B
         3mKdk6o8I85F/TlfGeDmYJomnIzzFlCoDhPd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JRJ75tYMUQ7vZTODd9AokbakhvM04MDgKpkQTEuJSjFh+or3dIRYHOmdXtq/U9YdU1
         Zdy9ReqO5APP9E/NVxcRFV37RRErFnwYzVibUjSw3/biPimZCUWq97sCzDz5mM71jfJN
         nbp/2ouUu/XYrL3Wzxy38jceOomNPvYVz6iFs=
Received: by 10.114.197.10 with SMTP id u10mr4012219waf.66.1220133395652;
        Sat, 30 Aug 2008 14:56:35 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sat, 30 Aug 2008 14:56:35 -0700 (PDT)
In-Reply-To: <20080827002827.14720.45394.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94437>

2008/8/27 Karl Hasselstr=F6m <kha@treskal.com>:
> With the release of git 1.6.0, the dashed forms of the git commands
> are no longer installed in $PATH by default, so trying to use them is
> likely to fail. This patch replaces all remaining dashed git calls by
> their dashless equivalents -- even in comments and docs, for
> consistency and to aid grepping.

Great, thanks.

--=20
Catalin
