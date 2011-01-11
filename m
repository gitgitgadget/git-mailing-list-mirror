From: Andreas Ericsson <ae@op5.se>
Subject: Re: Merge two different repositories (v2.4 + v2.5) into the one (v2.4
 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 13:41:51 +0100
Message-ID: <4D2C500F.6070203@op5.se>
References: <746745466.20110111134101@mail.ru> <20110111114943.40890@gmx.net> <76067992.20110111153329@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWFydGluIEtyw7xnZXI=?= <martin.krueger@gmx.com>,
	git@vger.kernel.org
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:42:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcdY1-00026h-CT
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800Ab1AKMl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 07:41:57 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48216 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab1AKMl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:41:56 -0500
Received: by ewy5 with SMTP id 5so9247637ewy.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 04:41:54 -0800 (PST)
Received: by 10.213.4.78 with SMTP id 14mr2779568ebq.94.1294749714302;
        Tue, 11 Jan 2011 04:41:54 -0800 (PST)
Received: from [192.168.1.186] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id b52sm5651304eei.7.2011.01.11.04.41.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 04:41:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <76067992.20110111153329@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164936>

On 01/11/2011 01:33 PM, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=A8=
=D1=83=D0=BC=D0=BA=D0=B8=D0=BD wrote:
> Thank you for the answer, but it's not what I want ))
> Applying patches is the same as rebasing, I guess.
> But I do not want to change v2.5-repo (let's call it so) that much.
> I'd like to know is there any method (low-level I suppose, as far as =
Git
> manages tree-objects as files) to make v2.4 LAST commit to be the
> parent of v2.5 FIRST commit?
>=20

You want grafts. Check them up in the docs. Googling for "git graft"
should get you a good starting point.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
