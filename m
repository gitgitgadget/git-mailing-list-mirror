From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git bundle magic, and other questions
Date: Sat, 24 Nov 2007 12:17:32 +0100
Message-ID: <20071124111732.GA2948@steel.home>
References: <200711240033.54953.jnareb@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 12:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivt1H-0001H7-9o
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 12:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbXKXLRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 06:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbXKXLRg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 06:17:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32204 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbXKXLRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 06:17:36 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrGTAQ=
Received: from tigra.home (Fa9d9.f.strato-dslnet.de [195.4.169.217])
	by post.webmailer.de (klopstock mo47) (RZmta 14.3)
	with ESMTP id K002c1jAO7VJYC ; Sat, 24 Nov 2007 12:17:33 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 43487277AE;
	Sat, 24 Nov 2007 12:17:33 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id CAA7956D22; Sat, 24 Nov 2007 12:17:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200711240033.54953.jnareb@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65942>

Jakub Narebski, Sat, Nov 24, 2007 00:33:54 +0100:
> Do there exists some agreed upon common extension for git-bundle, or is 
> it just *.bundle (like *.patch)? Do bundles use some magic identifier;
> can I add something (and what) to the 'magic' file, so "file <bundle>"
> would return "git bundle data" (or equivalent)?

Look into bundle.c:

    static const char bundle_signature[] = "# v2 git bundle\n";
