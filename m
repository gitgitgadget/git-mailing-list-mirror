From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 2/3] Name make_*_path functions more accurately
Date: Wed, 16 Mar 2011 17:42:25 +0100
Message-ID: <1300293751.7214.52.camel@bee.lab.cmartin.tk>
References: <1300291579-25852-1-git-send-email-cmn@elego.de>
	 <1300291579-25852-3-git-send-email-cmn@elego.de>
	 <D7B7C57A-B4DB-4CDC-B079-77537D8E8EFD@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:42:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzto2-0008G2-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528Ab1CPQmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:42:37 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:46221 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab1CPQmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:42:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 98C5A1B4AFF;
	Wed, 16 Mar 2011 17:42:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mYVYF0ti-2zi; Wed, 16 Mar 2011 17:42:30 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 060311B4AFE;
	Wed, 16 Mar 2011 17:42:29 +0100 (CET)
In-Reply-To: <D7B7C57A-B4DB-4CDC-B079-77537D8E8EFD@silverinsanity.com>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169173>

On mi=C3=A9, 2011-03-16 at 12:29 -0400, Brian Gernhardt wrote:
> On Mar 16, 2011, at 12:06 PM, Carlos Mart=C3=ADn Nieto wrote:
>=20
> > Rename the make_*_path functions so it's clearer what they do, in
> > particlar make clear what the differnce between make_absolute_path =
and
> > make_nonrelative_path is by renaming them real_path and absolute_pa=
th
> > respectively. make_relative_path has an understandable name and is
> > renamed to relative_path to maintain the name convention.
> >=20
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>=20
> I didn't try it, but it looks like 2/3 horribly breaks the code and
> 3/3 fixes it.  I personally (and I think others) prefer patches that
> are each useful on their own.  Especially since a code-breaking patch
> like this makes bisecting harder.

 True enough.

>=20
> I would suggest doing one of the following:
>=20
> 1) Squashing 2/3 and 3/3 so all the renaming occurs at once.
> 2) Adding wrappers from the old name to the new in 2/3 and removing
> them in 3/3.

 I'll squash.

>=20
> That said, I'm not sure the renaming is useful although the
> documentation comments definitely are.

 Do you think the difference between make_nonrelative_path and
make_absolute_path is clear without looking at the code? For me at
least, a relative path is the opposite of an absolute one, and a
non-relative path is the opposite of a relative one. To make a
difference between absolute and non-relative is then bound to lead to
errors.

   cmn
