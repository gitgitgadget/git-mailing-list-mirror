From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/6] tag.c: Replace varialbe name for readability
Date: Mon, 4 Apr 2016 21:30:47 -0400
Message-ID: <CAPig+cSs_gYgQ6dO0SpSwEgUd0Pm3uwFcSYeXqYMqxRC+NMVQg@mail.gmail.com>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
	<1459808535-8895-5-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:30:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFpV-0005WF-Hc
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbcDEBat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:30:49 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35346 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbcDEBas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:30:48 -0400
Received: by mail-ig0-f196.google.com with SMTP id ya17so226242igc.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 18:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=UZ8CVuE2LHHtD5S5D/wmIWkaceUhjWtoqeqXA5pu1SE=;
        b=fLrms3CuXY7VM2j28l3jYHPMcclnGVZNdFyzjKYWzB0XSOA+Y0RDCVRi5yLdM8mN+f
         /fzlfb0k8CvsJYuzKhnBCw70ZcBjfApNuILGNNo3SQLA+1P13SqEiLlduR5toIJga3Qy
         mYHASrdkTcZRqtB4RG9/wmbmZ9NkLDra4V/QnlyxOw5m4lqV2pwmVamiMC+COgp3Doci
         YR4Y8UNnm4A+QfCczuiv87bSpKFseSZQ++Z+0/ENrRL33EIvgSZxo9VstKqUlxssB8E5
         SgTTfGnTHdt11D/IdHAx+p8f/LKSmpSkiIziEOWeQol4ZiY54KKL4P2K8bQiGG1z+Mws
         +ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UZ8CVuE2LHHtD5S5D/wmIWkaceUhjWtoqeqXA5pu1SE=;
        b=MEiqL/28pOZHUEfejkkG/XDoNMyqdSwbCHmMU4eNEkuZdMRgxeBhlC+xhgI4DlBZwT
         XlEX1Lawlw9Vyx08xJZCDT8duRgvFEmp8wg1gwpUTjXFRvsV8h5o8TOPu72g/BL615/Z
         K/BkyZyQcESAbTASYFXNxPHZXSx1tDvSn2D/BSquxieSQHiSWpm5iOP0ay/EoBiakpu8
         M6i1HjQY6WA3wH/V/35EglGEA0kgSrRijLDxXZPBGAt32XX6gpKQCYtsqCB291C6XAOx
         CzFOPAvFGjc+tYuXWM55QFfpoNLkpXjhUO7YviNRtkobjbBBtK3ZHgu3t5gBkEtPmYJn
         MeYg==
X-Gm-Message-State: AD7BkJJQUjkH7yBPz8jKAgwcQsZ5RL9DZmHdS47bog0IpUoPJVWvgzBzVm/iDAvSRB9x61Oi5UQ4JBEQ6Yczig==
X-Received: by 10.50.97.70 with SMTP id dy6mr12598356igb.73.1459819847970;
 Mon, 04 Apr 2016 18:30:47 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 18:30:47 -0700 (PDT)
In-Reply-To: <1459808535-8895-5-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: 2XIWB-NFSnTfC9QVawFd_KXua3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290747>

On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
> tag.c: Replace varialbe name for readability

s/Replace/replace/
s/varialbe/variable/

> The run_gpg_verify function has two variables size, and len. This may
> come off as confusing when reading the code. We clarify which one
> pertains to the length of the tag headers by renaming len to
> payload_length.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
