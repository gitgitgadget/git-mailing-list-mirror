From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] log: add log.follow config option
Date: Fri, 03 Jul 2015 09:17:45 +0200
Message-ID: <vpqr3op676u.fsf@anie.imag.fr>
References: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
	<vpq8uazo9y6.fsf@anie.imag.fr>
	<xmqqvbe37eyy.fsf@gitster.dls.corp.google.com>
	<1435862617.30946.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 09:18:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAvEU-0003C3-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 09:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbbGCHRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 03:17:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34279 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbbGCHRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 03:17:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t637HjWM016258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 09:17:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t637Hjns022210;
	Fri, 3 Jul 2015 09:17:45 +0200
In-Reply-To: <1435862617.30946.2.camel@twopensource.com> (David Turner's
	message of "Thu, 02 Jul 2015 14:43:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Jul 2015 09:17:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t637HjWM016258
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436512667.27747@N9Ie+WsfKI6TsIpV7Qy3ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273280>

David Turner <dturner@twopensource.com> writes:

> Twitter's history is almost completely linear, so it's useful for us.  
>
> Since it looks like the patch won't be useful outside of our context,
> I'll just rewrite it to check the pathspec count, and not upstream it
> until follow becomes more general.

As long as it's an opt-in and that the documentation states the
limitations clearly enough, I think it makes sense to me to have this
upstream.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
