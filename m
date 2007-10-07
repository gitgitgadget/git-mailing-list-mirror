From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 7 Oct 2007 17:38:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071737500.4174@racer.site>
References: 20071007011331.GC5642@mediacenter.austin.rr.com
 <1191719841666-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, frank@lichtenheld.de, gitster@pobox.com
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZA4-0005m7-H4
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbXJGQjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbXJGQjP
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:39:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:34948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751872AbXJGQjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:39:14 -0400
Received: (qmail invoked by alias); 07 Oct 2007 16:39:12 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp031) with SMTP; 07 Oct 2007 18:39:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u5ZMoT6vuOdtVcXUzyYU6kWjRoEYpkDweLvwqjE
	K9TTS2yqhFdcms
X-X-Sender: gene099@racer.site
In-Reply-To: <1191719841666-git-send-email-shawn.bohrer@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60196>

Hi,

On Sat, 6 Oct 2007, Shawn Bohrer wrote:

> +static int remove_directory(const char *path)

Please use remove_directory_recursively(), introduced in commit 
7155b727c9baae9ef6d7829370aefc09c4ab64e2 to 'next'.

I have not looked at the rest of your patch yet.

Ciao,
Dscho
