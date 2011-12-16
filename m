From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered by path
Date: Fri, 16 Dec 2011 14:27:23 -0800 (PST)
Message-ID: <m3y5ucf8zd.fsf@localhost.localdomain>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
	<CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
	<alpine.DEB.1.00.1112151023280.2615@bonsai2>
	<CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
	<7v1us5obqa.fsf@alter.siamese.dyndns.org>
	<8739clzdzw.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbgFW-0006dq-PC
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760880Ab1LPW11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 17:27:27 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52348 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1LPW1Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:27:25 -0500
Received: by eekc4 with SMTP id c4so3647295eek.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=LGMWl+sS8TNdwrhWkYHmMFoNbua25G3raLWeBpH+UKo=;
        b=b5QdfOcdx3igytj+B3QiYbE6U6pY78SIKaaRvFIT5bEQt4B4FmK0coVZPwaUJFt22U
         2kvWMPIRwox6DhugIGaCGSMUNAYNtgb/sgMsmhzrS8ZV07EOCdv1RRloa7L0V1eszPcr
         Iv9mSgOIZIe+fuX/sn+Tio1cu5sLQ3D/wbezo=
Received: by 10.213.114.84 with SMTP id d20mr131800ebq.100.1324074444416;
        Fri, 16 Dec 2011 14:27:24 -0800 (PST)
Received: from localhost.localdomain (abwb78.neoplus.adsl.tpnet.pl. [83.8.225.78])
        by mx.google.com with ESMTPS id 39sm2930020eei.1.2011.12.16.14.27.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 14:27:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBGMRK33013476;
	Fri, 16 Dec 2011 23:27:21 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBGMRJT5013473;
	Fri, 16 Dec 2011 23:27:19 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8739clzdzw.fsf@fox.patthoyts.tk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187327>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:
> Junio C Hamano <gitster@pobox.com> writes:

>> I have this slight suspicion that Paul would appreciate if somebody =
who
>> cares about gitk who is capable and willing steps forward and takes =
over
>> the maintainership of gitk, as he is busy in his other projects.
>=20
> I can do this one along with git-gui if this is the case.

I wonder if having common maintainer for both gitk and git-gui would
lead to first, splitting gitk into smaller files like git-gui was, and
second sharing common Tcl/Tk bindings / wrappers between gitk and
git-gui...

--=20
Jakub Nar=EAbski
