From: Jens Seidel <jensseidel@users.sf.net>
Subject: Bug: "git-svn fetch" segfaults on unknown user
Date: Thu, 6 Nov 2008 15:38:31 +0100
Message-ID: <20081106143826.GA26900@merkur.sol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 15:40:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky62L-0003h9-Ab
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 15:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYKFOj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 09:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbYKFOj1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 09:39:27 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:42783 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYKFOj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 09:39:26 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 52013F3F41DE
	for <git@vger.kernel.org>; Thu,  6 Nov 2008 15:39:25 +0100 (CET)
Received: from [77.179.124.209] (helo=merkur.sol.de)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1Ky616-0002Z1-00
	for git@vger.kernel.org; Thu, 06 Nov 2008 15:39:25 +0100
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1Ky60F-00070O-M5
	for git@vger.kernel.org; Thu, 06 Nov 2008 15:38:31 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Sender: tux-master@web.de
X-Provags-ID: V01U2FsdGVkX1/51c3BYZm6E21NQk78fns6p/xKIdhPPoPxpNq2
	eBego+XDqKB62gRH6LH3yLBp7+fUGaxcGU2zYUfb68Kq7x/uZq
	pX8IUd0nw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100237>

Hi,

I noticed the following bug in git-svn version 1.6.0.3 (svn 1.5.5):

"git-svn fetch" segfaults if I provide an incomplete svn.authorsfile config
file setting with account<-->email mappings. This happens if an unknown user
account is found in the Subversion log.

If I do not provide svn.authorsfile at all, it doesn't crash.

Jens
