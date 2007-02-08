From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Thu, 08 Feb 2007 11:14:49 +0100
Message-ID: <45CAF819.1060100@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C9EB54.3040406@xs4all.nl> <45CADAAA.74058D21@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 11:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF6Iq-0002Ng-C5
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 11:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423169AbXBHKOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 05:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423175AbXBHKOn
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 05:14:43 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:1609 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423169AbXBHKOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 05:14:42 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id l18AEcmU056832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Feb 2007 11:14:39 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <45CADAAA.74058D21@eudaptics.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39052>

Johannes Sixt escreveu:

> 
> 
> in place of the usual "#!/bin/sh". It requires you to have a command
> named @echo.exe in the path that is a noop. Also, it is limited to 9
> command line arguments.

not mention that it will severly mess up if there are quoted arguments
and/or spaces

 git commit -m "this has a space" -a

It might be possible to do 

  sh "%0" "%1" .. 

but to make things interesting, different releases of windows have different
rules for CMD shell quoting.

Experience with LilyPond taught us to avoid the CMD shell at all costs. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
