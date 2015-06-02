From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFCv2 13/16] fetch-pack: use the configured transport protocol
Date: Tue, 2 Jun 2015 17:02:45 +0700
Message-ID: <CACsJy8AadHof8bxeD3jfZ-MKSBLXGdw23SeJLgp7sCy+N7n_GA@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com> <1433203338-27493-14-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:03:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzj2Y-000323-9P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 12:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbbFBKDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 06:03:18 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35559 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655AbbFBKDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 06:03:16 -0400
Received: by iesa3 with SMTP id a3so129202640ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=st5bT8hqHiTdjMXHyHqMbesTt/3FYOq+dho3afyfl+8=;
        b=eOkQ1mOuba/03gFoUCjDNovSN1ir7iwEW2D8BecHts+/z++g3XhfhTC4FTCNAFok7x
         IRGPtpQXg1ox0cO3F0f9R4P9+TCNj4SuvAAIVBP3cu+hwnAab1wuC40PDmG6OVpr5iLt
         rYtAWppV9DsZEn4pn8muHiPquH/VgMa8vQheEHUEw9ioyo8n41cWN/yOyYAKUHcDTnBf
         8DWD5XWNB6YGD73675YXfRnfpxa77hjPTb96xw4Ce8kfAyZlOUVOuFJbzvAjBiarMnCw
         r/kHU3zixkBe6zxeZFAj1ZXIUGni7tptMAQ+vwT53cm/1ABcQBqK0DAPwjJxQ16vPwQi
         M0wg==
X-Received: by 10.50.176.134 with SMTP id ci6mr4259088igc.27.1433239395798;
 Tue, 02 Jun 2015 03:03:15 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 2 Jun 2015 03:02:45 -0700 (PDT)
In-Reply-To: <1433203338-27493-14-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270516>

On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
>  builtin/fetch-pack.c |  22 ++++++++++-
>  fetch-pack.c         | 109 +++++++++++++++++++++++++++------------------------
>  fetch-pack.h         |   1 +
>  3 files changed, 80 insertions(+), 52 deletions(-)

And the companion changes in transport-helper.c should be in this
patch as well to support smart http. I don't think there is any
problem with how you store the "version" (or "transport_version", you
should probably stick to one name) though.
-- 
Duy
