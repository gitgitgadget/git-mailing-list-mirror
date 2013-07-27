From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 14:14:06 +0200
Message-ID: <20130727121406.GB4940@paksenarrion.iveqy.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 14:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V33Lm-0004HK-2v
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 14:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab3G0MLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jul 2013 08:11:50 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:62467 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab3G0MLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 08:11:49 -0400
Received: by mail-la0-f45.google.com with SMTP id fj20so51056lab.18
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n3SM2Hni1fSMAcIJkNs0HM0ylxkfxuwkDHPO6YM36KQ=;
        b=DU9lA/FNkWa4lpNG5WD9/pRHSX9CJ1yzK2tN7oUVahH8SyqQMT/5G8EGG+IHD3nCLg
         PG0kuLWKAuJZ231B/hozLvcsY1JTU+KC82g2gzrPwzoRN6RhQ5uzBYu+kGcXVx7ZNL1n
         f/h+kTylCgBJnoWIRi9VRT85bsw0BszsSGHsCXoQmY2Po6TJYY5vWSUOpHIHpu6nshDs
         E4PfVbVCRc50HTXsPP36wKm/ATotcFTsn+RDAta5YLxBGSSI0bTJPMwVcDqYftHH+wO3
         tnpQcpQa8nWcDqxs0q57ENjIGRuXNCK3G3GjdBy7GzloSIzyWlbwAFsySqTbNVd+9YfE
         NT2A==
X-Received: by 10.152.5.197 with SMTP id u5mr23015774lau.59.1374927108350;
        Sat, 27 Jul 2013 05:11:48 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id rx1sm2606245lbb.0.2013.07.27.05.11.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 05:11:47 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V33Nu-0001mp-Q2; Sat, 27 Jul 2013 14:14:06 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231241>

On Sat, Jul 27, 2013 at 04:40:12PM +0530, Ramkumar Ramachandra wrote:
> Hi,
>=20
> I noticed a regression in the latest master, and I've been trying to
> debug it for 30 minutes now.  I'm still clueless about the root cause=
,
> but I'll list whatever I found so far:
>=20
> I suddenly noticed that I wasn't able to commit to a certain
> repository with submodules anymore.  This was because git commit was
> opening a COMMIT_EDITMSG in the wrong path.  To reproduce the problem=
,
> you need a setup like mine:

When I hear submodules, latest master and path the only thing that come=
s
to my mind that have touched these areas is
091a6eb0feed820a43663ca63dc2bc0bb247bbae "submodule: drop the top-level
requirement".

A first test could be to see if it's this patch does anything strange.
However this patch is in git since 1.8.3.3 so it's almost a month old.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
