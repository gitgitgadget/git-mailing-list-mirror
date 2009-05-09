From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH 4/5] git.el: Added support for Signed-off-by.
Date: Sat, 09 May 2009 21:57:31 +0200
Message-ID: <87r5yycams.fsf@wine.dyndns.org>
References: <877j7akvvy.fsf@wine.dyndns.org>
	<1241879110.2910.89.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sat May 09 22:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2t2k-0006Rv-KP
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 22:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbZEIUVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 16:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbZEIUVA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 16:21:00 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:35606 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbZEIUU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 16:20:59 -0400
X-Greylist: delayed 1399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2009 16:20:59 EDT
Received: from adsl-89-217-122-242.adslplus.ch ([89.217.122.242] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1M2sfu-0008Jf-RD; Sat, 09 May 2009 14:57:40 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0416B1E734A; Sat,  9 May 2009 21:57:32 +0200 (CEST)
In-Reply-To: <1241879110.2910.89.camel@macbook.infradead.org> (David
	Woodhouse's message of "Sat, 09 May 2009 15:25:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.93 (gnu/linux)
X-Spam-Score: -3.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118680>

David Woodhouse <dwmw2@infradead.org> writes:

> On Sat, 2006-03-04 at 17:38 +0100, Alexandre Julliard wrote:
>> If `git-append-signed-off-by' is non-nil, automatically append a
>> sign-off line to the log message when editing it.
>
> This doesn't seem to work when I hit C-v v to commit. I just get an
> empty *VC-log* buffer.

C-v v doesn't use git.el, it uses the standard Emacs VC mode with the
vc-git backend. I don't think there's a clean way currently for a VC
backend to populate the log buffer, so if you want the auto sign off you
have to do the commit from the git-status buffer.

-- 
Alexandre Julliard
julliard@winehq.org
