From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-tag HEAD
Date: Mon, 4 Feb 2008 23:30:10 -0500
Message-ID: <BAYC1-PASMTP15D0374A5A075B79E17284AE2C0@CEZ.ICE>
References: <dfb262380802042024p49bfb0c3v689946dba350ac01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ramagudi Naziir" <naziirr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMFSZ-0007uz-9V
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 05:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYBEEaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 23:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYBEEaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 23:30:09 -0500
Received: from bay0-omc2-s6.bay0.hotmail.com ([65.54.246.142]:41496 "EHLO
	bay0-omc2-s6.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752629AbYBEEaI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 23:30:08 -0500
Received: from BAYC1-PASMTP15 ([65.54.191.189]) by bay0-omc2-s6.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 Feb 2008 20:30:07 -0800
X-Originating-IP: [74.15.79.252]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.79.252]) by BAYC1-PASMTP15.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Mon, 4 Feb 2008 20:30:07 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JMGNY-0004wP-LE; Tue, 05 Feb 2008 00:29:56 -0500
In-Reply-To: <dfb262380802042024p49bfb0c3v689946dba350ac01@mail.gmail.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.7; i686-pc-linux-gnu)
X-OriginalArrivalTime: 05 Feb 2008 04:30:07.0516 (UTC) FILETIME=[C95AADC0:01C867AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72622>

On Tue, 5 Feb 2008 06:24:00 +0200
"Ramagudi Naziir" <naziirr@gmail.com> wrote:


> I accidently executed the command "git-tag HEAD" in one of my git repositories.
> 
> Now every command I invoke, i.e. "git-log", begins with the warning:
> 
> "warning: refname 'HEAD' is ambiguous"
> 
> How can I fix this situation ? can I undo what I did ?
> 

Just delete the tag...

$ git tag -d HEAD

HTH,
Sean
