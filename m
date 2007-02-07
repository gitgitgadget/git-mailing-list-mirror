From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 16:14:06 +0100
Message-ID: <45C9ECBE.6010705@xs4all.nl>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702071559340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 16:14:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEoUr-0007LH-GJ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 16:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355AbXBGPOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 10:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161356AbXBGPOA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 10:14:00 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:2604 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161355AbXBGPN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 10:13:59 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17FDucf056509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 16:13:56 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <Pine.LNX.4.63.0702071559340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38930>

Johannes Schindelin escreveu:
> Hi,
> 
> On Wed, 7 Feb 2007, Johannes Schindelin wrote:
> 
>> On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:
>>
>>> I don't actually have a windows copy, so it's basically untested.
>>> However, I did succeed in running rev-list in wine.
>> I played a little with it. IMHO it makes no sense to use it without a 
>> bash, and without less.
> 
> Side note: Since "ln <src> <dest>" in MinGW is really a copy, not a hard 
> link, this gets rather big (44M here).
> 
> Which makes me think if we should just disallow the "git-<builtin>" on 
> Windows, since sooner or later, Git will no longer be used from the 
> command line on Windows.
> 
> And another thing hit me there: Are you sure that all works well if you 
> change the install path from "C:\Program Files\Git" to something else?
> Without explicitely setting GIT_EXEC_PATH?

I have no idea. The installer just plonks the files into C:/P F/Git/
and adds that to $INSTALLDIR/usr/bin/ to $PATH


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
