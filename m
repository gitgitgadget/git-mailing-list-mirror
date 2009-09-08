From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was generated
Date: Tue, 8 Sep 2009 11:20:59 +0200
Message-ID: <20090908092059.GA8207@lars.home.noschinski.de>
References: <1251481187-6361-1-git-send-email-lars@public.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 11:51:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkxLT-0005Wg-78
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 11:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbZIHJsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 05:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZIHJsK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 05:48:10 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:47096 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbZIHJsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 05:48:10 -0400
X-Greylist: delayed 1629 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2009 05:48:09 EDT
Received: from [87.78.90.198] (helo=fruehjahrsmuede.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1Mkwqv-0002vk-Up; Tue, 08 Sep 2009 11:19:06 +0200
Received: from lars by fruehjahrsmuede.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1Mkwsl-000299-TH; Tue, 08 Sep 2009 11:20:59 +0200
Content-Disposition: inline
In-Reply-To: <1251481187-6361-1-git-send-email-lars@public.noschinski.de>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127997>

* Lars Noschinski <lars@public.noschinski.de> [09-08-28 19:39]:
> contrib/hooks/post-receive-email used to call the send_mail function
> (and thus, /usr/sbin/sendmail), even if generate_mail returned an error.
> This is problematic, as the sendmail binary provided by exim4 generates
> an error mail if provided with an empty input.
> 
> Therefore, this commit changes post-receive-email to only call sendmail
> if generate_mail returned without error.
> 
> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>

Is anything wrong with this patch? Or is it just queued to be committed
some time?

 - Lars.
