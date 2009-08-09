From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 0/5] Re: {checkout,reset,stash} --patch
Date: Sun, 9 Aug 2009 18:44:41 +0200
Message-ID: <200908091844.43107.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <200908091117.19167.trast@student.ethz.ch> <20090809163233.GA12911@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Aug 09 18:45:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaBWB-00055P-Tt
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 18:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbZHIQpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZHIQo7
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 12:44:59 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:7876 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbZHIQo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 12:44:59 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 18:44:58 +0200
Received: from thomas.localnet (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 18:44:58 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090809163233.GA12911@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125353>

Nicolas Sebrecht wrote:
> 
> Also, I'd expect to have 'git reset --hard -p' discarding hunks from
> both the index and the WT (which is not possible for now unless I missed
> something).

Well, the unfortunate overlap between 'git reset --hard' and 'git
checkout HEAD -- .' strikes again :-)

Since you can't say 'git reset --hard -- file', you have to do 'git
checkout HEAD -- file' to achieve this effect.  So this usage is
covered by 'git checkout -p HEAD'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
