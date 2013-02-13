From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Wed, 13 Feb 2013 17:12:09 +0100
Message-ID: <vpqbobo5h2e.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu> <vpqtxpgb6ue.fsf@grenoble-inp.fr>
	<201302131526.57342.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:12:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5ewv-0001T2-Al
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 17:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759926Ab3BMQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 11:12:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:33408 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab3BMQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 11:12:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1DGC8UI007981
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Feb 2013 17:12:08 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U5ewL-0002iV-Ru; Wed, 13 Feb 2013 17:12:09 +0100
In-Reply-To: <201302131526.57342.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 13 Feb 2013 15:26:57 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Feb 2013 17:12:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1DGC8UI007981
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361376730.09214@z3NsIEbRNqb6oFZKDbFrFg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216266>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 13 February 2013 14:56:25 Matthieu Moy wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I think adding a short "dependencies" section in the README (or in an
>> INSTALL file) saying which Python version works could save new users the
>> trouble (I see the sheebang inside the scripts says python2 but since I
>> couldn't use my system's python and called
>> "path/to/python git_multimail.py", this didn't help). Making the script
>> portable with python 2 and 3 would be awesome ;-).
>
> For my 2p worth, I don't like seeing hooks called like this.  Particular those 
> that come as part of the standard installation.

What do you mean by "like this" ?

> I call mine by installing little scripts like this (on Debian):
>
>   #!/bin/sh
>   # stored as $GIT_WORK_DIR/.git/hooks/post-receive-email
>   exec /bin/sh /usr/share/git-core/contrib/hooks/post-receive-email

Yes, this is what I was doing (with path/to/python instead of /bin/sh,
and git_multimail.py, or more precisely path/to/git_multimail.py,
instead of post-receive-email).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
