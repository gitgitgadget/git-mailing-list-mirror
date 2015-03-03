From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSoC15] Interested in contributing to git
Date: Tue, 03 Mar 2015 17:20:25 +0100
Message-ID: <vpqbnkagiie.fsf@anie.imag.fr>
References: <CACRoPnSrjysUhC77LXVjy5VJxFFPoiRuhD7pMab_8T2Pua_T+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:20:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSpYi-0003fc-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 17:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbbCCQUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 11:20:32 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46030 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbbCCQUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 11:20:32 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t23GKNkB030556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Mar 2015 17:20:23 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t23GKP7k018182;
	Tue, 3 Mar 2015 17:20:25 +0100
In-Reply-To: <CACRoPnSrjysUhC77LXVjy5VJxFFPoiRuhD7pMab_8T2Pua_T+A@mail.gmail.com>
	(Paul Tan's message of "Tue, 3 Mar 2015 23:56:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Mar 2015 17:20:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t23GKNkB030556
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426004427.20964@u5ZZVJiyjqfFZ2VBNgnviw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264669>

Paul Tan <pyokagan@gmail.com> writes:

> Hi all,
>
> git is one of the projects that I wish to contribute to for Google
> Summer of Code 2015 as it's an integral part of my workflow. I'm from
> Singapore, and have been accepted to the National University of
> Singapore for Computer Engineering, and will only matriculate on 3 Aug
> 2015.

Be carefull: a GSoC is a full-time job. The GSoC itself ends on August
21st, so there would be a substantial (too big?) overlap between the
GSoC and your studies.

> I understand that I have to complete a microproject. I would like
> complete "Move ~/.git-credentials and ~/.git-credential-cache to
> ~/.config/git". I'm thinking that the XDG locations should take
> precedence over the non-XDG locations?

The logic is different for reading and for writting, see how Git deals
with it for ~/.gitconfig for example. Essentially, we read both, and we
write to the one which exists if there's only one.

I'm the one who proposed this microproject, and some feedback on the
mailing-list was that it was not so "micro" and probably too big
already.

Both for the microproject and the GSoC itself, don't be too ambitious on
the feature you target, and don't underestimate the effort needed to get
from "the code looks OK to me" to "the code has been reviewed on list
and merged upstream".

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
