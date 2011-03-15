From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Tue, 15 Mar 2011 13:40:31 +0100
Message-ID: <1300192832.19100.35.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-2-git-send-email-cmn@elego.de>
	 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
	 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
	 <7vpqptb976.fsf@alter.siamese.dyndns.org>
	 <1300190396.19100.31.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzTYK-0005Ek-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 13:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595Ab1COMkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 08:40:39 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:57727 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab1COMki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 08:40:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id B37981B4BC9;
	Tue, 15 Mar 2011 13:40:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vbKjINs1M4Ge; Tue, 15 Mar 2011 13:40:32 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 1360A1B4BC8;
	Tue, 15 Mar 2011 13:40:31 +0100 (CET)
In-Reply-To: <1300190396.19100.31.camel@bee.lab.cmartin.tk>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169067>

On mar, 2011-03-15 at 12:59 +0100, Carlos Mart=C3=ADn Nieto wrote:
> On lun, 2011-03-14 at 15:58 -0700, Junio C Hamano wrote:
> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
[...]
> >=20
> > >  There is however the extra functionality the function offers, na=
mely
> > > resolving links. It might be good to split it into two functions =
so each
> > > caller can specify what it wants.
> >=20
> > Probably.
>=20
>  With the changes mentioned earlier, if you want an absolute pathname=
,
> you'd call absolute_path/make_nonrelative_path and if you want to mak=
e
> sure you have the real path of the target file, you'd use real_path j=
ust
> as you'd use realpath on a sane system, with

 ... a comment on the functions and maybe some documentation in
Documentation/techncal, as it doesn't seem to exist yet.

   cmn
