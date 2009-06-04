From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Disappearing submissions to vger
Date: Thu, 04 Jun 2009 13:53:46 -0700
Organization: Oracle Linux Engineering
Message-ID: <4A28345A.2080208@oracle.com>
References: <1244148505.6066.1.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 22:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCJtf-0006gL-FY
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 22:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZFDUuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZFDUui
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 16:50:38 -0400
Received: from rcsinet12.oracle.com ([148.87.113.124]:47546 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZFDUuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 16:50:37 -0400
Received: from rgminet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by rgminet12.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n54KoPSn002619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 4 Jun 2009 20:50:26 GMT
Received: from abhmt006.oracle.com (abhmt006.oracle.com [141.146.116.15])
	by rgminet15.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n54KobBd013373;
	Thu, 4 Jun 2009 20:50:37 GMT
Received: from [192.168.1.4] (/71.245.105.176)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 04 Jun 2009 13:50:32 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <1244148505.6066.1.camel@maia.lan>
X-Source-IP: abhmt006.oracle.com [141.146.116.15]
X-Auth-Type: Internal IP
X-CT-RefId: str=0001.0A010209.4A28339C.0007:SCFSTAT5015188,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120709>

Sam Vilain wrote:
> Here are my receipts
> 
> Jun  5 02:25:04 mail postfix/smtp[12125]: 881AD21CE1C:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=499, delays=497/0.01/0.66/1.4, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1757175AbZFDOZA)
> Jun  5 02:31:56 mail postfix/smtp[12834]: E92AC21C155:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=10, delays=0.02/0.02/9.7/0.73, dsn=2.7.0, status=sent (250 2.7.0
> nothing apparently wrong in the message. BF:<H 0>; S1751692AbZFDObx)
> Jun  5 02:32:46 mail postfix/smtp[12946]: D608BFD5FC:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=5.1, delays=0.9/0.01/0.62/3.6, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1752679AbZFDOcm)
> Jun  5 02:32:50 mail postfix/smtp[12955]: 3FA82FD5FD:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=1.3, delays=0.03/0.01/0.63/0.62, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1753489AbZFDOcr)
> Jun  5 02:32:55 mail postfix/smtp[12962]: DE0E421CDB9:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=1.6, delays=0.03/0.01/0.62/0.92, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOcw)
> Jun  5 02:33:00 mail postfix/smtp[12969]: C0D7713E7B7:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=1.9, delays=0.07/0.02/0.62/1.2, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOc5)
> Jun  5 02:33:04 mail postfix/smtp[12969]: C5B8613E7B9:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=2.2, delays=0.05/0/0.62/1.5, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOdB)
> Jun  5 02:33:11 mail postfix/smtp[12955]: 418F513E7BA:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=1.3, delays=0.03/0/0.63/0.67, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOdI)
> Jun  5 02:33:17 mail postfix/smtp[12962]: A31E413E7BB:
> to=<git@vger.kernel.org>, relay=vger.kernel.org[209.132.176.167]:25,
> delay=1.5, delays=0.01/0/0.62/0.91, dsn=2.7.1, status=sent (250 2.7.1
> Looks like Linux source DIFF email.. BF:<H 0>; S1752661AbZFDOdO)
> 
> Where are my posts?

Please ask postmaster@vger.kernel.org .

-- 
~Randy
LPC 2009, Sept. 23-25, Portland, Oregon
http://linuxplumbersconf.org/2009/
