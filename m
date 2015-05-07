From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config --global --edit: generate correct .gitconfig template
Date: Thu, 07 May 2015 10:45:27 +0200
Message-ID: <vpq38384vyw.fsf@anie.imag.fr>
References: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pete Harlan <pchpublic88@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 10:45:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHR3-0006Aw-QJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbbEGIpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:45:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42360 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbbEGIpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:45:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t478jQqc006444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2015 10:45:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t478jRN7030193;
	Thu, 7 May 2015 10:45:27 +0200
In-Reply-To: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com> (Pete
	Harlan's message of "Wed, 6 May 2015 10:41:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 May 2015 10:45:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t478jQqc006444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1431593127.10868@kfVM+h00otE9OoLFNU8kHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268523>

Pete Harlan <pchpublic88@gmail.com> writes:

> When the user asks to edit an empty .gitconfig file, we learned to
> generate a default version in 9830534e (config --global --edit: create
> a template file if needed, 2014-07-25), but the generated config
> mistakenly set core.user and core.email instead of user.name and
> user.email.

Oops, indeed. I don't know how I could came up with such mistake and not
notice.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
