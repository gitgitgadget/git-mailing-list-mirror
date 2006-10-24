From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/1 (amend)] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 11:28:34 +0200
Message-ID: <200610241128.34532.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com> <200610241104.18517.jnareb@gmail.com> <7vfydehy2q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 11:28:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIa4-0002gQ-56
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWJXJ2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 05:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWJXJ2N
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:28:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41330 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030243AbWJXJ2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 05:28:10 -0400
Received: by ug-out-1314.google.com with SMTP id 32so153509ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 02:28:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sDmDcNczFt8Q+WoskWk14kN7wh7000WgQ03JOLccJqP4MkJsPVrTkAUWeLOLegy9lfmrp1N5/oH11M8jIt63NmLH58JVq9wjP+hntkXW2PdlWjbi5cYdUat/sxxfChf7P4DgXWKD6nGt8G1mAOfXj4NS7bATJuPWq4TrTSYjeZ4=
Received: by 10.67.119.13 with SMTP id w13mr8513258ugm;
        Tue, 24 Oct 2006 02:28:08 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id c1sm323512ugf.2006.10.24.02.28.08;
        Tue, 24 Oct 2006 02:28:08 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vfydehy2q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29953>

Dnia wtorek 24. pa=BCdziernika 2006 11:17, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> Use fixed string instead of shortened SHA1 identifier of commit
>> as a name for "mext" link in commitdiff view.
>>
>> While at it make sure that we don't mistake option for a second
>> commit.
>>
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> ---
>=20
> Q1. (amend) to fix what?

Petr "Pasky" Baudis wrote:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0# =
merge commit
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$f=
ormats_nav .=3D
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0' (merge: ' .
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0' (' .
[...]
> For people not used to git, it would be more informative to keep the
> 'merge' text there.

It also fixes detection if it is diff of two specified commits. Althoug=
h
$hash_parent is set to '--root' for rootloess commit later, we could
have it set by hand. This is also preparation for later using '--cc'
(although we wouldn't generate such URL, I don't think).

> Q2. "mext"?
Oops.

--=20
Jakub Narebski
Poland
