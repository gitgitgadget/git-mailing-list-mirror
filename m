From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-clean buglet
Date: Wed, 23 Jan 2008 16:40:22 +0100
Message-ID: <47975FE6.4050709@viscovery.net>
References: <479759EC.4010002@viscovery.net> <alpine.LSU.1.00.0801231528520.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHhim-0007sU-CU
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 16:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYAWPk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 10:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYAWPk3
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 10:40:29 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3313 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbYAWPk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 10:40:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JHhi4-0006vX-H1; Wed, 23 Jan 2008 16:40:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8205054D; Wed, 23 Jan 2008 16:40:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LSU.1.00.0801231528520.5731@racer.site>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71547>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 23 Jan 2008, Johannes Sixt wrote:
> 
>> Try this in your favorite git repo:
>>
>>     git clean -n /
> 
> That's an absolute path.  Like almost _all_ git commands, clean only 
> takes relative ones.  You probably meant "git clean -n".

I know it's an absolute path, but, no, I said

     git clean -n \*.vcproj

on Windows, which the MinGW port internally transforms into

     git clean -n /*.vcproj

(which was not exactly what I meant, but that's a different story).
And this also reports, just like on Linux:

     fatal: oops in prep_exclude

There remain the questions whether we want to do something about absolute
paths in general or this oops in particular.

-- Hannes
