From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 16:29:44 +0200
Message-ID: <200910111629.45111.jnareb@gmail.com>
References: <20091009012254.GA3980@debian.b2j> <200910111507.06926.j.sixt@viscovery.net> <200910111543.39327.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 16:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwzRe-0007hQ-Ev
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbZJKO31 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 10:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbZJKO31
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:29:27 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:60382 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbZJKO30 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:29:26 -0400
Received: by fxm27 with SMTP id 27so8140384fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BOyLTS3fCKToBj5zl02DiROXRjjEGzX0c80r8WyI5bk=;
        b=qGu/xeKsYHW/gF0Bi6JOoUCdDG7cCeuT7b/afNLp0cIxp4J/rfwVyzsH7+A8B3Cx5R
         yGVvbDybjXPZLW9Oolbz9iVvsh30qhl4qGNBP3a3+c9ietGs3VrGTdL+h1B0zgd/ihXh
         zmy9MrA6CuBW40DTeMWsH3RPmgqVVs3hlVc/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Vd5ac44Gk2wXrn9tLRLiv8qAf42seLoTHddJN1vzmVy9LetP4Z0iVbEA58PUFZgiYv
         1fpG449/i4ew8Zs2ZcnoyA2879Rh69/Pvpvrz+Fmbgr5swR3FpiqFzPYG3ddQuW4znus
         djTmejyXrVwT2GRnuR7UjY+I/8Sv+EWkK4Qn4=
Received: by 10.86.228.16 with SMTP id a16mr4363679fgh.49.1255271329471;
        Sun, 11 Oct 2009 07:28:49 -0700 (PDT)
Received: from ?192.168.1.13? (abwa37.neoplus.adsl.tpnet.pl [83.8.224.37])
        by mx.google.com with ESMTPS id 12sm1540856fgg.11.2009.10.11.07.28.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:28:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200910111543.39327.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129933>

Dnia niedziela 11. pa=BCdziernika 2009 15:43, Christian Couder napisa=B3=
:
> On Sunday 11 October 2009, Johannes Sixt wrote:

> > There is no way to retrieve the original commit using plumbing=20
> > unless the replacement is removed. Am I right?
>=20
> I think you are right, but a flag could be easily added to some comma=
nds to=20
> retreive original objects. Or you can remove the replacement, retriev=
e the=20
> object and then put back the replacement.

Wouldn't it be better for this option to be option for git wrapper,
i.e.

 $ git --no-replace cat-file -p N

and not

 $ git cat-file --no-replace -p N

--=20
Jakub Narebski
Poland
