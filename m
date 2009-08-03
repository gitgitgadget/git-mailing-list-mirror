From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: conflict status
Date: Mon, 3 Aug 2009 20:17:33 +0200
Message-ID: <200908032017.35101.trast@student.ethz.ch>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net> <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Wild <themiwi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY270-0004Cm-Nc
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbZHCSSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZHCSSJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:18:09 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:53418 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783AbZHCSSI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:18:08 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 3 Aug
 2009 20:18:07 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 3 Aug
 2009 20:17:45 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124713>

You wrote:
> Heya,
> 
> On Mon, Aug 3, 2009 at 08:14, Michael Wild<themiwi@users.sourceforge.net> wrote:
> > Generally speaking, I would like to know for each file with a conflict what
> > it's status is, similar to what SVN does:
> > - locally modified/created/deleted/...
> > - remotely modified/created/deleted/...
> 
> Try 'git status' :),

That only shows 'unmerged: foo' for me...

The closest to porcelain I can get while still having all the
information is

  $ git ls-files -s foo
  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1       foo
  100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 2       foo

In other words, not porcelain at all.

The third column is the stage: 1 for base, 2 for ours, 3 for theirs.
So the above means that the file was changed between base and ours,
and removed between base and theirs (as the entry is missing).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
