From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Textconv
Date: Mon, 11 Mar 2013 11:00:50 +0100
Message-ID: <vpqtxoicl2l.fsf@grenoble-inp.fr>
References: <513DA7E1.7050206@mylovecompany.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dmitry Ilin <dmitry@mylovecompany.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 11:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEzXo-0008Pd-CX
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 11:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab3CKKA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 06:00:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59042 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab3CKKA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 06:00:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2BA0nIU004497
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 11:00:49 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UEzXG-0008H7-G2; Mon, 11 Mar 2013 11:00:50 +0100
In-Reply-To: <513DA7E1.7050206@mylovecompany.com> (Dmitry Ilin's message of
	"Mon, 11 Mar 2013 13:46:09 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Mar 2013 11:00:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BA0nIU004497
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363600852.70204@gCCIbSIsstku3gYANEZp0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217864>

Dmitry Ilin <dmitry@mylovecompany.com> writes:

> Hello!
>
> Most of GUI for Git using 'git show' command to show differences
> between versions. For example: WebStorm IDE. But for now there is no
> way to specify text conversion command in git config for 'show' as it
> done for 'diff'.

Do you mean, to enable it, or to disable it?

By default, "git show" does use the textconv filter to compute the diff,
at least if you specified the textconv driver in your .gitattributes
file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
