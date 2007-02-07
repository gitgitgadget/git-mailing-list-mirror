From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 16:08:04 +0100
Message-ID: <45C9EB54.3040406@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 16:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEoP4-0004Z7-0w
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 16:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbXBGPIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 10:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161355AbXBGPIG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 10:08:06 -0500
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:4036 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161353AbXBGPIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 10:08:05 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17F7rav078567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 16:07:53 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38929>

Johannes Schindelin escreveu:
>> I don't actually have a windows copy, so it's basically untested.
>> However, I did succeed in running rev-list in wine.
> 
> I played a little with it. IMHO it makes no sense to use it without a 
> bash, and without less. For example,
> 
> 	$ git init
> 	$ git add git.exe
> 	$ git status
> 	$ git commit -a -m initial
> 	$ git show HEAD
> 
> do not produce any output when issued in cmd.
> 
> Also, many scripts rely on bash and/or perl, so you'd have to include 
> them, too.

Indeed: for now, this is intended for people clueful enough to install
bash and perl on their own.  Adding bash itself should be easy, but
I have no idea how to make cmd open the scripts with bash automatically.

The thought of x-compiling perl makes me shudder. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
