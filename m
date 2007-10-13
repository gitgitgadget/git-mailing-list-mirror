From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sun, 14 Oct 2007 00:23:12 +0200
Message-ID: <47114550.6070505@gmx.ch>
References: <471045DA.5050902@gmail.com>	 <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>	 <20071013172745.GA2624@coredump.intra.peff.net>	 <20071013175127.GA3183@coredump.intra.peff.net>	 <47112491.8070309@gmail.com>	 <8DDFBF9A-2C68-404B-843C-BE63C52F0DAF@wincent.com> <cff973550710131450r3b54a328k8db97488f4b50e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Dan Z <dzwell@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 00:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgpOL-0002OH-Sj
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbXJMWXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 18:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757739AbXJMWXQ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 18:23:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:54330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753626AbXJMWXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 18:23:15 -0400
Received: (qmail invoked by alias); 13 Oct 2007 22:23:13 -0000
Received: from 123-188.0-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.0.188.123]
  by mail.gmx.net (mp004) with SMTP; 14 Oct 2007 00:23:13 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1+umfMxJKau7YSu86PYMdPLye0HYeoI13HrBjNRNF
	NDySihZ5u7rpy/
User-Agent: Thunderbird 2.0.0.6 (X11/20070805)
In-Reply-To: <cff973550710131450r3b54a328k8db97488f4b50e2a@mail.gmail.com>
X-Enigmail-Version: 0.95.3
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60782>

Dan Z wrote:
> I think color.add is better, because git-add--interactive goes beyond
> coloring diffs. When this is complete, it should probably use
> color.diff.<slot> for the actual diff output, and color.add.<slot> for
> colored prompts/commands.

Or maybe rather color.interactive.<slot>, where <slot> could be
'prompt', 'header', etc.  It's better to give it a name that
describes what it is for, instead of one that describes which tool
uses it.  This way it could possibly be used for other potential
interactive tools in the future.

jlh
