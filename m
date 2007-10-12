From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 13:05:14 +0200
Message-ID: <470F54EA.4000305@viscovery.net>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk> <Pine.LNX.4.64.0710112144380.4174@racer.site> <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se> <Pine.LNX.4.64.0710121057540.25221@racer.site> <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 12 13:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgIKm-0003CR-W5
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbXJLLFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbXJLLFW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:05:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:52173 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbXJLLFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:05:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IgIKM-0001sq-Ac; Fri, 12 Oct 2007 13:05:11 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 058134E4; Fri, 12 Oct 2007 13:05:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60672>

Peter Karlsson schrieb:
>> If it's not what you want, I suggest rethinking what you want ;-)
>> Otherwise it is scripting time for you.  It's easy enough with git.
> 
> That's what I'm trying to figure out. I assume it would be possible to
> do with some kind of hook that is run on checkout. But I can't figure
> out how to do that.

Read about the 'filter' attribute (clean and smudge filters), e.g. here:
http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

This is the place to tie a script to checkouts. How the scripts derive the 
information that they put in the checked-out files, is a different matter.

-- Hannes
