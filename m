From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 20:30:47 +0100
Message-ID: <m2ip6x0vtk.fsf@igel.home>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
	<7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
	<CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
	<50F40316.7010308@drmicha.warpmail.net>
	<7v1udnbmyz.fsf@alter.siamese.dyndns.org>
	<1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
	<7vpq1755jb.fsf@alter.siamese.dyndns.org>
	<7vip6z54rh.fsf@alter.siamese.dyndns.org>
	<50F524F8.5090803@drmicha.warpmail.net>
	<7v4nii5tp2.fsf@alter.siamese.dyndns.org>
	<50F668FB.5000805@drmicha.warpmail.net>
	<7v622xyvnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvYhi-00038A-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 20:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236Ab3APTa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 14:30:57 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:52484 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab3APTa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 14:30:56 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Ymdn43w8bz3hhff;
	Wed, 16 Jan 2013 20:30:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3Ymdn42nFdzbbfx;
	Wed, 16 Jan 2013 20:30:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id vdhhpwxrn6CC; Wed, 16 Jan 2013 20:30:30 +0100 (CET)
X-Auth-Info: pxc17XEUDZmoAkn9nNL8cibpPk3AbAoqrTC7gJEX36A=
Received: from igel.home (ppp-88-217-105-253.dynamic.mnet-online.de [88.217.105.253])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 16 Jan 2013 20:30:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 71EDCCA2A1; Wed, 16 Jan 2013 20:30:47 +0100 (CET)
X-Yow: Let me do my TRIBUTE to FISHNET STOCKINGS...
In-Reply-To: <7v622xyvnd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 16 Jan 2013 07:50:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213804>

Junio C Hamano <gitster@pobox.com> writes:

> I actually think my earlier "it shouldn't be the same (push)" is not
> needed and probably is actively wrong.  Just like you can tell
> between
>
>     (only one .url)                     (both .url and .pushurl)
>
>     origin there (fetch/push)           origin there (fetch)
>                                         origin there (push)

What should happen when you have a .pushinsteadof configured that
modifies .url for pushing?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
