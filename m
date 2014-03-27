From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH] MSVC: added missing include so =?utf-8?b?YG1ha2U=?= =?utf-8?b?SU5MSU5FPV9faW5saW5lYA==?= is no longer required
Date: Thu, 27 Mar 2014 17:43:40 +0000 (UTC)
Message-ID: <loom.20140327T183247-442@post.gmane.org>
References: <1395905668-32005-1-git-send-email-marat@slonopotamus.org> <1395905668-32005-2-git-send-email-marat@slonopotamus.org> <xmqqzjkbegdt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 18:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTELo-0000fL-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbaC0RoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 13:44:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:45785 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756972AbaC0RoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 13:44:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WTELV-0000Ro-VR
	for git@vger.kernel.org; Thu, 27 Mar 2014 18:44:06 +0100
Received: from core-gate-01-v50-x7.possvyaz.ru ([core-gate-01-v50-x7.possvyaz.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 18:44:05 +0100
Received: from marat by core-gate-01-v50-x7.possvyaz.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 18:44:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 176.57.72.72 (Mozilla/5.0 (Linux; U; Android 4.0.4; ru-ru; SonyEricssonMK16i Build/4.1.B.0.587) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245299>

Junio C Hamano <gitster <at> pobox.com> writes:
> My gut feeling is that adding a mechanism to add -DINLINE=__inline
> only on MSVC to the top-level Makefile, without touching this file,
> may be a much more palatable.

Okay, I'll think more about this one. Maybe *moving* inline=__inline from 
compat-headers into Makefile (actually, config.mak.uname) will work better.

Hope it doesn't prevent first patch from being integrated -- joining them in a 
single thread was unintentional misuse of `git send-email` flags.
