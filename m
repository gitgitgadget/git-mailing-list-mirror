From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: MinGW binary installer available
Date: Thu, 8 Feb 2007 22:15:50 +0100
Organization: Dewire
Message-ID: <200702082215.50389.robin.rosenberg.lists@dewire.com>
References: <45C9E470.7030609@xs4all.nl> <45C9EB54.3040406@xs4all.nl> <45CADAAA.74058D21@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGbp-0001GX-BD
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423396AbXBHVO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423401AbXBHVO5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:14:57 -0500
Received: from [83.140.172.130] ([83.140.172.130]:24891 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1423397AbXBHVOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:14:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 997E9803393;
	Thu,  8 Feb 2007 22:10:06 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29076-03; Thu,  8 Feb 2007 22:10:06 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 58A5C800199;
	Thu,  8 Feb 2007 22:10:04 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <45CADAAA.74058D21@eudaptics.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39093>

torsdag 08 februari 2007 09:09 skrev Johannes Sixt:
> 
> @echo off
> rem () { :; } ; : \
> sh %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
> rem ; : \
> exit /B %ERRORLEVEL%
> 
> 
> in place of the usual "#!/bin/sh". It requires you to have a command
> named @echo.exe in the path that is a noop. Also, it is limited to 9
> command line arguments.
> 
> What a hack! (*)

Yes... I suggest you use %* to pass on all arguments. It works with more than 10
arguemtns, including quoted arguemnts (presumably whatever limit windows has)

-- robin
