From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Mon, 08 Mar 2010 15:08:09 +0100
Message-ID: <4B9504C9.5000703@lsrfire.ath.cx>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 15:08:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoddH-00034a-T4
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 15:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab0CHOI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 09:08:27 -0500
Received: from india601.server4you.de ([85.25.151.105]:38046 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab0CHOIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 09:08:25 -0500
Received: from [10.0.1.100] (p57B7F26A.dip.t-dialin.net [87.183.242.106])
	by india601.server4you.de (Postfix) with ESMTPSA id 38DCB2F804F;
	Mon,  8 Mar 2010 15:08:18 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141767>

Am 07.03.2010 13:09, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> This adds support to show columnized output in the mentioned commands=
=2E

That's a good idea.

I'm not so sure about the interface, though.  Does the task really
warrant adding a new git command?

If a --column parameter is added, I think it should expose the full
range of options, i.e. fill columns first (ls -C style), fill rows firs=
t
(ls -x style) as well as off (ls -1 style) and auto.

Shouldn't the columnizer use utf8_width() instead of strlen(), like
strbuf_add_wrapped_text() in utf8.c?

Ren=C3=A9
