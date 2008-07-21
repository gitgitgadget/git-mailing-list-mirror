From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 07:07:15 +0200
Message-ID: <5226AAB4-379A-4C44-870A-6040A61C66C1@zib.de>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com> <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com> <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <7v63r0bejy.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807202035090.3305@eeepc-johanness> <7vhcak5o6n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 07:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKndM-00079q-5J
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 07:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760303AbYGUFH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 01:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760290AbYGUFH2
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 01:07:28 -0400
Received: from mailer.zib.de ([130.73.108.11]:49259 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760288AbYGUFH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 01:07:27 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6L56pvX013265;
	Mon, 21 Jul 2008 07:06:56 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db92842.pool.einsundeins.de [77.185.40.66])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6L56nKf011969
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 21 Jul 2008 07:06:50 +0200 (MEST)
In-Reply-To: <7vhcak5o6n.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89301>


On Jul 20, 2008, at 9:51 PM, Junio C Hamano wrote:

> I do not know if "plink" is used widely enough to be special cased,  
> but if
> so, I think we would better have an explicit support for it.

Our installer on Windows explicitly supports plink as an alternative to
OpenSSH.  Putty has a GUI for managing your ssh keys (Pageant).  You  
need
to type your password only once to unlock a key and make it available to
all connections that you start afterwards.

I think it should be special cased.  I use plink myself.

	Steffen
