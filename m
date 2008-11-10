From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly faster on windows.
Date: Mon, 10 Nov 2008 10:46:01 +0100
Message-ID: <200811101046.01543.simon@lst.de>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au> <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au> <7vr65kagvm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Han-Wen Nienhuys" <hanwen@google.com>,
	John Chapman <thestar@fussycoder.id.au>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 10:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTND-0005U5-FR
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 10:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbYKJJq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 04:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbYKJJq1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 04:46:27 -0500
Received: from verein.lst.de ([213.95.11.210]:36973 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYKJJq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 04:46:26 -0500
Received: from rhea.localnet ([62.70.27.104])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mAA9juIF027591
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Nov 2008 10:46:01 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; x86_64; ; )
In-Reply-To: <7vr65kagvm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Spam-Score: 0.001 () BAYES_50
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100502>

On Sunday 09 November 2008 Junio C Hamano, wrote:
> These are patches to fast-import/git-p4, which you two seem to in charge
> of.
>
>     From:	John Chapman <thestar@fussycoder.id.au>
>     Subject: [PATCH 1/2] Added support for purged files and also optimised
> memory usage. Date:	Sat,  8 Nov 2008 14:22:48 +1100
>     Message-Id: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
>
>     From:	John Chapman <thestar@fussycoder.id.au>
>     Subject: [PATCH 2/2] Cached the git configuration, which is now
> noticibly faster on windows. Date:	Sat,  8 Nov 2008 14:22:49 +1100
>     Message-Id: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
>
> It was unfortunately not immediately obvious from the Subject: line what
> these patches are about, and I am guessing you missed them because of that.

Ack on both patches. The second one could be done better, as suggested in the 
follow-ups, but both are clearly an improvement :)


Simon
