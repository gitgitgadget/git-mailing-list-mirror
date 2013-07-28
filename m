From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 14:19:10 +0530
Message-ID: <CALkWK0nFDyFqBPatsbQ-0mGXQ-6N5Xs9gKioknuGX9a7UiD4Fg@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
 <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com> <CACsJy8AuAy7PnEU20k23gVRQoFrLhJrM6hfESZKshUA578c3Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 10:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3Mfr-0007sL-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 10:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab3G1Itv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 04:49:51 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33499 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3G1Itu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 04:49:50 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so10476694oag.26
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3/LfYo4ntl/uLffa1rzGSsnVc5OR32h+A6OBwWnlWA8=;
        b=lxyyeGDkA8JJn2RH/3icKQtEfgl3ZmJMttrfdnGjNo4r65//OZEz0PPQzxZnnEKqhd
         LjuyXR7z2xNXNmsFwBdfq6zhvQgh680rBKhfWiWS3V4BipqhIm7aGi5dpYYLLvJGpgRl
         jg/TyvML6xM4WuwUe8nKeHYWyf/FOk9P/9nl1WD3LTyLj5515ZIb4YwwhIhjAj0Tl5lr
         Uu1U8il0WDIwIrHyu93S8H2P/AEesC5dLtoTPtWioA3BC6zkLCBjeAc84Fhr/7lJPL6b
         5LkIWF6aVFfiEyNwTSew3Dq3z8ulRi2OZR/Am1AxnsWXjsTqWtqINTpq+AI9z78Z+m3R
         +WjQ==
X-Received: by 10.50.134.9 with SMTP id pg9mr556602igb.29.1375001390110; Sun,
 28 Jul 2013 01:49:50 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 28 Jul 2013 01:49:10 -0700 (PDT)
In-Reply-To: <CACsJy8AuAy7PnEU20k23gVRQoFrLhJrM6hfESZKshUA578c3Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231261>

Duy Nguyen wrote:
> I think instead of letting the kernel walk the path, emacs does it by
> itself.

If this were true, shouldn't we be able to reproduce the behavior with
my no-submodules symlink testcase?  How can it resolve symlinks in one
case, and not in the other case?
