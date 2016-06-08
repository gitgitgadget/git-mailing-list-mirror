From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Wed, 8 Jun 2016 17:44:06 +0700
Message-ID: <CACsJy8CtsFFJPssDDBuL8TLoxi1f=734mjAjCUOr8Y63aD3xUA@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <CACsJy8Dr_Z886Jb-O8gbAv_vzBLicNH6bPPpKwb9HWZTKQ9muw@mail.gmail.com>
 <CAP8UFD3jPQFk2deSk5JXC3PTz5yWcvXJ4=Qjam5Qw6P9SrLzFQ@mail.gmail.com>
 <CACsJy8DB_17DZ7REBzicyA_GZCnvNkoYEzftjfyM72QVmEb_Vg@mail.gmail.com>
 <CAP8UFD2t=2wJ=1U1ctMYNuMSejBYLh2yeLU7ZfP5Q6KLxUApjQ@mail.gmail.com>
 <xmqqinxkpzur.fsf@gitster.mtv.corp.google.com> <20160607202351.GA5726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:44:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAayX-0001AE-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 12:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbcFHKoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 06:44:37 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36038 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbcFHKog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 06:44:36 -0400
Received: by mail-io0-f171.google.com with SMTP id n127so5398975iof.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yIsKM7e1J1+bZ19ASrO2I8ckEu1ALjRoSAF5Yr4TN2c=;
        b=YrWbqeOLyvbtnwALcYKWnPvJBQaxmLU+tcWwuk7cQnIY0SSK/ymXrn9kJgrASWNH6T
         1Y79y98zPBJiPurTxstIOXJ3/yAnBmsMPIoA9YvCc91Hq3DQ4VnSr7zu2zyuMPI6XPmf
         JFYK1h+ACTkr5kDimnm+syZQO12b/VYz3FypCUPtnjIfA9I7VcVMRuqmy9YXfPPfGw1k
         uqswWo2jNZck2IjJoepu+RczOXT4ay/y2CmeZZmzfifhMOvnik9JwSrU+w34IcSQ0Vaf
         y5vTecsQdH+1EpGojArO51HGbojYCvpHHQiVOld7F+Q8EGAVCUrs27G9tjFyBbzySODT
         V6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yIsKM7e1J1+bZ19ASrO2I8ckEu1ALjRoSAF5Yr4TN2c=;
        b=glUGzs/71sSEpzYZv8f+QAOWnLr1Wxcp5QQa2vBZh9vlZRTzYKP9XoYaJwdgYq8U2M
         4CZe1JjLo/INu8AQeUJJWMM77E0zgS8BZ7ZGA5YE4wQARwKWlxeEMQCrJ+VEfgV9K1sc
         kxVT3Cwhm2r3LWBAwAiMcjqGFpB9QNTkp+I6UGvlWnvo++x79NElBzVF5lutW2vYQeWU
         2h7p868VmhZPGir8BeExu/k9tRo48JagrmJN4EXSrZTbbJA08500gOlk7QTHsCgoCXGD
         ixv0vadQP+282S25eXmjndsZWG4JH8okAkV3+7ZZzcy7SAhrMI80sRRyPP2AK7cf6pqF
         eOgg==
X-Gm-Message-State: ALyK8tJMAJCeRZwBWNlL47WUWCefpiCsF8qyUDN9uQb/Y0HIZvy6RN73gIoJLxBjO77LAEgbFuyx7ix5ef+KIA==
X-Received: by 10.107.159.84 with SMTP id i81mr6649858ioe.29.1465382676018;
 Wed, 08 Jun 2016 03:44:36 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 8 Jun 2016 03:44:06 -0700 (PDT)
In-Reply-To: <20160607202351.GA5726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296782>

On Wed, Jun 8, 2016 at 3:23 AM, Jeff King <peff@peff.net> wrote:
> Because this "external odb" essentially acts as a git alternate, we
> would hit it only when we couldn't find an object through regular means.
> Git would then make the object available in the usual on-disk format
> (probably as a loose object).

This means git-gc (and all things that do rev-list --objects --all)
would download at least all trees and commits? Or will we have special
treatment for those commands?
-- 
Duy
