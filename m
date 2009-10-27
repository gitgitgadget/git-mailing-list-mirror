From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 1/4] Add routines for filenames encoding <local encoding>
 <-> UTF-8
Date: Tue, 27 Oct 2009 15:16:59 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0910271515270.17168@ds9.cixit.se>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Timur Sufiev <timur@iris-comp.ru>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2mrF-0003FE-D4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbZJ0OQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbZJ0OQ6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:16:58 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:52275 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751816AbZJ0OQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:16:57 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n9REGx8Y021837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Oct 2009 15:16:59 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n9REGxBJ021833;
	Tue, 27 Oct 2009 15:16:59 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 27 Oct 2009 15:16:59 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131340>

Timur Sufiev:

> The point is to make Git aware of filenames local encoding and make it 
> keep all filenames in UTF-8 internally.

Good.

> If `i18n.filenameslocalencoding' option was set via git-config to a 
> correct <codepage> encoding, 2 things should be done:

Windows supports UTF-16 file names, but need to use wchar_t APIs for fopen() 
and friends. Have you looked at any of that?

-- 
\\// Peter - http://www.softwolves.pp.se/
