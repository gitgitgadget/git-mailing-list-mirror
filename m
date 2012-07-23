From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 23:31:11 +0200
Message-ID: <CAHGBnuMEHdNrOoXycAn5JxF4cCvDSA1aTgLG3mZw2PoT9GMN-A@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFB19.6010905@gmail.com>
	<7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
	<500DA7F3.3000403@gmail.com>
	<7v4noykxvm.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
	<7vipdejhmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQDm-0001WS-PS
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab2GWVbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:31:14 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53991 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab2GWVbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:31:13 -0400
Received: by vbbff1 with SMTP id ff1so5172874vbb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xbr0F2af68LSWhJwW50CirRCfOsf3949l7DL9+TnPZU=;
        b=OkzbjiK5EnfPn0drQbhDldl5f0rpA+6QMIeN2UVYkcMLLbcGhoQS/PiHZHd8/oTdL2
         w0Szv5joOczrvFNhmTSF5DcnQ8UAHucXbSV/KetgznTAJUgNHsPani3B5aV6Csk5jVED
         gGpnSfO8uwUbYr9DGJIrZG0u6nyANIS7M10A6FrQElqccZoenuEZZc5J3GhRapuB/OCG
         cmsypCdUUTRlzAiqmrOv0yYVos0T+k7L2qO0zwtconLuL9BRwrOPURATX6XnYB9Dk9xZ
         TfkGBlx3mhSF/lfharmSuyHvjN1LhP3XwXWhLbIDrzvyO5eEJRlP1ixoWeK1rzRoW8Xk
         2Vyw==
Received: by 10.52.174.81 with SMTP id bq17mr12293051vdc.119.1343079071854;
 Mon, 23 Jul 2012 14:31:11 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Mon, 23 Jul 2012 14:31:11 -0700 (PDT)
In-Reply-To: <7vipdejhmh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201989>

On Mon, Jul 23, 2012 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Does Araxis compare take "--version" and behave in a way that is
> cheaply controllable?  If it opens a GUI window and pops up a dialog
> that says "Option not understood", then it is not "controllable",

Araxis opens up a GUI dialog with usage info in that case, so it's not
controllable, unfortunately.

-- 
Sebastian Schuberth
