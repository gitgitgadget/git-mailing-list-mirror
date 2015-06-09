From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: gitscm vs. git-scm
Date: Tue, 09 Jun 2015 15:08:46 +0200
Message-ID: <vpq382181wh.fsf@anie.imag.fr>
References: <5576E2FE.4090105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 15:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2JH2-0000kp-KG
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 15:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbbFINI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 09:08:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51938 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541AbbFINIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 09:08:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t59D8ixA020404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 15:08:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t59D8kqk029695;
	Tue, 9 Jun 2015 15:08:46 +0200
In-Reply-To: <5576E2FE.4090105@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 09 Jun 2015 14:58:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 15:08:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t59D8ixA020404
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434460127.67319@NjwAjQtMP/mNIg2vh7mbGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271176>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Hi there,
>
> I (mis-) remembered the git site address and noticed that gitscm.com
> returns empty while git-scm.com is our beloved home. I thought, though,
> that we have a couple domains with redirects but I may be misremembering
> that also. Or DNS is "hicking up".

Not the DNS. gitscm.com is returning a whole window frame containing
git-scm.com, but then the frame doesn't load (at least in Firefox). The
inspector tells me:

Load denied by X-Frame-Options: http://git-scm.com/ does not permit cross-origin framing.

I guess gitscm.com should just redirect to git-scm.com (sending the
Location: field, and/or with stg like
<meta http-equiv="Refresh" content="0; URL=http://git-scm.com" />
)

Frames are so 2000 ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
