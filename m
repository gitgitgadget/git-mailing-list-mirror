From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Integrating with hooks
Date: Thu, 15 Nov 2007 08:57:42 +0100
Message-ID: <473BFBF6.7070902@viscovery.net>
References: <20071113173721.GI25282@penguin.codegnome.org>	<fhdane$kfs$1@ger.gmane.org> <20071115011837.GD32746@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam@codegnome.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:58:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZbw-0004Sz-Uh
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbXKOH5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbXKOH5s
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:57:48 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3672 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbXKOH5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:57:47 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IsZb3-0004yH-TP; Thu, 15 Nov 2007 08:57:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BEF4D6C4; Thu, 15 Nov 2007 08:57:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071115011837.GD32746@penguin.codegnome.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65079>

Todd A. Jacobs schrieb:
> On Wed, Nov 14, 2007 at 12:07:29AM +0100, Jakub Narebski wrote:
> 
>> Take a look at gitattributes(5), namely 'filter' attribute.
> 
> Thanks, I took a look at the man page you suggested. The "ident" feature
> almost does what I want, but doesn't seem to take any sort of format
> string. So, I thought I'd explore "filter," but can't really find any
> examples of how to implement the smudge and clean commands, which seem
> to be what I'm really trying to do here.

A clean and smudge filter processes one file at a time. It reads the old 
content from stdin and writes the result to stdout.

There is a tiny example in the test suite, t/t0021-conversion.sh, look for 
rot13.sh.

-- Hannes
