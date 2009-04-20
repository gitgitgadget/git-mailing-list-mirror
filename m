From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 11:59:38 -0700 (PDT)
Message-ID: <m3ab6bp2we.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de>
	<20090420113216.GC25059@dpotapov.dyndns.org>
	<49EC6596.8060208@drmicha.warpmail.net>
	<20090420132414.GD25059@dpotapov.dyndns.org>
	<alpine.DEB.1.00.0904201621290.6771@intel-tinevez-2-302>
	<20090420160633.GA17241@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: =?iso-8859-15?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvyk2-0004o9-Dn
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 21:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZDTS7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZDTS7n
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:59:43 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:8344 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbZDTS7m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 14:59:42 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1401969tim.23
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=vY2zsMGW0BAGJsPv2eGhz1xRzsXZEVtBKdXYE/S5IVU=;
        b=CZyUSzyrU+xuWSxCBWkAPnMtm4ngv10wbXoi5gaObN1Rfv7o8tOciAU9V9Ho3QIu2X
         INkTO7S9Etu+fKnRQGw6GGdN1iroUzPuthDGptDJjhAPQGrJSui/Lu+52PAdl36ff36F
         qrLjwQIrjzJT4hiuWe92kPHqL+Wjq2Guf/EVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=I68ngtYTxRLLakMgDjEh1mJuhEKl4hkN1gJjH4G71nlDCzs/+jWaGkkGjxee49IG8D
         /GkdGCMLj4dfE0/cZWVPfFCVv6T4BMwa/lE+6tVIYlkkRM3hD7sgc/BR9ETw8iKB9F8A
         9QA/pBrMgpqbCVQFARzGOJi8HX7DnGNBVhe+8=
Received: by 10.110.16.15 with SMTP id 15mr6547670tip.26.1240253980329;
        Mon, 20 Apr 2009 11:59:40 -0700 (PDT)
Received: from localhost.localdomain (abwc215.neoplus.adsl.tpnet.pl [83.8.226.215])
        by mx.google.com with ESMTPS id i9sm1744614tid.12.2009.04.20.11.59.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 11:59:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3KIxWw8008862;
	Mon, 20 Apr 2009 20:59:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3KIxTZR008859;
	Mon, 20 Apr 2009 20:59:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090420160633.GA17241@atjola.homenet>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117022>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> If you go out, and look at a tree lit-up by the evil daystar, branche=
s
> start at the trunk and end at their tip. The trunk isn't part of the
> branch.  [...]

Well, you have to remember that the 'branch' metaphor should not be
taken too literaly; take for example merges which do not have
equivalent in a tree build.

But if we are talking about literal branches: take a closer loog at
the tip of tree (plant) branch.  You can find growong tip there
(apical meristem) where new cells grow.  In Git you have 'branches'
(branch heads) where you create new commits...

But I agree that there isn't for example true notion of 'trunk' in
git, and this is what allows Git to be truly distributed...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
