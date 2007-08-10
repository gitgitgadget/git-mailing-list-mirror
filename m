From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 15:00:34 -0700 (PDT)
Message-ID: <559166.44497.qm@web38913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>,
	Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJcXx-0000Hg-9c
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 00:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbXHJWAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbXHJWAi
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 18:00:38 -0400
Received: from web38913.mail.mud.yahoo.com ([209.191.125.119]:34970 "HELO
	web38913.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755363AbXHJWAf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 18:00:35 -0400
Received: (qmail 44504 invoked by uid 60001); 10 Aug 2007 22:00:34 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=4bV4Yz/NIUjZv1c8qowLD4VhzWkhZiRFI2KJVXoCyGX0m0iFlJ88JuhJaIIyGspkS289++aB7wh8JM9GLi0GFCVMlSC8LNz/mX5+HpDaDdy/vf1oCK8Ba8LjJx7zvxW6macrdGBxUlXQEk09EVn0+6Qjr3G17ZLFsY5aD0m981g=;
X-YMail-OSG: _cscJtIVM1ni2KW2Ud.PbgrGyXmfMNaeFoOrQe4.WmBE6xxcbIETmFPV0au3mH.lPjAM9tqvlF53zkv4xxu2cC3Bx_BBRhi3WkAKWQ4azsuI4EZ_93cJTKpYG3yFUA--
Received: from [128.251.102.204] by web38913.mail.mud.yahoo.com via HTTP; Fri, 10 Aug 2007 15:00:34 PDT
X-Mailer: YahooMailRC/651.48 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55573>

> 
> btw, does someone know, where stderr of wish is piped to.
> It doesn't appear on the mingw console, which makes debugging
> more challenging.
> 

"wish" redirects it. If you want to see it, you need to add a "console show" command near the top of the script. Another way around this, is to have tclsh as the program, and do a "package require Tk"

HTH,
    --brett




       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC
