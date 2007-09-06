From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/9] Add strbuf_read_path().
Date: Thu, 6 Sep 2007 17:40:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061739090.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com> <11890382252522-git-send-email-krh@redhat.com>
 <1189038225525-git-send-email-krh@redhat.com> <11890382262161-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1294440106-1189096802=:28586"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:40:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKP3-0006Tv-6a
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXIFQkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbXIFQkS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:40:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:52914 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751300AbXIFQkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:40:17 -0400
Received: (qmail invoked by alias); 06 Sep 2007 16:40:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 06 Sep 2007 18:40:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UhF1iWssUFARCNwF9lrXL+nH2bv0eE+vlwPIAqe
	cw7T/r5NHfvlqD
X-X-Sender: gene099@racer.site
In-Reply-To: <11890382262161-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57905>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1294440106-1189096802=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 5 Sep 2007, Kristian Høgsberg wrote:

> +extern int strbuf_read_path(struct strbuf *sb, const char *path);

May I suggest renaming this to "strbuf_read_file()"?  I kind of expected a 
function which reads in the absolute path of a file, judging by the 
name...

Ciao,
Dscho

--8323584-1294440106-1189096802=:28586--
