From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [TopGit PATCH 2/6] tg-remote: use default remote if non is given
Date: Mon, 4 Oct 2010 03:13:24 +0000
Message-ID: <AANLkTin_erzxiOgthOq5_9dtFXeRT+K5K4uGTGa1OOZP@mail.gmail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
	<1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Peter Simons <simons@cryp.to>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	martin f krafft <madduck@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2bUY-00026Z-7E
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab0JDDN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 23:13:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64046 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab0JDDNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 23:13:25 -0400
Received: by iwn5 with SMTP id 5so6357219iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=XlXW+CrPkFEnSJfoOwUMeNZ1L3Y02/sKGYLv+rrdN1w=;
        b=OL30DP8XhfUdDWdcJb6+K/8WJQEJbPj8QfzAfDBcmkJIcGR5Bxi2VQdiwgx2j972ZL
         7fSmczFWbdJpxhIg2tZysKXE91XHhm//qsoxvzEcAdCzb+DezNY//mkpSOaOXMQpjnGt
         kb2sVizjzWyG7uFfBuNBz8x3a/70qVNOO7G5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b8Kj+QiAkwXyu+DjlP9qKUVc2qP9DRUuvSkovjDquo7GQQrMI7x0zx9m80ApUMCO9Z
         LgAj7I5I8qEBg9dX/STcCYCds7b6MafobbORoLT47pQkeNny3aolxiGsNFs04iokJjBG
         cBfKigJIeEr7jyJsvBbqSJhGbMmMatihbGbv4=
Received: by 10.231.36.202 with SMTP id u10mr9474076ibd.64.1286162004752; Sun,
 03 Oct 2010 20:13:24 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:13:24 -0700 (PDT)
In-Reply-To: <1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157964>

On Sun, Oct 3, 2010 at 21:25, Bert Wesarg <bert.wesarg@googlemail.com> wrote:

Minor: I think you mean "none" in the subject, not "non".
