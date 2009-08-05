From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Message from git reset: confusing?
Date: Wed, 05 Aug 2009 17:25:23 +0200
Message-ID: <vpqab2e7064.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 17:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYiN2-0008O6-94
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 17:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZHEPZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 11:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbZHEPZ3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 11:25:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38991 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbZHEPZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 11:25:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n75FNIpc004109
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Aug 2009 17:23:18 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYiMl-0003Zi-GU; Wed, 05 Aug 2009 17:25:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYiMl-0002oj-F5; Wed, 05 Aug 2009 17:25:23 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 05 Aug 2009 17:23:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n75FNIpc004109
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250090598.32374@F+6aqdeS7D2VgNHV8ecRtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124913>

Hi,

I was wondering what was the motivation for the output of "git merge":

$ git reset file
file: locally modified
$ 

I find this message misleading, since it gives me the feeling that
"git reset" errored out because of the file being locally modified (I
also got the remark from a git beginner to whom I was showing the
command: "hey, why didn't it work??").

And indeed, I do not understand the motivation for showing this
message. When I stage content (git add), Git tells me nothing, so why
should it do so when I unstage content? If I want to know the state of
the index after running reset, I'll run "git status" myself ...

I'd suggest adding a -v|--verbose flag to git reset, and default to
being quiet (the already existing -q flag would still be used, to
disable progress indicator). What do other people think?

-- 
Matthieu
