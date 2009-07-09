From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 3/4] verify-pack: migrate to parse-options
Date: Thu, 09 Jul 2009 09:01:20 -0700
Message-ID: <4A561450.4000404@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com> <1247030141-11695-2-git-send-email-bebarino@gmail.com> <1247030141-11695-3-git-send-email-bebarino@gmail.com> <1247030141-11695-4-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 18:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOw53-0000gB-EJ
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363AbZGIQB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757057AbZGIQB2
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:01:28 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33591 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbZGIQB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:01:27 -0400
Received: by fxm18 with SMTP id 18so278842fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=1RbQN+3ZDTiMT7a1HwNQGcPOHh3kjKLxucTzfTORPzE=;
        b=YesvVV0K9/vfWpbgm2clOCtbj+WozXeXypGWsBawnekNb1x//Nq4aEQ65lC+zwK2lL
         LW9NAbdeQoF11CEGvcg6h0M1Tw7IR+sPuycwpYARG0B4DuM9KCaehA0zjbK6B4YgklY0
         8H6aYImxWcodPJVqIyywRHiXn9RgpnIZYEHhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=BBq7j73UnsLiqGIEC+2qm5JQIrPEHcHMAssVH3rE0754xGFF48skxup+gZ6AWr5kR+
         PtayVlUY759r5VLdhdCmn/Em9DWoGsAl3ZUeLxU5TlLyq7vtZhlobirnJcgMoPm5Lgfr
         aMaY2bMWfTxDegDxn//FFIfYoE3yNSmdXo908=
Received: by 10.204.51.65 with SMTP id c1mr863168bkg.59.1247155286024;
        Thu, 09 Jul 2009 09:01:26 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 35sm18371832fkt.20.2009.07.09.09.01.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 09:01:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1247030141-11695-4-git-send-email-bebarino@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122985>

Stephen Boyd wrote:
> OPT__VERBOSE adds a --verbose option, so document the new addition.
>   

OPT__VERBOSE introduces the long option (--verbose) in addition to the
already present short option (-v),  so document this new addition.

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
>   
