From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Fri, 31 Oct 2008 17:55:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810311753080.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vtzatdbtk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:49:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxBK-0007Zv-OS
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbYJaQrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYJaQrq
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:47:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55653 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751387AbYJaQrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:47:45 -0400
Received: (qmail invoked by alias); 31 Oct 2008 16:47:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 31 Oct 2008 17:47:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NY5RsmlWNu18bQrtP1vPsmWVZbmF0k9NMnkrgpE
	1T4h8D9qJVMRTk
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vtzatdbtk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99602>

Hi,

On Thu, 30 Oct 2008, Junio C Hamano wrote:

> I wonder if it would help breaking down cmd_log_init() a bit like this.

Sorry, I am quite busy (this is the first time I am able to check my mail 
since the GitTogether), so I cannot look at that in detail.

However, I strongly expect your suggestion not to help: for showing 
commits, we _want_ recursive to be the default.  And switching that on 
devoids us from being able to DIFF_OPT_TST(.., RECURSIVE) to detect if the 
user said '-r' _explicitely_.

Ciao,
Dscho
