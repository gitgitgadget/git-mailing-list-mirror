From: Sedat Kapanoglu <sedat@eksiteknoloji.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sun, 11 Aug 2013 10:28:03 +0300
Message-ID: <CABJxLaMtHLGzwaxJgM3H9uFzb9_LMLzQ4_A6q0dcEOyShhb+kw@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
	<20130810125140.GD25779@paksenarrion.iveqy.com>
	<CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
	<20130810163459.GE25779@paksenarrion.iveqy.com>
	<CABPQNSaU_69RxNEAAY0=BYdJm0ir_xkOkd2nPaxop7m0aJ9trg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 11 09:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Q4o-00071o-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 09:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab3HKH2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 03:28:09 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:50323 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab3HKH2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 03:28:07 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so7740538obc.24
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 00:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:dkim-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=DfL9YonFl/mn+fkvnp6mVkXk6BDaPsJhFk2vWiUMIPM=;
        b=Hqee/Z4ewO8TxSl7nRNSI6SZ6wnqinp8GxoTZuTQKcRdDI4E9kmSkIEtckEkEx2CBS
         fdTFBK6qJiqTPLw8ffONtwOr20VuN9UpRUEIt2Br7ehtUjad/eDm2Og7r6DveGWf0tSS
         bOnzDvblkIPOK0WhXHuh+rYIUonRemjoHrCGDF1U3wYh8CnkPCJFBwIbX2YjPuboFxjP
         koWJVG0E18pq00KX1cPhucmURVXbsRyOU2ve4zwyERzPnUKYAhzSIv2S9snHC2EhpiRq
         5a3pr6/xPkjJ1bAtlt17fIuoHMGRgp2gX69jtvUJvWzfxFyBCvtgqvO4TOtmIEZOnzlA
         wZxg==
X-Gm-Message-State: ALoCoQmUsQK2r3x9yaPw1r0ncD3BKpWYAjXYPdDOA3cRE4sAdNrzSy1fs5rI1bu/en+n9L3bIG1H
X-Received: by 10.60.132.113 with SMTP id ot17mr6452052oeb.104.1376206085575;
        Sun, 11 Aug 2013 00:28:05 -0700 (PDT)
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com [2607:f8b0:4003:c01::232])
        by mx.google.com with ESMTPSA id q8sm27632304obl.11.2013.08.11.00.28.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 00:28:04 -0700 (PDT)
Received: by mail-ob0-f178.google.com with SMTP id ef5so4795598obb.9
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eksiteknoloji.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DfL9YonFl/mn+fkvnp6mVkXk6BDaPsJhFk2vWiUMIPM=;
        b=Usvdp/mSo0q9j9k08Z40PnSzvOP1ToRUddk9KwjiHk5WRthciPxYayEzHSdhEjJAVc
         MTceHSHa/iQyQ/hDpcSkt0FqEdvWR1b1hL8cLbSZQx4aXw4H9op9te6TiLrPqRtb+Z+k
         bg+p52calYaUBuc9sjYGamcnMOk1ee1mXoY4Q=
X-Received: by 10.60.134.196 with SMTP id pm4mr14513797oeb.60.1376206083268;
 Sun, 11 Aug 2013 00:28:03 -0700 (PDT)
Received: by 10.182.81.3 with HTTP; Sun, 11 Aug 2013 00:28:03 -0700 (PDT)
In-Reply-To: <CABPQNSaU_69RxNEAAY0=BYdJm0ir_xkOkd2nPaxop7m0aJ9trg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232126>

Thanks folks. So that this won't be fixed, I added a new Q&A to
MsysGit FAQ at https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions
, I appreciate if you can review and correct if needed. I hope it will
help avoiding further conversations about this matter.

Sedat
