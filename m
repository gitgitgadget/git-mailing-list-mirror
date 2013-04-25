From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 16:50:32 +0200
Message-ID: <87haiu7jgn.fsf@linux-k42r.v.cablecom.net>
References: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 16:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVNVZ-0006XE-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 16:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581Ab3DYOug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 10:50:36 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6424 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932559Ab3DYOue (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 10:50:34 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 16:50:30 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 25 Apr 2013 16:50:32 +0200
In-Reply-To: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 25 Apr 2013 06:25:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222385>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Not just randomly synchronize the revisions with no checks at all. This
> is the way bazaar's UI does it.
>
> Also, add a non-ff check.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> This patch should probably go to maint, as the results of pushing the way we
> currently push are not really understood. Perhaps it's similar to a 'git push
>  --force', or perhaps it can potentially screw the repository.
>
> It's better to be safe and just do what bazaar does.

Other than "this patch should probably go to maint", this should be in
the commit message.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
