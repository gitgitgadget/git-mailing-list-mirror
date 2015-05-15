From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: determine a linux kernel version of a patch file
Date: Fri, 15 May 2015 14:08:38 +0200
Message-ID: <vpqr3qicabd.fsf@anie.imag.fr>
References: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pawel Por <porparek@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 14:08:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtEQ7-0007Jf-1R
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 14:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbbEOMIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 08:08:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50029 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934130AbbEOMIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 08:08:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4FC8a6l002596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2015 14:08:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4FC8cuE005845;
	Fri, 15 May 2015 14:08:38 +0200
In-Reply-To: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
	(Pawel Por's message of "Thu, 14 May 2015 19:08:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 15 May 2015 14:08:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4FC8a6l002596
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432296520.96955@7ZAKIGDzEx8UdQgWOHTkpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269141>

Pawel Por <porparek@gmail.com> writes:

> Hi,
>
> At the beginning I'm sorry if this post is completely unrelated to
> this mailing list.
> I'm trying to find the base linux kernel version from which a patch
> has been created and posted to LKML.
> Most patches contain the index line. Is it the well known git index
> (staging area) ?

This is the id of the blob object corresponding to the _file_ being
patched (index <from>..<to> <mode>). That's why you don't see it in git
log: git log shows you ids for commit objects (which point to trees,
which in turn points to blob).

See Johannes' answer for how you can get some possible commits.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
