From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: Only call a new ref a "branch" if it's under refs/heads/.
Date: Thu, 12 Apr 2012 22:42:20 +0200
Message-ID: <4F873E2C.6080808@web.de>
References: <1334154569-26124-1-git-send-email-marcnarc@xiplink.com> <20120412055216.GC27369@sigill.intra.peff.net> <4F8737C8.1020501@web.de> <4F873CD0.4050204@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:43:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQrO-0002MF-MI
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762708Ab2DLUnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:43:14 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:39903 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749Ab2DLUnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:43:13 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id DA89575D41CD
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 22:42:21 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.165.27]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MMW5u-1SNLjH108s-008GX4; Thu, 12 Apr 2012 22:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F873CD0.4050204@xiplink.com>
X-Provags-ID: V02:K0:NSCc5KnqrmKa9KhPUx9oOL6oCvA9l8Vh+D+T+QKSvz8
 Q4cWWk1L4I/E5htrNmhXn506iviCiMM816zX1cazo9A+gXM4WF
 puqU/gvcN1SwpZt5MMFbD3syYUe39GENbLgKsFkacAcYxHaxcp
 4Yc5NFMNw50CMlTKwCo+11KRbNWH1E73b5iancxVRwI83k9wkW
 mXgXTO3zN7XxqofXJzzGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195367>

Am 12.04.2012 22:36, schrieb Marc Branchaud:
> I assumed it was an optimization of some sort -- that since tags are normally
> only fetched when they're part of a requested branch's history (right?),
> there was no point in doing submodule recursion on the fetched tags since
> those tagged tree-ishes had already been submodule-recursed.

If that is the case the patch I just sent is pointless, but adding a comment
there explaining that would be a good thing ;-)
