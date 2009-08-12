From: Peter Krefting <peter@softwolves.pp.se>
Subject: Meta data available to filters?
Date: Wed, 12 Aug 2009 07:59:00 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908120755050.30907@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 08:59:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb7nj-0004b9-2l
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 08:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZHLG7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 02:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbZHLG7A
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 02:59:00 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:41533 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753111AbZHLG67 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 02:58:59 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7C6x08S031382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Aug 2009 08:59:00 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7C6x0dJ031378;
	Wed, 12 Aug 2009 08:59:00 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 12 Aug 2009 08:59:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125673>

Hi!

If I set up a filter, is there a way from my filter script to know the name 
or identity of the file that I am processing?

I get the data on standard in and output the changed data on standard out, 
but is there any way to get access to meta data?


I find the documentation on filters a bit terse. Once I figure out how they 
actually work, I may be inclined to send a documentation patch. A minimum 
would be to document their existence on the git-config manual page (with 
reference to gitattributes), it took me some time to find it :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
