From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] zlib: fix compilation failures with Sun C Compilaer
Date: Mon, 22 Apr 2013 18:54:31 +0200
Message-ID: <51756B47.80609@lsrfire.ath.cx>
References: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 18:54:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUK0x-0005u3-NG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 18:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab3DVQyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Apr 2013 12:54:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:48634 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3DVQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 12:54:45 -0400
Received: from [192.168.2.105] (p4FFDA9F3.dip0.t-ipconnect.de [79.253.169.243])
	by india601.server4you.de (Postfix) with ESMTPSA id 895BCC1;
	Mon, 22 Apr 2013 18:54:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222039>

Am 22.04.2013 18:18, schrieb Stefano Lattarini:
> Do this by removing a couple of useless return statements.  Without t=
his
> change, compilation with Sun C Compiler 5.9 (SunOS_i386 Patch 124868-=
15
> 2010/08/11) fails with the following message:
>
>    "zlib.c", line 192: void function cannot return value
>    "zlib.c", line 201: void function cannot return value
>    cc: acomp failed for zlib.c

Hmm, what was I thinking when I introduced these returns in c3c2e1a0?=20
:-/ Thanks for catching!

Ren=E9
