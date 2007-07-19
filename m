From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Proposal about --help options and man calls
Date: Thu, 19 Jul 2007 18:42:30 +0800
Message-ID: <469F4016.9090402@midwinter.com>
References: <85y7hdwfds.fsf@lola.goethe.zz> <7v644h715y.fsf@assigned-by-dhcp.cox.net> <85ejj5wats.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 12:42:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTSw-000811-AK
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbXGSKme (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbXGSKme
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:42:34 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:52173
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752278AbXGSKmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:42:33 -0400
Received: (qmail 17167 invoked from network); 19 Jul 2007 10:42:33 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=vkmSqmDhhL4zRIfjg0vbcjQniOBu6IfyMN3PkEebunPpLQqvGZHL80LegcCsJnrL  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 19 Jul 2007 10:42:32 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <85ejj5wats.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52962>

David Kastrup wrote:
> So I set GIT_PAGER to cat and hoped that it would get git to behave. 

FYI, you can also set GIT_PAGER to an empty value to completely disable 
paging. However, "cat" does the same thing -- it is special cased in 
pager.c to do the same thing as an empty value.

Hmm, I guess that could stand to be documented. Patch forthcoming.

-Steve
