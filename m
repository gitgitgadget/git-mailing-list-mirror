From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: How to diff 2 file revisions with gitk
Date: Wed, 06 Feb 2013 19:09:06 +0100
Message-ID: <51129C42.4040207@kdbg.org>
References: <1360164008.49200.YahooMailNeo@web171204.mail.ir2.yahoo.com> <1360166273.33888.YahooMailNeo@web171204.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "R. Diez" <rdiezmail-buspirate@yahoo.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 19:09:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39R9-0005Zp-AY
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab3BFSJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:09:13 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:53500 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755334Ab3BFSJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:09:11 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 804E71001C;
	Wed,  6 Feb 2013 19:09:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id DE46F19F459;
	Wed,  6 Feb 2013 19:09:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <1360166273.33888.YahooMailNeo@web171204.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215606>

Am 06.02.2013 16:57, schrieb R. Diez:
> I would like to start gitk, select with the mouse 2 
> revisions of some file and then compare them, hopefully with an external
>  diff tool, very much like I am used to with WinCVS.
> 
> The closest I
>  got is to start gitk with a filename as an argument, in order to 
> restrict the log to that one file. Then I right-click on a commit (a 
> file revision) and choose "Mark this commit". However, if I right-click 
> on another commit and choose "Compare with marked commit", I get a full 
> commit diff with all files, and not just the file I specified on the 
> command-line arguments.

Edit->Preferences, tick 'Limit diff to listed paths'.

-- Hannes
