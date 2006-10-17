From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:24:32 +0200
Message-ID: <vpqhcy310m7.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca> <200610171030.35854.jnareb@gmail.com>
	<vpqejt76vgz.fsf@ecrins.imag.fr> <4534C5CF.3000508@op5.se>
	<vpqlknf3wdz.fsf@ecrins.imag.fr> <4534E246.10105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 17 16:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZptW-0001yE-Fx
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWJQOZi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 10:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWJQOZh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:25:37 -0400
Received: from imag.imag.fr ([129.88.30.1]:43739 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751091AbWJQOZg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 10:25:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9HEOXQP020813
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Oct 2006 16:24:34 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GZprt-00021m-3P; Tue, 17 Oct 2006 16:24:33 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GZprt-0002ic-0Q; Tue, 17 Oct 2006 16:24:33 +0200
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4534E246.10105@op5.se> (Andreas Ericsson's message of "Tue\, 17 Oct 2006 16\:01\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 17 Oct 2006 16:24:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29080>

Andreas Ericsson <ae@op5.se> writes:

> Now I'm really confused. Does bazaar have both "clone" (git-style
> fetching a full repo and all the branches) and "checkout" (cvs-style
> fetching only the working tree)?

Yes, it has both. That's "bzr branch" (git clone) and "bzr checkout"
(cvs checkout).

Difference between "bzr branch" and "git clone" is that bzr doesn't
fetch all the branches. It fetches one "branch" (succession of
revisions) with all the ancestors of the revisions of the branch.

-- 
Matthieu
