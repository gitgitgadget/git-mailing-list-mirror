From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 22:46:47 +0200
Message-ID: <20080720204647.GA31432@lars.home.noschinski.de>
References: <7vtzeofjpi.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm> <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com> <7vsku5grpr.fsf@gitster.siamese.dyndns.org> <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org> <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com> <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness> <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com> <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 22:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKfux-00078P-LA
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbYGTUxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYGTUxH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:53:07 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:59017 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbYGTUxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:53:06 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jul 2008 16:53:06 EDT
Received: from [87.78.140.52] (helo=vertikal.home.noschinski.de)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KKfns-0003Mu-Ny; Sun, 20 Jul 2008 22:46:48 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KKfnr-0008EZ-SK; Sun, 20 Jul 2008 22:46:47 +0200
Content-Disposition: inline
In-Reply-To: <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89230>

* Junio C Hamano <gitster@pobox.com> [08-07-20 20:30]:
>So for such people who would find "add -A" useful, "commit -a" will not be
>"unrelated changes in the same commit".  And for such people, I would even
>say "commit -A" would be even more useful, too.

There is one occasion I could use a "add -A": To shorten

     git add -u; git add .; git commit -m "wip"; git checkout $stuff

So in my opinion, if one wants a "stage my whole workdir" option, it
would be suited best as an option to commit (and maybe stash).
