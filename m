From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 04 Oct 2010 23:11:45 +0200
Message-ID: <4CAA4311.1070408@lsrfire.ath.cx>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com> <4CA9B217.6050600@lsrfire.ath.cx> <7v4od192zo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Dan McMahill <dmcmahill@NetBSD.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sKF-00073W-Ku
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719Ab0JDVLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 17:11:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:44993 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022Ab0JDVLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:11:52 -0400
Received: from [10.0.1.100] (p57B7AAF9.dip.t-dialin.net [87.183.170.249])
	by india601.server4you.de (Postfix) with ESMTPSA id 67F552F8064;
	Mon,  4 Oct 2010 23:11:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <7v4od192zo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158122>

Am 04.10.2010 21:23, schrieb Junio C Hamano:
> Looks much saner; thanks.  I think we can steal the log message from =
=C3=86var
> v2 to explain what this change is about.

Good idea. :)

I forgot this:

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
