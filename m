From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: moving to a git-backed wiki
Date: Wed, 02 Feb 2011 03:14:56 -0800 (PST)
Message-ID: <m34o8maduw.fsf@localhost.localdomain>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
	<7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
	<20110131225529.GC14419@sigill.intra.peff.net>
	<AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
	<20110201201144.GA16003@sigill.intra.peff.net>
	<AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
	<4D488DCD.3080305@eaglescrag.net> <4D4929F4.3020805@snarc.org>
	<AANLkTi=07yifUAQYqabA8Dv1qmBTe=50+BDN-b0YZ1zb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vincent Hanquez <tab@snarc.org>, "J.H." <warthog19@eaglescrag.net>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 12:15:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkag2-0003gp-AZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 12:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab1BBLPC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 06:15:02 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35196 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab1BBLPA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 06:15:00 -0500
Received: by bwz15 with SMTP id 15so419029bwz.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=+c8gxYofLuHi0GZQV7FlJM4HZeWffIi5hBpxW+uN0Ec=;
        b=G4ofevjHem+iHVJNkekMiWgYeSDU5DiKztWsw8YYUpNvjZGZBzjcRi9kbwgSxMCnk3
         yqGc3AQHr7BQpEpV7Z6g4Kepnx1HSZZhaUMV7U5g+GTim0/11Gvgn8fhm/gOexi2yKBc
         7LnL9cIIEfG8s80G2epW9FCyRmMRBg04/cqmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=iFQlJc/uPs0gVi3ov+KE+WMcGr7oUr5osTYwxw8U6V3MyZA59I2L372AbimeDuD+qy
         BT+CuBt2wFiD3l9giY6Ey62D9d9WCWru+Smc6uOkLtdTvEa0iU6lN3zWsfDGUCfoPlA2
         GutwewUcwIftt1gm36LI0tccOfE6hexao1y7s=
Received: by 10.204.118.4 with SMTP id t4mr7864784bkq.38.1296645298943;
        Wed, 02 Feb 2011 03:14:58 -0800 (PST)
Received: from localhost.localdomain (abvv233.neoplus.adsl.tpnet.pl [83.8.219.233])
        by mx.google.com with ESMTPS id b6sm11573462bkb.10.2011.02.02.03.14.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 03:14:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p12BE1CJ006326;
	Wed, 2 Feb 2011 12:14:12 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p12BDRQt006320;
	Wed, 2 Feb 2011 12:13:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=07yifUAQYqabA8Dv1qmBTe=50+BDN-b0YZ1zb@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165903>

=46elipe Contreras <felipe.contreras@gmail.com> writes:
> On Wed, Feb 2, 2011 at 11:55 AM, Vincent Hanquez <tab@snarc.org> wrot=
e:
>> =A0On 01/02/11 22:48, J.H. wrote:
>>>
>>> The wiki will almost universally have a "central site" no matter wh=
at
>>> the backend. =A0Personally I see little advantage to having a git b=
acked
>>> wiki myself.
>>
>> with git based wiki, you can clone the whole wiki on your local mach=
ine, and
>> read/edit/commit on it locally using standard editor tool (i.e. $EDI=
TOR).
>> and the history/revision/diff is completely built-in.
>=20
> But there's no git based wiki (or any other wiki) that has even a
> fraction of the features that MediaWiki has, or IMO a markup format
> similarly sane.

Gollum (the engine used by git-based wikis on GitHub) offers support
for MediaWiki format.  I don't know how it is with editing and
presenting history (end e.g. reverting spam), especially on older or
text browsers.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
