From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Display a progress meter during merge-recursive.
Date: Sun, 14 Jan 2007 14:04:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701141404160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
 <20070114052858.GD19113@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 14:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H652h-00017H-KE
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 14:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXANNE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 08:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbXANNE5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 08:04:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:36843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751275AbXANNE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 08:04:57 -0500
Received: (qmail invoked by alias); 14 Jan 2007 13:04:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 14 Jan 2007 14:04:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070114052858.GD19113@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36803>

Hi,

this is a nice idea, but I think you lack a "if (!isatty(1)) do_progress = 
0;" somewhere.

Ciao,
Dscho
