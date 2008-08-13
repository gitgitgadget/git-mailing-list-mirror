From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Local uncommitted changes, not checked in to index with gitk
Date: Wed, 13 Aug 2008 15:49:40 +0200
Message-ID: <vpq63q5autn.fsf@bauges.imag.fr>
References: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com>
	<vpqljz1cfkm.fsf@bauges.imag.fr>
	<ace3f33d0808130553g318ce97gf654c3f998d4047a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 15:51:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTGkV-0001Ck-Uk
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 15:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYHMNtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 09:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYHMNtr
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 09:49:47 -0400
Received: from imag.imag.fr ([129.88.30.1]:64252 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbYHMNtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 09:49:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7DDne8E012464
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2008 15:49:40 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KTGjM-0000hy-OV; Wed, 13 Aug 2008 15:49:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KTGjM-0001m7-M4; Wed, 13 Aug 2008 15:49:40 +0200
In-Reply-To: <ace3f33d0808130553g318ce97gf654c3f998d4047a@mail.gmail.com> (srinivas naga vutukuri's message of "Wed\, 13 Aug 2008 18\:23\:41 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 13 Aug 2008 15:49:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92215>

"srinivas naga vutukuri" <srinivas.vutukuri@gmail.com> writes:

> Actually am doing around the 2.6 linux kernel git, and once cloned
> using rsync url
> and then done couple of times the git pull, to sync to the latest to the remote.
>
> I just done "git status", Its giving the following output. But i
> have't done around these files anything at all, not opened, etc.

You probably updated the .git/ directory without updating the working
tree. Normally, "git pull" does not do that, so I don't know what's
wrong.

Can you provide exactly the way to reproduce? i.e. stg like

$ git status
# nothing
$ git pull
$ git status
# something

-- 
Matthieu
