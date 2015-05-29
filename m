From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 19:53:43 +0200
Message-ID: <vpqoal3p8wo.fsf@anie.imag.fr>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
	<xmqq617bflzh.fsf@gitster.dls.corp.google.com>
	<vpq4mmvs7zx.fsf@anie.imag.fr>
	<xmqqeglze5cu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 19:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyOTk-0002A3-3N
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 19:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbbE2Rxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 13:53:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48656 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbbE2Rxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 13:53:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4THrfPP019254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 19:53:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4THrhbP005947;
	Fri, 29 May 2015 19:53:43 +0200
In-Reply-To: <xmqqeglze5cu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 May 2015 09:05:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 19:53:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4THrfPP019254
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433526823.61577@eEBkQycC0SsIBRJcy/qjww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270259>

Junio C Hamano <gitster@pobox.com> writes:

> I recall "fetch --tags" was updated to become your "--tags-also" by
> e66ef7ae (Merge branch 'mh/fetch-tags-in-addition-to-normal-refs',
> 2013-12-12).  Perhaps we should do the same on the push side.

Would we still have a way to push tags only with this?

fetch and push are a bit different: it's almost never a bad idea to run
fetch (I see remote-tracking as a kind of cache, and fetch is the way to
refresh this cache), but pushing too much can be harmful. Not a strong
objection, but I'm not sure that this change is 100% safe for everyone.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
