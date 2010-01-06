From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 0/4 (resent)] Miscelanous gitweb improvements from J.H.
Date: Thu, 7 Jan 2010 00:22:29 +0100
Message-ID: <201001070022.31531.jnareb@gmail.com>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com> <4B450EA2.5020104@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 00:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSfB3-0003lx-9D
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 00:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637Ab0AFXUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593Ab0AFXUZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 18:20:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33950 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932489Ab0AFXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 18:20:23 -0500
Received: by bwz27 with SMTP id 27so11081235bwz.21
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 15:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=H/xIC8mIdOp+HlIdlLaCIrEwNHhiYIMlgYawP5ehpFQ=;
        b=Tt7dUntCoLnP61P1dXOG4IxDf1M4QIs1K6HJrJ+XTiDMF+gN+p9/KpN8xYz8Cr20LV
         CIiWyRjzYe3dWVsII1EZNss13Ao9RvOg/Xy/XQYbvIeeKpTi4kjIfanuRt8ul/68PY64
         mTgS4D+mvbCaH27lND5x2qwe31F79mmQwsIhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pYFPd0EV5AVImgh7sGK2PCj2DUwUqHVZ3P7WIUAr6CtVug3xvb4Ve9NXHhmdBfMIZG
         50dxFWCTGUf+4wks2Rp1CAiE7itXT1JUXrMNctYzKF5XBCOnnbivRPAmPW2kVFnc+LAg
         yxSO2y7D/3MPABdFN9+sXg1VPzaJkjxEa8RKU=
Received: by 10.204.33.130 with SMTP id h2mr668012bkd.103.1262820021776;
        Wed, 06 Jan 2010 15:20:21 -0800 (PST)
Received: from ?192.168.1.13? (abvd62.neoplus.adsl.tpnet.pl [83.8.201.62])
        by mx.google.com with ESMTPS id 15sm6883959bwz.0.2010.01.06.15.20.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 15:20:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B450EA2.5020104@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136309>

On Wed, 6 Jan 2010, J.H. wrote:

> Just a heads up I've been on vacation for two weeks and hadn't gotten
> around to dealing with these e-mails. =C2=A0I'm going to get them imp=
orted
> into my tree here and take a look over them.

They are also available from 'gitweb/cache-kernel' branch of my=20
git/jnareb-git.git repository at repo.or.cz... and are available from
'pu' branch in main git repository, as fbd43a8^2 (Merge branch=20
'jh/gitweb-cached' into pu, 2010-01-04).

It might be easier to import (fetch) them from that repository, and jus=
t=20
drop top two commits / merge jnareb-git/gitweb/cache-kernel~2


  git://repo.or.cz/git/jnareb-git.git gitweb/cache-kernel

John 'Warthog9' Hawley (4):
      gitweb: Load checking
      gitweb: Add option to force version match
      gitweb: Optionally add "git" links in project list page
      gitweb: Makefile improvements

Jakub Narebski (2):
      gitweb: Print to explicit filehandle (preparing for caching)
      gitweb: href(..., -path_info =3D> 0|1)

The two top commits on that branch are work in progress in preparation
for response caching for gitweb from J.H. (the one used on=20
git.kernel.org), and are not ready yet, I think; at least there would=20
be one more commit in "preparing for gitweb caching" (sub)series.

--=20
Jakub Narebski
Poland
