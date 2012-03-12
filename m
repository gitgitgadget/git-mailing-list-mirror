From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 14:40:43 -0700 (PDT)
Message-ID: <m34nttzeex.fsf@localhost.localdomain>
References: <4F5E4B20.5080709@lyx.org>
	<7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F5E5A77.1070605@lyx.org>
	<7vd38hr22e.fsf@alter.siamese.dyndns.org> <4F5E68C5.5070300@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:40:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Cz4-000822-5k
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2CLVkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:40:45 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49221 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab2CLVkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:40:45 -0400
Received: by wibhq7 with SMTP id hq7so4463717wib.1
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4KUFcSoLj3rSnqa6u1tUaKxakOxwkcQmenx3bjgtAAA=;
        b=jb0nIBjaLRpz9Mum54J4L2gbIoMPAsmlzs80AiLGLN0614UewZphRR5kAkf8HTUA9/
         rI/iS5NKLqcbhCyV1qz/JqAJV3uTP6pnNIMUEcdL3xEKnn2ujZD2/Tnb0gdEGCruy2Ps
         zUQiUP2014g6DnSM4K6Op3r3/SoD0xDmJ9oGxQ1oAEwpC15lB9zhN6I7Qu00pyT8vVi3
         XtRrjhxcHMJ9zSru+pXnLABDA1YjK7mGhSCtkAwbcsCE06gpidDOzxKvwX95UtoUuzws
         er9m3xRNkGZdoaHzlSyEXyYH8xcRLJlpBib8p4UGeMsqiXv7Du6bzILlTyjArlwnA7zH
         SfBg==
Received: by 10.180.86.105 with SMTP id o9mr1492103wiz.4.1331588443531;
        Mon, 12 Mar 2012 14:40:43 -0700 (PDT)
Received: from localhost.localdomain (abvp228.neoplus.adsl.tpnet.pl. [83.8.213.228])
        by mx.google.com with ESMTPS id k6sm37269627wiy.7.2012.03.12.14.40.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 14:40:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2CLeftF028123;
	Mon, 12 Mar 2012 22:40:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2CLeMUg028113;
	Mon, 12 Mar 2012 22:40:22 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F5E68C5.5070300@lyx.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192953>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> As I wrote, the merge resolutions in my case were very easy
> (logically), but just annoying (motorically).
> These could even be resolved by some merge-conflict hook.
> 
> Examples:
> - for this file we know the conflict always has to be resolved by
> adding the oldest hunk before the newest hunk. For example, new file
> formats will be added sequentially to a file.
> - for this file we can resolve it anyway we want. For example, a
> release notes file which just enumerates all changes in random order.
> 
> Anyway, has anyone thought about such a hook ?

Isn't it what custom merge drivers (for file-level merge) are for?
I think there can be found somewhere merge driver for changelog...

You can also use custom merge strategies, but that is probably
overkill, and I am not sure that it would work (adding new strategy)
without modifying git.

-- 
Jakub Narebski
