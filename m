From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 10:48:58 +0100
Message-ID: <201001201049.01108.trast@student.ethz.ch>
References: <20100120050343.GA12860@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 10:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXXCA-0000bi-Jh
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab0ATJtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547Ab0ATJtZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:49:25 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:59874 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab0ATJtY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:49:24 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Wed, 20 Jan
 2010 10:49:22 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Wed, 20 Jan
 2010 10:49:00 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100120050343.GA12860@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137533>

Joey Hess wrote:
> Just a quick note that the new notes feature can break things that parse
> git log.

Umm.  git-log is porcelain and we're allowed to change it.  Worse,
even the user can change it in very significant ways, just try:

  git config format.pretty email
  git log

For a better alternative, I'm afraid you'll either have to look to
git-rev-list (which also takes --pretty) or 'git cat-file --batch'.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
