From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 10/15] for-each-ref: introduce format specifier %>(*) and %<(*)
Date: Wed, 5 Jun 2013 13:44:05 +0530
Message-ID: <CALkWK0=9X6QhCOPfV6Gq31VVccyDoO3ciPxG+2kqpgL2foiQSw@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
 <1370349337-20938-11-git-send-email-artagnon@gmail.com> <CACsJy8A2h0pjZ759NpByrEJYzg3ETyDkUGTptC-FFkeZCpGSbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 10:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk8rs-000088-VR
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 10:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3FEIOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 04:14:48 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54309 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3FEIOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 04:14:45 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so328079iec.7
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=THN0LFUSLaPw4Sqxr3y/ELPqThDYSv9Xz3MOyWe/WdQ=;
        b=MtZ6f5zQqrEdRFBRqlBn5Yd3ydzs3frwbFrmntfHRxUnGnY5BarKwgr7qnyPyA3I5l
         Gq0un14ltyFlv9PHMIjFj+hZU7pzvNDZcTlByifhZPg9aXOLeMBpsURu6iU6WesPRLrq
         ioZMImAY/mRAonCXqManqtdw5N8OyXGjuz1A3rmUN+XAtg6rVXOP3/pUMQYrNTV+KpzC
         bV5oT9ufw9SqcpwowoZpgFhdoQBvBMI/SvaeaKL5FriBqfle8aAKd/RcdHcDA0uCSDFj
         sTS2myHW430B+o9AFfe8deSsC2P3L3TNvyeWwbX9MT79/UP756Z+o9PBMSniV1RQ11Cj
         P0PA==
X-Received: by 10.50.171.161 with SMTP id av1mr2621270igc.104.1370420085166;
 Wed, 05 Jun 2013 01:14:45 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Wed, 5 Jun 2013 01:14:05 -0700 (PDT)
In-Reply-To: <CACsJy8A2h0pjZ759NpByrEJYzg3ETyDkUGTptC-FFkeZCpGSbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226442>

Duy Nguyen wrote:
> I mentioned it before and I do it again. This is not optimal.

Yeah, I'll attempt to fix this, but it's not urgent.

> But I guess it's ok in this
> shape unless you run this over hundreds of refs.

Oh, you can run over a hundred refs just fine, for scripting purposes;
but why would you want to run over a hundred refs with a pretty that
includes %>(*) or %<(*)?
