From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Tue, 29 May 2012 18:30:54 +0700
Message-ID: <CACsJy8ANyMxLNCP1P28AKywssGdSQP3QnE_HZHHGzkX-4oqFtw@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <20120528224729.GK14606@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 13:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZKeF-00077q-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 13:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab2E2Lb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 07:31:27 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54534 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2E2Lb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 07:31:26 -0400
Received: by wgbdr13 with SMTP id dr13so3781546wgb.1
        for <git@vger.kernel.org>; Tue, 29 May 2012 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DSccOACjuzatVrdlfcrm9qrsapbPnK6bl61RCkovoP8=;
        b=Qwf5s0l/Sj6nQC+2G7gR8FZukBSoSQv0Han9BHUgvBlpQ2Kfpqa2e58zY590HQIcBd
         tJ/+wvqMvHWlfb2eJwFG28S6/xR2kfhWDm3xZjGZMfPZDKXQdT2veG+r2DR/tZCC2/Ub
         /4GklwEk/HX9lasqN5xOvkmTmnW7eXCbMz7bZl+oU+BHIPeR+tS6DK7lxlVVCwsrs++T
         rRJh5mu7ehFfHzaj2H7PD52Q4cWzTqjRHkrDt65e49+R6OqQWJwoxYKitHFY5/b0tqOt
         F1a01adU5HtdArN93ZoMcTTbn7GXC1Bbj5o1ZPDnSKMSzxNHw0QRLzcebAdecvGfWhLr
         nu/Q==
Received: by 10.216.216.95 with SMTP id f73mr7185048wep.149.1338291085254;
 Tue, 29 May 2012 04:31:25 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 29 May 2012 04:30:54 -0700 (PDT)
In-Reply-To: <20120528224729.GK14606@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198735>

On Tue, May 29, 2012 at 5:47 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> GETTEXT_POISON is annoyed by
> ...

I have not followed gettext poison development, so this question may
be silly. Is there any value in running the test suite with
GETTEXT_POISON on?

I can see the value in running the poisoned command manually under
many scenarios, so we are certain we do not miss any i18n strings. But
current test suite may not be suitable for automating that task (i.e.
spot new i18n strings). The test suite is currently more focused on
features than human readable output. And some strings like die("...")
may never happen unless you tweak the source code to emulate a broken
disk or so.
-- 
Duy
