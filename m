From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [bug] gitk can not read history if diff color is enabled
Date: Sat, 13 Oct 2007 16:49:51 +0200
Message-ID: <200710131649.51496.barra_cuda@katamail.com>
References: <4710D3AA.8000502@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, msharov@users.sourceforge.net
X-From: git-owner@vger.kernel.org Sat Oct 13 16:46:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiFy-00024O-82
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762591AbXJMOqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 10:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762473AbXJMOqK
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:46:10 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:46215 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762426AbXJMOqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 10:46:08 -0400
Received: from host88-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.88]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.88+NOIIOKR4wHHh; Sat, 13 Oct 2007 16:46:06 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <4710D3AA.8000502@softhome.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Saturday 13 October 2007, Mike Sharov wrote:
> Reproduced in git version 1.5.3.4.217.gbfc1, although it's been this way
> for a while. To see the bug, enable color diff with
> 
> [diff]
> color
> 
> and launch gitk on any repository (like the Linux kernel tree). The
> result is a dialog box "Can't parse git log output '\x1b[33mcommit" etc.
> qgit can still view the history without errors, so I guess it must be
> possible to somehow turn off color for a specific query.

A patch was posted, and is queued here:

	http://hjemli.net/git/git/commit/?h=q/mb/gitk/log--no-color
