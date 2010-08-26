From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Thu, 26 Aug 2010 09:06:20 +0200
Message-ID: <201008260906.20497.trast@student.ethz.ch>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com> <20100826053439.GB9407@kytes> <20100826054659.GC9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 09:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoWY5-0001o0-Hi
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 09:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab0HZHGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 03:06:44 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:17810 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810Ab0HZHGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 03:06:43 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 26 Aug
 2010 09:06:41 +0200
Received: from thomas.site (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 26 Aug
 2010 09:06:20 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100826054659.GC9708@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154526>

Jonathan Nieder wrote:
> However, if you can think of good names for --undo-no-merges and
> --undo-merges options to "git log", that might be a nice independent
> change for the revision option parser.

--merges={include,only,exclude} or so, and then have --merges be
--merges=only and --no-merges be --merges=exclude?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
