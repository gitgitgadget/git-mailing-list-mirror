From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] prune: allow --dry-run for -n and --verbose for -v
Date: Sat, 07 Aug 2010 10:25:59 +0200
Message-ID: <4C5D1897.2070109@lsrfire.ath.cx>
References: <4C5C7055.3090100@lsrfire.ath.cx> <20100806210429.GA6495@burratino> <4C5C8193.1040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Aug 07 14:12:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiGj-0004JG-6U
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab0HGI0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 04:26:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:53445 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0HGI0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 04:26:13 -0400
Received: from [10.0.1.100] (p57B7F713.dip.t-dialin.net [87.183.247.19])
	by india601.server4you.de (Postfix) with ESMTPSA id BB2AA2F818B;
	Sat,  7 Aug 2010 10:26:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C5C8193.1040608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152846>

Am 06.08.2010 23:41, schrieb Ren=E9 Scharfe:
> Adding a helptext parameter to OPT__DRY_RUN =E0 la OPT__COLOR would m=
ake
> it usable here as well as in commit.c and fetch.c.

Actually it doesn't, because the short option -n is used for other
purposes there.  But I still think it's worth doing because the
description can then be made more meaningful instead while now it's jus=
t
repeating the long option.

Ren=E9
