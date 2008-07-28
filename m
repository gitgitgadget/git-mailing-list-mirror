From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding custom hooks to a bare repository.
Date: Mon, 28 Jul 2008 13:26:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281324350.2725@eeepc-johanness>
References: <18071eea0807280404w3365748cjcd11f536bf5d27eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:26:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQrc-0004Rq-IS
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbYG1LZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYG1LZE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:25:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:38940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751070AbYG1LZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:25:03 -0400
Received: (qmail invoked by alias); 28 Jul 2008 11:25:01 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp050) with SMTP; 28 Jul 2008 13:25:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/+jsPkLO/vre5C3Ks8F3kc2NCWvD2Pvqplukqhb
	JuN2eMaeotYJJ+
X-X-Sender: user@eeepc-johanness
In-Reply-To: <18071eea0807280404w3365748cjcd11f536bf5d27eb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90443>

Hi,

On Mon, 28 Jul 2008, Thomas Adam wrote:

> I'm trying to add in "post-merge" as a valid hook file to an already 
> created --bare repository.  In adding it to the correct place and 
> setting the correct permissions on it (the repository is a shared one), 
> it doesn't seem to be pulled down with the other hook files already 
> present when doing a "git clone".
> 
> Any ideas why?

Yes.  Hooks, just as the config and reflogs, are supposed to be local 
things.  Rationale being: it is rude, and also insecure, to install 
something that potentially calls other programs without the user saying 
so.

All you can do is checking in a copy of the hook, and ask your users/check 
in your build system that it is installed.

Hth,
Dscho
