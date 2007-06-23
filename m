From: David Watson <dwatson@mimvista.com>
Subject: egit (eclipse plugin) now knows how to make commits
Date: Fri, 22 Jun 2007 21:58:17 -0400
Message-ID: <2031DD44-9988-452D-9919-3167387A3813@mimvista.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 03:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1usH-0000nd-56
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 03:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbXFWB5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 21:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbXFWB5D
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 21:57:03 -0400
Received: from ms-smtp-05.ohiordc.rr.com ([65.24.5.139]:34304 "EHLO
	ms-smtp-05.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbXFWB5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 21:57:00 -0400
Received: from [192.168.1.10] (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by ms-smtp-05.ohiordc.rr.com (8.13.6/8.13.6) with ESMTP id l5N1utX3028299;
	Fri, 22 Jun 2007 21:56:56 -0400 (EDT)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50717>

Egit, the eclipse git plugin now has the ability to make commits. 99%  
of the credit belongs to spearce and robin, as most of my work has  
been on hooking it into the GUI.

Please note that at this point any commits made will have a fake name/ 
email, because we don't read the git config files at present. Also,  
this is not extensively tested, but appears to work with what I've  
used it on so far. Currently, it will only commit changes that are  
already in the index.

Pull from pu at git://dwatson.mimvista.com/egit.git

--
David Watson
QuercusMax on #git
