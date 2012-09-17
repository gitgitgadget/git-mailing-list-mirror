From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/5] Integrate wildmatch to git
Date: Mon, 17 Sep 2012 12:57:13 +0700
Message-ID: <CACsJy8Bwf_Xm_dbo1YtV9nynBy=V0_tPnPHR8bskjuHe9hpLsQ@mail.gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com> <1347809265-2457-5-git-send-email-pclouds@gmail.com>
 <7vpq5lw6z8.fsf@alter.siamese.dyndns.org> <7vd31lw5vy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDULB-0008HS-2H
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab2IQF5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:57:45 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40446 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab2IQF5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:57:44 -0400
Received: by ieak13 with SMTP id k13so27910iea.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4YPLcwWP9t1V0pvEN+A34LTU5TCWzFfIUpu96R7q4c8=;
        b=ohzTUE3sA18Hs+Is3+zdcPdr2zxt+JpAlYBR+0xKHvfGci7pIQ+8FuiyvFEVyScNZJ
         zvggEN5ZMZ12dVVtnY7YdaCZ/Bt7s1I5Z+FQQCVPDCMJgDVQl66d1PaXuto0/gsVfpEA
         INOfNSADHyuzXN5HpfhnMi1nkk3dsuU2I0WN2uxMgUTEoN73hiVmXkqXKBCaLyPRnwlt
         3z13NBFNSwKp+spipGjnX37E/YqImbC+L/QHzFR4ccDmJOtgEyJlHAIAF9V6nr3pS544
         bm6WlkIIRUzWFBnU0B36RXeuisnnxhHUWNg1YBvxqUDV+Gk43vhOAUsb//D6/W+TVTbq
         wY7g==
Received: by 10.50.40.132 with SMTP id x4mr5612397igk.48.1347861464132; Sun,
 16 Sep 2012 22:57:44 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Sun, 16 Sep 2012 22:57:13 -0700 (PDT)
In-Reply-To: <7vd31lw5vy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205653>

On Mon, Sep 17, 2012 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, popt.h it is.  It is a bit distasteful that we have a build
> dependency only to build test-* helper on something that we do not
> even have runtime dependency on.

Yep. I don't know how popular libpopt is. But if it's undesired, we
could rewrite test-wildmatch.c to use parse-options.c instead. We fork
from rsync anyway due to license conflict so we don't have to keep it
close to upstream any more.
-- 
Duy
