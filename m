From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Auto detection in Makefile if msgfmt is not available
Date: Sun, 12 Feb 2012 16:22:06 +0100
Message-ID: <CACBZZX4W0onNOstQqNethDBv1tZSijt8Q_HDrcuWr+Z8WYV90w@mail.gmail.com>
References: <201202121342.25113.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 12 16:22:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwbG7-00069v-Lb
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 16:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab2BLPWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 10:22:31 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65275 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754503Ab2BLPW3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 10:22:29 -0500
Received: by lagu2 with SMTP id u2so3378275lag.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RJbm3/1RfcnHHNUCO2rf8RXEioJIndEVkAFZQ/7ukAs=;
        b=dk0S2W88IWRP+TW7agj9CG8CZiwBPmYLDRap8k2QZ3Ibz/aIw52+VuQfXuy1kpugvo
         CUT5jZ2S2sq2X3rvmP7DrMGa3CnxTktyGFuKwhKOFMu9MUrZceg0WBChaOXZmKkw4VZE
         4a/idZABQQR8KJLokzBnIuAE9sUIJvB6uS6bA=
Received: by 10.112.84.1 with SMTP id u1mr4572004lby.35.1329060147269; Sun, 12
 Feb 2012 07:22:27 -0800 (PST)
Received: by 10.112.1.230 with HTTP; Sun, 12 Feb 2012 07:22:06 -0800 (PST)
In-Reply-To: <201202121342.25113.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190574>

2012/2/12 Torsten B=C3=B6gershausen <tboegi@web.de>:
> Added a simple auto-detection and switch to NO_GETTEXT when
> msgfmt could not be found on the system

Oh look, a start at our very own autoconf replacement :)
