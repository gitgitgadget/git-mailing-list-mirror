From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 22:23:31 +0200
Message-ID: <vpqr445nxrw.fsf@anie.imag.fr>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
	<vpqy4ydpiog.fsf@anie.imag.fr>
	<536a842838fbb_76ff7a52ec5d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:23:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8NV-0000g5-34
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaEGUXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:23:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58789 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbaEGUXk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:23:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s47KNSCm026445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2014 22:23:28 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s47KNVj1032747;
	Wed, 7 May 2014 22:23:31 +0200
In-Reply-To: <536a842838fbb_76ff7a52ec5d@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 07 May 2014 14:06:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 07 May 2014 22:23:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s47KNSCm026445
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400099013.16896@1BtScRecYRth6t/VWl7PJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248358>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > It's better if all our scripts use the same '/usr/bin/env python'.
>> 
>> Why?
>> 
>> Using python2 for git_multimail.py is a deliberate decision:
>
> If you want to use python2, then use '/usr/bin/env python2'.

Err, yes, this is what the code does before your patch.

>> "The git-multimail project itself is currently hosted on GitHub:
>> 
>>     https://github.com/mhagger/git-multimail
>> 
>> We use the GitHub issue tracker to keep track of bugs and feature
>> requests, and GitHub pull requests to exchange patches (though, if you
>> prefer, you can send patches via the Git mailing list with cc to me).
>> Please sign off your patches as per the Git project practice."
>> )
>
> If you are going to follow practices different than git.git, then
> multimail shouldn't live in 'contrib/'.

git-multimail is not the only part of git.git that has a separate
maintainer. Same goes for git-gui and gitk.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
