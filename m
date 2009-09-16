From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: self contained executable
Date: Wed, 16 Sep 2009 18:51:01 +0200
Message-ID: <vpqy6oedea2.fsf@bauges.imag.fr>
References: <ED42F58A-A814-467B-A37D-B485B2E267ED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joel Saltzman <saltzmanjoelh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnxiv-0007Xs-Us
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 18:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbZIPQvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 12:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbZIPQvF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 12:51:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47073 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbZIPQvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 12:51:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8GGmCcV004696
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 18:48:12 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mnxif-0002n9-Ex; Wed, 16 Sep 2009 18:51:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mnxif-0007QF-DW; Wed, 16 Sep 2009 18:51:01 +0200
In-Reply-To: <ED42F58A-A814-467B-A37D-B485B2E267ED@gmail.com> (Joel Saltzman's message of "Wed\, 16 Sep 2009 00\:45\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Sep 2009 18:48:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8GGmCcV004696
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253724494.27386@vRhEbp4DS8s4e9SbETmmlQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128665>

Joel Saltzman <saltzmanjoelh@gmail.com> writes:

> is it possible to compile git with all its dependencies so I can run
> it on a server that does not have root access?

Compiling with LDFLAGS='-static' is a first step, I'm not sure it's
sufficient.

But as Alex already pointed out, you don't have to be root to install
Git anyway (I'm using a git that I compiled myself, without being root
on my machine).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
