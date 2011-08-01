From: Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 01 Aug 2011 11:27:49 -0700
Message-ID: <4E36F025.9040100@gmail.com>
References: <4E362F8E.1050105@gmail.com> <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com> <4E36B8E4.5080900@gmail.com> <20110801180603.GB10636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:27:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxDZ-0001ts-1N
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab1HAS1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:27:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59430 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1HAS1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:27:52 -0400
Received: by ywn13 with SMTP id 13so883271ywn.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Sd8HEHW1EpM0Uvm7Hnl6rlPnQXRylgR8zp4uBVt/TK4=;
        b=ImC5dhUMRtKicUPcv3vwOG4pnFdB94mlKv/HoEznirwofwuQpUfP20vAj8xgux5Nfx
         qilQgII4WWOUj7LkCRxXkXMtiIf/XnfUusUVAjP2OH00PHVPVGFBrDxQO9Agi7ZDXShP
         Qmbx9zgmuNfFS6u+gP7ywlOGRQi8qRajA7YG0=
Received: by 10.101.214.10 with SMTP id r10mr3362471anq.115.1312223271298;
        Mon, 01 Aug 2011 11:27:51 -0700 (PDT)
Received: from [192.168.50.71] (206-80-5-2.static.twtelecom.net [206.80.5.2])
        by mx.google.com with ESMTPS id l38sm5102659ani.44.2011.08.01.11.27.50
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:27:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110801180603.GB10636@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178395>

On 8/1/2011 11:06 AM, Jeff King wrote:
>
> I think he means that auto-pluralization like this cannot be done in an
> i18n world, as many languages do not simply add "s". Your patch would
> have to use ngettext, something like this (totally untested and just
> copying a similar spot in suggest_reattach, as I have never done any
> i18n myself):

[snip]

> And that gives translators a chance to specify the entire singular and
> plural versions separately.

I entirely agree. My point is only that the various tests
that expect the current behavior will have to be changed
whether the implementation of correct plurals uses my
inferior method or the way more correct i18n method.

Jon
