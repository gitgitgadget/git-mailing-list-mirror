From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH nd/wildmatch] Correct Git's version of isprint and isspace
Date: Tue, 13 Nov 2012 20:14:39 +0100
Message-ID: <50A29C1F.6000006@lsrfire.ath.cx>
References: <507E9FDE.7080706@cs.tu-berlin.de> <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	schnhrr@cs.tu-berlin.de
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:15:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYLwx-0002fK-GM
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 20:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2KMTOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 14:14:52 -0500
Received: from india601.server4you.de ([85.25.151.105]:43752 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab2KMTOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 14:14:51 -0500
Received: from [192.168.2.105] (p579BE299.dip.t-dialin.net [87.155.226.153])
	by india601.server4you.de (Postfix) with ESMTPSA id E3205897;
	Tue, 13 Nov 2012 20:14:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <1352803572-14547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209658>

Am 13.11.2012 11:46, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> Git's isprint includes
> control space characters (10-13). According to glibc-2.14.1 on C
> locale on Linux, this is wrong. This patch fixes it.

isprint() is not in master, yet.  Can we perhaps still introduce it in=20
such a way that we never have an incorrect version in master's history?

And could you please update test-ctype.c to match the change to=20
isspace()?  The tests there just documented the status quo before I mad=
e=20
changes to ctype.c long ago, so it's definitions are just as correct (o=
r=20
wrong) as the original implementation.

Thanks,
Ren=C3=A9
