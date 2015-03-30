From: Max Kirillov <max@max630.net>
Subject: Re: [question] && chaining vs shell loops
Date: Mon, 30 Mar 2015 09:29:25 +0300
Message-ID: <CAF7_NFTxg3y9gWqHQqgt_TmOfUxA7yH2Krn4ma8SoY_-1Gx4SQ@mail.gmail.com>
References: <20150329154840.GA8771@wheezy.local>
	<874mp3948k.fsf@igel.home>
	<20150329174312.GA6680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcTCW-00081H-K9
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 08:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbbC3G32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 02:29:28 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35461 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbbC3G30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 02:29:26 -0400
Received: by igcau2 with SMTP id au2so65280284igc.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WmqQIJ8/NSnmXbzJAFiquiLXzpBO6mFFaQ6dR3upt/0=;
        b=BM7TDyn7AK4S9mGn8YoGykQjgF6q+GFfGS+BxeTknlihUihxc9EBIpajOMPsGEj5gI
         /GljL8uRE8tZgphpjA7z5tcP7S4+aMrJ97eAkxKbYYNGzZ+X5BFX+UsoxNrnKhNbdG8f
         VEIrQ9e81nI600WRr2n8EvpgAr38A0ugnDReRtczBupOLsdf0CGL+cLQhEBbUih2X77C
         4dzREHy9jomqmQtCs2e8htteSXdwSPAue7QEytG4AAfeJueGNcEH820uZeleJy1e0Y4U
         9YlkH9iswALa7gFT5snK97Tsg3st5BGksyLOK8SqmLIgSmIKtpWDqcJXV1czzp5hvlm3
         3e7Q==
X-Received: by 10.50.137.2 with SMTP id qe2mr15537358igb.20.1427696965792;
 Sun, 29 Mar 2015 23:29:25 -0700 (PDT)
Received: by 10.64.252.132 with HTTP; Sun, 29 Mar 2015 23:29:25 -0700 (PDT)
In-Reply-To: <20150329174312.GA6680@peff.net>
X-Google-Sender-Auth: AvBg_En4WXM9ENrTltHyq4NQXpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266448>

On Sun, Mar 29, 2015 at 8:43 PM, Jeff King <peff@peff.net> wrote:
> In our test scripts, it is also OK to just "return 1", because
> the test snippets execute inside a function.

Thanks, sounds like a plan.

-- 
Max
