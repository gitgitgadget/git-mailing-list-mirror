From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git merge man page, upstream
Date: Tue, 23 Oct 2012 13:35:43 +0200
Message-ID: <vpqehkpqv3k.fsf@grenoble-inp.fr>
References: <CAB9Jk9BT3F1_yvf7jQQyT72_EWskFS4bEgXCkmJs7uZOPhEK8w@mail.gmail.com>
	<vpqk3uhr5gp.fsf@grenoble-inp.fr>
	<CAB9Jk9CEbT=Y=yjw2tPSLiLibejDSheabcBPEpHCLa_TS+6Cpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 13:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQcm9-0001di-OC
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 13:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab2JWLfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 07:35:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41310 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948Ab2JWLft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 07:35:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q9NBSHEL029943
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Oct 2012 13:28:17 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TQcls-0006VG-0B; Tue, 23 Oct 2012 13:35:44 +0200
In-Reply-To: <CAB9Jk9CEbT=Y=yjw2tPSLiLibejDSheabcBPEpHCLa_TS+6Cpw@mail.gmail.com>
	(Angelo Borsotti's message of "Tue, 23 Oct 2012 11:07:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Oct 2012 13:28:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9NBSHEL029943
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1351596501.18802@vnMI4m0GJpqppm4SXvPVzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208223>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hi Matthieu,
>
> the upstream branch can also be a local branch.

In this case, it's:

[branch "branch"]
        remote = .
        merge = refs/heads/master

which can arguably be considered as a special case of remote branch
whose location happens to be ".". But as said in the patch, I don't mind
if someone wants to drop the remote-tracking mention on top of my patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
