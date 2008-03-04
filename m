From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-relink doesn't work on bare repos
Date: Tue, 4 Mar 2008 02:09:59 -0500
Message-ID: <BAYC1-PASMTP07875E628BE4BA7D43175FAE100@CEZ.ICE>
References: <slrnfsp5vi.sa5.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRIb-0004Da-TP
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbYCDHKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761422AbYCDHKG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:10:06 -0500
Received: from bay0-omc2-s11.bay0.hotmail.com ([65.54.246.147]:26588 "EHLO
	bay0-omc2-s11.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760933AbYCDHKF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 02:10:05 -0500
Received: from BAYC1-PASMTP07 ([65.54.191.167]) by bay0-omc2-s11.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 3 Mar 2008 23:10:04 -0800
X-Originating-IP: [70.54.5.51]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.5.51]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 3 Mar 2008 23:10:04 -0800
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JWSDf-0005P8-DV; Tue, 04 Mar 2008 03:09:51 -0500
In-Reply-To: <slrnfsp5vi.sa5.jgoerzen@katherina.lan.complete.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.5; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 04 Mar 2008 07:10:04.0300 (UTC) FILETIME=[C50CB4C0:01C87DC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76040>

On Mon, 3 Mar 2008 18:29:38 -0600
John Goerzen <jgoerzen@complete.org> wrote:

> If I try to point git-relink at a bare repo, I get:
> 
> Usage: /usr/bin/git-relink [--safe] <dir> [<dir> ...] <master_dir>
> All directories should contain a .git/objects/ subdirectory.
> 
> In my case, both master_dir and the CWD are bare repos.
> 
> This is 1.5.4.2

Hi John,

It should probably fixed to work as you would expect.   But if your bare repos
follow the general naming convention of ending in .git  relink will work.  That is,
if your bare repos are named  repo.git  rather than just repo.

HTH,
Sean
