From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 22:19:05 -0300
Message-ID: <466DF489.7010700@xs4all.nl>
References: <20070608202236.GJ25093@menevado.ms.com> <200706112042.16331.simon@lst.de> <20070611201232.GA4649@steel.home> <200706112346.13628.simon@lst.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 03:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxv5I-0001HL-6N
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 03:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXFLBWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 21:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbXFLBWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 21:22:09 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3198 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbXFLBWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 21:22:08 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l5C1Lwen011112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2007 03:22:05 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200706112346.13628.simon@lst.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49908>

Simon Hausmann escreveu:
>>             system("p4 revert %s" % f)
>>             system("p4 delete %s" % f)
> 
> Ooops, indeed. Makes me realizes that I've never actually submitted files with 
> spaces in the name :). For now I've quoted them with double quotes like in 
> the other places, which is better than nothing. Thanks for spotting!

>>> import commands
>>> commands.mkarg ('$foo bar')
" '$foo bar'"


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
