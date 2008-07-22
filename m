From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 0/9] Make gitexecdir relative to $(bindir) on Windows
Date: Tue, 22 Jul 2008 21:31:32 +0200
Message-ID: <200807222131.32828.johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <alpine.DEB.1.00.0807220140170.3407@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 21:34:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLNbi-0008U3-2t
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 21:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbYGVTbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 15:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756758AbYGVTbi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 15:31:38 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:46449 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366AbYGVTbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 15:31:36 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 90CEDBEF4A;
	Tue, 22 Jul 2008 21:31:33 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 19C851D24C;
	Tue, 22 Jul 2008 21:31:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807220140170.3407@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89514>

On Dienstag, 22. Juli 2008, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 21 Jul 2008, Johannes Sixt wrote:
> > The problem was that argv[0] does not have a path in certain cases.
>
> Note that the same holds true for Linux when calling a program that is in
> the PATH:

Oh, boy!

> I imagine that the proper solution would be to rip out lookup_prog() and
> use it for non-Windows Git, too.  Unless you want to limit the usefulness
> of your patch series to Windows, that is.

This certainly goes beyond what I am prepared to do. It is not my itch. The 
series is already much longer than I wanted, when there is a much simpler 
solution that solves *my* problem: to set bindir = $(gitexecdir).

-- Hannes
