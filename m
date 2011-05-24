From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix usage of git-init and git-init-db documentation
Date: Tue, 24 May 2011 23:04:31 +0700
Message-ID: <BANLkTingh__Yxy_rEM2mV6wB453OdarrwA@mail.gmail.com>
References: <1306248113-19948-1-git-send-email-pegon.marc@gmail.com> <7voc2s850z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Pegon <pegon.marc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:05:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOu6Y-0002W6-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990Ab1EXQFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:05:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41374 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab1EXQFC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:05:02 -0400
Received: by bwz15 with SMTP id 15so5753687bwz.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2OzyKfrk9au5DfrGuN18UXx0erE5peKur7YyD6mWWIY=;
        b=tNh2gy/Hw4JyaQ/D8NjT2dao+CzVpJLW46YBNuo8JSJYOW4YS4Xjd1JuB2T7c9RgMm
         oWh6fQm0f/jmyNNl/4Po8ZuFXFbTfwAN4YWinpyintQpwbGbSoJ0t6ZI9HS0Zowqj9X3
         dMDbqyeiyI+dsQKKt7qB9cVLlLFoSSykSNgdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dGd15B5PowGwYiNifRZNNhFtLP2e+E+krA+LwYs3RLXqD6CSh4cDr7crZUr5rtpIX4
         baJuexwDtX7FPJptdOW/6xLFxwxVStG1TVBxuh5uMFpe2FNApNUKV2UL2CjjSO4ROheO
         L6Tj75LVuCsuW55NZgeWh9ClxKi7LRdPcOIXA=
Received: by 10.204.16.216 with SMTP id p24mr3218061bka.5.1306253101214; Tue,
 24 May 2011 09:05:01 -0700 (PDT)
Received: by 10.204.46.71 with HTTP; Tue, 24 May 2011 09:04:31 -0700 (PDT)
In-Reply-To: <7voc2s850z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174324>

On Tue, May 24, 2011 at 10:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> By the way, the change seems to have slipped in while I wasn't paying too
> much attention, but who came up with this silly capital 'L'?

Well, probably.. me.

> As it hasn't been advertised in the documentation (lucky us), it probably is not too
> late to remove it.

No objection if you remove it. I was probably thinking of git
"symlink" but the traditional -l was taken, so -L.
-- 
Duy
