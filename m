From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote: do not use user input in a printf format
 string
Date: Mon, 22 Sep 2008 14:41:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809221440590.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1222081405-12113-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Sep 22 14:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhkeY-0007JW-Db
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 14:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYIVMfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 08:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbYIVMfZ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 08:35:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:35802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751069AbYIVMfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 08:35:25 -0400
Received: (qmail invoked by alias); 22 Sep 2008 12:35:22 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 22 Sep 2008 14:35:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ta1cb8QvTRyAvDjzOXRbaa+PodYlsMXoyXb6jPR
	ymv5KTzhVmc9Ct
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1222081405-12113-1-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96477>

Hi,

On Mon, 22 Sep 2008, Johannes Sixt wrote:

> 'git remote show' substituted the remote name into a string that was 
> later used as a printf format string. If a remote name contains a printf 
> format specifier like this:
> 
>    $ git remote add foo%sbar .
> 
> then the command
> 
>    $ git remote show foo%sbar
> 
> would print garbage (if you are lucky) or crash. This fixes it.

Thanks,
Dscho
